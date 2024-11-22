abstract class UserFavoriteParkingsDataSource {
  Future<List<Map<String, dynamic>>?> fetchFavoriteParkings(
    List<String> favoriteParkings,
  );
}
