abstract class UserFavoriteParkingsDatasource {
  Future<List<Map<String, dynamic>>?> fetchFavoriteParkings(
    List<String> favoriteParkings,
  );
}
