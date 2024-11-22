abstract class UserFavoriteParkingsRepository {
  Future<List<Map<String, dynamic>>?> fetchFavoriteParkings(
    List<String> favoriteParkings,
  );
}
