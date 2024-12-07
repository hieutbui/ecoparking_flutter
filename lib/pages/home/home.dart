import 'dart:async';
import 'dart:math' hide Point;
import 'package:collection/collection.dart';
import 'package:ecoparking_flutter/app_state/failure.dart';
import 'package:ecoparking_flutter/app_state/success.dart';
import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/config/route_change_notifier.dart';
import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:ecoparking_flutter/di/supabase_utils.dart';
import 'package:ecoparking_flutter/domain/services/account_service.dart';
import 'package:ecoparking_flutter/domain/services/booking_service.dart';
import 'package:ecoparking_flutter/domain/services/parking_service.dart';
import 'package:ecoparking_flutter/domain/state/markers/find_nearby_parkings_state.dart';
import 'package:ecoparking_flutter/domain/state/markers/get_current_location_state.dart';
import 'package:ecoparking_flutter/domain/state/profile/get_profile_state.dart';
import 'package:ecoparking_flutter/domain/state/search_parking/search_parking_state.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/add_favorite_parking_state.dart';
import 'package:ecoparking_flutter/domain/state/user_favorite_parkings/remove_favorite_parking_state.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/current_location_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/markers/find_nearby_parkings_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/profile/get_profile_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/search_parking/search_parking_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/add_favorite_parking_interactor.dart';
import 'package:ecoparking_flutter/domain/usecase/user_favorite_parkings/remove_favorite_parking_interactor.dart';
import 'package:ecoparking_flutter/model/parking/parking.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_by.dart';
import 'package:ecoparking_flutter/model/parking/parking_sort_order.dart';
import 'package:ecoparking_flutter/model/parking/shift_price.dart';
import 'package:ecoparking_flutter/pages/book_parking_details/model/parking_fee_types.dart';
import 'package:ecoparking_flutter/pages/home/home_view.dart';
import 'package:ecoparking_flutter/pages/home/home_view_styles.dart';
import 'package:ecoparking_flutter/pages/home/model/parking_bottom_sheet_action.dart';
import 'package:ecoparking_flutter/pages/home/widgets/parking_bottom_sheet_builder/parking_bottom_sheet_builder.dart';
import 'package:ecoparking_flutter/utils/bottom_sheet_utils.dart';
import 'package:ecoparking_flutter/utils/dialog_utils.dart';
import 'package:ecoparking_flutter/utils/logging/custom_logger.dart';
import 'package:ecoparking_flutter/utils/mixins/search_debounce_mixin.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/utils/platform_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geobase/geobase.dart' hide Box, Coords;
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<HomePage>
    with ControllerLoggy, SearchDebounceMixin {
  final CurrentLocationInteractor _currentLocationInteractor =
      getIt.get<CurrentLocationInteractor>();
  final GetProfileInteractor _getProfileInteractor =
      getIt.get<GetProfileInteractor>();
  final FindNearbyParkingsInteractor _findNearbyParkingsInteractor =
      getIt.get<FindNearbyParkingsInteractor>();
  final SearchParkingInteractor _searchParkingInteractor =
      getIt.get<SearchParkingInteractor>();
  final AddFavoriteParkingInteractor _addFavoriteParkingInteractor =
      getIt.get<AddFavoriteParkingInteractor>();
  final RemoveFavoriteParkingInteractor _removeFavoriteParkingInteractor =
      getIt.get<RemoveFavoriteParkingInteractor>();

  final Future<Box<Parking>> _recentSearchesBox =
      getIt.getAsync<Box<Parking>>();

  final ParkingService _parkingService = getIt.get<ParkingService>();
  final BookingService _bookingService = getIt.get<BookingService>();
  final AccountService _accountService = getIt.get<AccountService>();

  final currentLocationNotifier = ValueNotifier<GetCurrentLocationState>(
    const GetCurrentLocationInitial(),
  );
  final findNearbyParkingsNotifier = ValueNotifier<FindNearbyParkingsState>(
    const FindNearbyParkingsInitial(),
  );
  final ValueNotifier<SearchParkingState> searchParkingNotifier =
      ValueNotifier(const SearchParkingInitial());
  final ValueNotifier<AddFavoriteParkingState> addFavoriteParkingNotifier =
      ValueNotifier(const AddFavoriteParkingInitial());
  final ValueNotifier<RemoveFavoriteParkingState>
      removeFavoriteParkingNotifier =
      ValueNotifier(const RemoveFavoriteParkingInitial());

  final ValueNotifier<ParkingSortOrder> sortOrderNotifier =
      ValueNotifier(ParkingSortOrder.ascending);
  final ValueNotifier<ParkingSortBy> sortByNotifier =
      ValueNotifier(ParkingSortBy.distance);
  final ValueNotifier<double> maxDistanceNotifier = ValueNotifier(1000);
  final ValueNotifier<bool> isSelectFavoriteParkingNotifier =
      ValueNotifier(false);

  final MapController mapController = MapController();
  final SearchController searchController = SearchController();

  StreamSubscription? _currentLocationSubscription;
  StreamSubscription? _getUserProfileSubscription;
  StreamSubscription? _findNearbyParkingsSubscription;
  StreamSubscription? _searchParkingSubscription;
  StreamSubscription? _addFavoriteParkingSubscription;
  StreamSubscription? _removeFavoriteParkingSubscription;

  int get maxRecentSearches => 10;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getUserProfile();
    initializeDebounce(onDebounce: _searchParking);
    routeChangeNotifier.addListener(_onRouteChange);
  }

  @override
  void dispose() {
    _disposeController();
    _clearSubscriptions();
    _disposeNotifier();
    cancelDebounce();
    routeChangeNotifier.removeListener(_onRouteChange);
    super.dispose();
  }

  void _disposeController() {
    mapController.dispose();
  }

  void _onRouteChange() {
    if (searchController.isOpen) {
      searchController.closeView('');
    }
  }

  void _clearSubscriptions() {
    _currentLocationSubscription?.cancel();
    _getUserProfileSubscription?.cancel();
    _findNearbyParkingsSubscription?.cancel();
    _searchParkingSubscription?.cancel();
    _addFavoriteParkingSubscription?.cancel();
    _removeFavoriteParkingSubscription?.cancel();
    _currentLocationSubscription = null;
    _getUserProfileSubscription = null;
    _findNearbyParkingsSubscription = null;
    _searchParkingSubscription = null;
    _addFavoriteParkingSubscription = null;
    _removeFavoriteParkingSubscription = null;
  }

  void _disposeNotifier() {
    currentLocationNotifier.dispose();
    findNearbyParkingsNotifier.dispose();
    searchParkingNotifier.dispose();
    sortOrderNotifier.dispose();
    sortByNotifier.dispose();
    maxDistanceNotifier.dispose();
    addFavoriteParkingNotifier.dispose();
    removeFavoriteParkingNotifier.dispose();
  }

  void _getUserProfile({String? parkingShowing}) {
    loggy.info('_getUserProfile()');
    if (_accountService.profile != null && parkingShowing == null) {
      return;
    }

    final user = _accountService.user ?? SupabaseUtils().auth.currentUser;
    final userId = user?.id;

    if (userId == null) {
      loggy.error('_getUserProfile(): user is null');
      return;
    }

    _getUserProfileSubscription = _getProfileInteractor.execute(userId).listen(
          (event) => event.fold(
            (failure) => _handleGetProfileFailure(failure),
            (success) => _handleGetProfileSuccess(
              success,
              parkingShowing: parkingShowing,
            ),
          ),
        );
  }

  void _getCurrentLocation() async {
    _currentLocationSubscription = _currentLocationInteractor.execute().listen(
      (event) {
        event.fold(
          (failure) => _handleGetCurrentLocationFailure(failure),
          (success) => _handleGetCurrentLocationSuccess(success),
        );
      },
    );
  }

  void findNearbyParking(LatLng userLocation) async {
    _findNearbyParkingsSubscription = _findNearbyParkingsInteractor
        .execute(
          Point(
            Position.create(
              x: userLocation.longitude,
              y: userLocation.latitude,
            ),
          ),
          _getNearbyMaxDistance(userLocation),
        )
        .listen(
          (event) => event.fold(
            (failure) => _handleFindNearbyParkingsFailure(failure),
            (success) => _handleFindNearbyParkingsSuccess(success),
          ),
        );
  }

  LatLng convertLocationDataToLatLng(geolocator.Position locationData) {
    return LatLng(locationData.latitude, locationData.longitude);
  }

  List<Marker> convertParkingsToMarkers(
    BuildContext context,
    List<Parking> parkings,
  ) {
    return parkings.map((parking) {
      final LatLng latLng = LatLng(
        parking.geolocation.position.y,
        parking.geolocation.position.x,
      );
      return Marker(
        point: latLng,
        child: GestureDetector(
          onTap: () => onParkingMarkerPressed(context, parking),
          child: Container(
            width: HomeViewStyles.parkingMarkerOuterSize,
            height: HomeViewStyles.parkingMarkerOuterSize,
            decoration: HomeViewStyles.getParkingOuterMarkerDecoration(context),
            child: Center(
              child: Container(
                width: HomeViewStyles.parkingMarkerInnerSize,
                height: HomeViewStyles.parkingMarkerInnerSize,
                decoration:
                    HomeViewStyles.getParkingInnerMarkerDecoration(context),
                child: Icon(
                  Icons.local_parking,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  size: HomeViewStyles.parkingMarkerIconSize,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  void onSearchPressed(SearchController searchController) {
    loggy.info('Search button pressed');
    searchController.openView();
  }

  void onNotificationPressed() {
    loggy.info('Notification button pressed');
  }

  void onHomePressed() {
    loggy.info('Home button pressed');
  }

  void onCurrentLocationPressed() {
    loggy.info('Current location button pressed');
    _getCurrentLocation();
  }

  void _onBookmark(Parking parking) {
    loggy.info('Bookmark pressed: $parking');

    final profile = _accountService.profile;

    if (profile == null) {
      DialogUtils.showRequiredLogin(context);
    } else if (profile.phone == null || profile.phone!.isEmpty) {
      DialogUtils.showRequiredFillProfile(context);
    } else {
      final favoriteParkings = profile.favoriteParkings;

      if (favoriteParkings == null) {
        _addFavoriteParking(parking.id, profile.id);
      } else {
        if (favoriteParkings.contains(parking.id)) {
          _removeFavoriteParking(parking.id, profile.id);
        } else {
          _addFavoriteParking(parking.id, profile.id);
        }
      }
    }
  }

  void _removeFavoriteParking(String parkingId, String userId) {
    _removeFavoriteParkingSubscription = _removeFavoriteParkingInteractor
        .execute(
          userId: userId,
          parkingId: parkingId,
        )
        .listen(
          (event) => event.fold(
            _handleRemoveFavoriteParkingFailure,
            (success) => _handleRemoveFavoriteParkingSuccess(
              success,
              parkingId,
            ),
          ),
        );
  }

  void _addFavoriteParking(String parkingId, String userId) {
    _addFavoriteParkingSubscription = _addFavoriteParkingInteractor
        .execute(
          userId: userId,
          parkingId: parkingId,
        )
        .listen(
          (event) => event.fold(
            _handleAddFavoriteParkingFailure,
            (success) => _handleAddFavoriteParkingSuccess(
              success,
              parkingId,
            ),
          ),
        );
  }

  void _onNavigateToParking(Parking parking) async {
    final parkingLatitude = parking.geolocation.position.y;
    final parkingLongitude = parking.geolocation.position.x;

    final parkingLocation = LatLng(parkingLatitude, parkingLongitude);

    if (PlatformInfos.isWeb) {
      final Uri queryUri = Uri.https(
        'www.google.com',
        'maps/dir/',
        {
          'api': '1',
          'destination':
              '${parkingLocation.latitude},${parkingLocation.longitude}',
        },
      );

      await launchUrl(queryUri);
    } else {
      final availableMaps = await MapLauncher.installedMaps;

      await availableMaps.first.showDirections(
        destination: Coords(
          parkingLocation.latitude,
          parkingLocation.longitude,
        ),
        directionsMode: DirectionsMode.driving,
      );
    }
  }

  void onParkingMarkerPressed(BuildContext context, Parking parking) async {
    loggy.info('Parking marker pressed', parking);

    final profile = _accountService.profile;

    if (profile == null) {
      isSelectFavoriteParkingNotifier.value = false;
    } else {
      final favoriteParkings = profile.favoriteParkings;

      if (favoriteParkings != null) {
        isSelectFavoriteParkingNotifier.value =
            favoriteParkings.contains(parking.id);
      }
    }

    final ParkingBottomSheetAction? action =
        await BottomSheetUtils.show<ParkingBottomSheetAction>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      showDragHandle: true,
      maxHeight: MediaQuery.sizeOf(context).height * 0.65,
      builder: (context) => ParkingBottomSheetBuilder.build(
        context,
        parking,
        onBookmark: _onBookmark,
        isSelectFavoriteNotifier: isSelectFavoriteParkingNotifier,
        cheapestPrice: _getCheapestPrice(parking)?.price ?? 0.0,
        onNavigate: _onNavigateToParking,
      ),
    );

    if (!context.mounted) return;

    if (action == null) return;

    if (action == ParkingBottomSheetAction.details) {
      loggy.info('Parking details pressed');

      _parkingService.selectParking(parking);

      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.parkingDetails,
      );
      return;
    } else if (action == ParkingBottomSheetAction.bookNow) {
      loggy.info('Book now pressed');

      final profile = _accountService.profile;

      if (profile == null) {
        DialogUtils.showRequiredLogin(context);
      } else if (profile.phone == null || profile.phone!.isEmpty) {
        DialogUtils.showRequiredFillProfile(context);
      } else {
        _bookingService.setParking(parking);
        _bookingService.setParkingFeeType(ParkingFeeTypes.hourly);
      }

      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.bookingDetails,
      );
    }
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371e3;
    final double lat1 = start.latitude * (pi / 180);
    final double lat2 = end.latitude * (pi / 180);
    final double deltaLat = (end.latitude - start.latitude) * (pi / 180);
    final double deltaLng = (end.longitude - start.longitude) * (pi / 180);

    final double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _getNearbyMaxDistance(LatLng currentLocation) {
    final LatLng userLocation = currentLocation;
    final LatLngBounds bounds = mapController.camera.visibleBounds;

    final List<double> distances = [
      _calculateDistance(userLocation, bounds.southWest),
      _calculateDistance(userLocation, bounds.northEast),
      _calculateDistance(
        userLocation,
        LatLng(bounds.southWest.latitude, bounds.northEast.longitude),
      ),
      _calculateDistance(
        userLocation,
        LatLng(bounds.northEast.latitude, bounds.southWest.longitude),
      ),
    ];

    return distances.reduce((a, b) => a > b ? a : b);
  }

  void onMapReady(LatLng userLocation) {
    loggy.info('onMapReady()');

    findNearbyParking(userLocation);
  }

  void onMapEvent(MapEvent event) {
    loggy.info('onMapEvent() event: $event');
  }

  void onPositionChanged(MapCamera camera, bool hasGesture) {
    loggy
        .info('onPositionChanged() position: $camera, hasGesture: $hasGesture');
    findNearbyParking(camera.center);
  }

  Future<List<Parking>> getRecentSearches() async {
    final box = await _recentSearchesBox;
    final list = box.values.toList();
    return list;
  }

  Future<void> addRecentSearch(Parking parking) async {
    final box = await _recentSearchesBox;
    final existingParking = box.values.firstWhereOrNull(
      (element) => element.id == parking.id,
    );
    if (existingParking == null) {
      if (box.length >= maxRecentSearches) {
        await box.deleteAt(0);

        await box.putAt(0, parking);
      }

      await box.add(parking);
    } else {
      final existingParkingIndex = box.values.toList().indexOf(existingParking);
      await box.putAt(existingParkingIndex, parking);
    }
  }

  void onSuggestionPressed(
    SearchController suggestionController,
    Parking parking,
  ) {
    loggy.info('Suggestion pressed: ');

    suggestionController.closeView(parking.parkingName);

    mapController.move(
      LatLng(
        parking.geolocation.position.y,
        parking.geolocation.position.x,
      ),
      HomeViewStyles.initialZoom,
    );

    onParkingMarkerPressed(context, parking);
  }

  void onSearchChanged(String value) {
    loggy.info('Search changed: $value');
    setSearchQuery(value);
  }

  void _searchParking(String? searchQuery) {
    loggy.info('_searchParking() searchQuery: $searchQuery');
    Point? userLocation;

    if (currentLocationNotifier.value is GetCurrentLocationSuccess) {
      final location =
          (currentLocationNotifier.value as GetCurrentLocationSuccess)
              .currentLocation;

      userLocation = Point(
        Position.create(
          x: location.longitude,
          y: location.latitude,
        ),
      );
    }

    _searchParkingSubscription = _searchParkingInteractor
        .execute(
          searchQuery: searchQuery,
          userLocation: userLocation,
          maxDistance: maxDistanceNotifier.value,
          sortBy: sortByNotifier.value,
          sortOrder: sortOrderNotifier.value,
        )
        .listen(
          (result) => result.fold(
            _handleSearchParkingFailure,
            _handleSearchParkingSuccess,
          ),
        );
  }

  void onSearchResultTap(Parking parking) async {
    loggy.info('Search result tapped: $parking');

    _parkingService.selectParking(parking);

    searchController.closeView(parking.parkingName);

    await addRecentSearch(parking);

    if (!mounted) return;

    mapController.move(
      LatLng(
        parking.geolocation.position.y,
        parking.geolocation.position.x,
      ),
      HomeViewStyles.initialZoom,
    );

    onParkingMarkerPressed(context, parking);
  }

  void onSortByPressed() {
    loggy.info('Sort by pressed');
    sortByNotifier.value = sortByNotifier.value == ParkingSortBy.distance
        ? ParkingSortBy.price
        : ParkingSortBy.distance;
    setSearchQuery(searchController.text);
  }

  void onSortOrderPressed() {
    loggy.info('Sort order pressed');
    sortOrderNotifier.value =
        sortOrderNotifier.value == ParkingSortOrder.ascending
            ? ParkingSortOrder.descending
            : ParkingSortOrder.ascending;
    setSearchQuery(searchController.text);
  }

  ShiftPrice? _getCheapestPrice(Parking parking) {
    loggy.info('Get cheapest price: $parking');

    final cheapestPrice = parking.pricePerHour?.reduce(
      (value, element) => value.price < element.price ? value : element,
    );

    if (cheapestPrice != null) {
      return cheapestPrice;
    }

    return parking.pricePerHour?.first;
  }

  void _handleSearchParkingFailure(Failure failure) {
    if (failure is SearchParkingFailure) {
      loggy.error('Search parking failure: ${failure.exception}');
      searchParkingNotifier.value = failure;
    } else {
      loggy.error('Search parking unknown failure');
    }
  }

  void _handleSearchParkingSuccess(Success success) {
    if (success is SearchParkingSuccess) {
      loggy.info('Search parking success');
      searchParkingNotifier.value = success;
    } else if (success is SearchParkingIsEmpty) {
      loggy.info('Search parking is empty');
      searchParkingNotifier.value = success;
    } else if (success is SearchParkingLoading) {
      loggy.error('Search parking is loading');
      searchParkingNotifier.value = success;
    } else {
      loggy.error('Search parking unknown success');
    }
  }

  void _handleFindNearbyParkingsFailure(Failure failure) {
    loggy.error('handleFindNearbyParkingsFailure(): failure: $failure');
    if (failure is FindNearbyParkingsFailure) {
      findNearbyParkingsNotifier.value = failure;
    } else {
      findNearbyParkingsNotifier.value = const FindNearbyParkingsIsEmpty();
    }
  }

  void _handleFindNearbyParkingsSuccess(Success success) {
    loggy.info('handleFindNearbyParkingsSuccess(): success');
    if (success is FindNearbyParkingsSuccess) {
      findNearbyParkingsNotifier.value = success;
    } else {
      loggy.info('handleFindNearbyParkingsSuccess(): success is empty');
      findNearbyParkingsNotifier.value = const FindNearbyParkingsIsEmpty();
    }
  }

  void _handleGetProfileSuccess(Success success, {String? parkingShowing}) {
    loggy.info('handleGetProfileSuccess(): $success');

    if (success is GetProfileSuccess) {
      loggy.info('handleGetProfileSuccess(): ${success.profile}');
      _accountService.setProfile(success.profile);
      final favoriteParkings = success.profile.favoriteParkings;

      if (favoriteParkings != null) {
        isSelectFavoriteParkingNotifier.value = favoriteParkings.contains(
          parkingShowing,
        );
      }
    }
  }

  void _handleGetProfileFailure(Failure failure) {
    loggy.error('handleGetProfileFailure(): $failure');

    if (failure is GetProfileFailure) {
      loggy.error(
        'handleGetProfileFailure():: GetProfileFailure: ${failure.exception}',
      );
    } else {
      loggy.error('handleGetProfileFailure():: Unknown failure: $failure');
    }
  }

  void _handleGetCurrentLocationFailure(Failure failure) {
    loggy.error('handleGetCurrentLocationFailure(): failure: $failure');
    if (failure is GetCurrentLocationFailure) {
      currentLocationNotifier.value = failure;
    } else {
      currentLocationNotifier.value = const GetCurrentLocationIsEmpty();
    }
  }

  void _handleGetCurrentLocationSuccess(Success success) {
    loggy.info('handleGetCurrentLocationSuccess(): success');
    if (success is GetCurrentLocationSuccess) {
      currentLocationNotifier.value = success;
    } else {
      currentLocationNotifier.value = const GetCurrentLocationIsEmpty();
    }
  }

  void _handleAddFavoriteParkingFailure(Failure failure) {
    loggy.error('handleAddFavoriteParkingFailure(): $failure');
    if (failure is AddFavoriteParkingFailure) {
      addFavoriteParkingNotifier.value = failure;
    } else if (failure is AddFavoriteParkingEmpty) {
      addFavoriteParkingNotifier.value = failure;
    } else {
      addFavoriteParkingNotifier.value =
          AddFavoriteParkingFailure(exception: failure);
    }
  }

  void _handleAddFavoriteParkingSuccess(Success success, String parkingId) {
    loggy.info('handleAddFavoriteParkingSuccess(): $success');
    if (success is AddFavoriteParkingSuccess) {
      addFavoriteParkingNotifier.value = success;

      _getUserProfile(
        parkingShowing: parkingId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Parking added to favorites'),
        ),
      );
    } else if (success is AddFavoriteParkingLoading) {
      addFavoriteParkingNotifier.value = success;
    }
  }

  void _handleRemoveFavoriteParkingFailure(Failure failure) {
    loggy.error('handleRemoveFavoriteParkingFailure(): $failure');
    if (failure is RemoveFavoriteParkingFailure) {
      removeFavoriteParkingNotifier.value = failure;
    } else if (failure is RemoveFavoriteParkingEmpty) {
      removeFavoriteParkingNotifier.value = failure;
    } else {
      removeFavoriteParkingNotifier.value =
          RemoveFavoriteParkingFailure(exception: failure);
    }
  }

  void _handleRemoveFavoriteParkingSuccess(
    Success success,
    String parkingId,
  ) {
    loggy.info('handleRemoveFavoriteParkingSuccess(): $success');
    if (success is RemoveFavoriteParkingSuccess) {
      removeFavoriteParkingNotifier.value = success;

      _getUserProfile(
        parkingShowing: parkingId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Parking removed from favorites'),
        ),
      );
    } else if (success is RemoveFavoriteParkingLoading) {
      removeFavoriteParkingNotifier.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => HomePageView(controller: this);
}
