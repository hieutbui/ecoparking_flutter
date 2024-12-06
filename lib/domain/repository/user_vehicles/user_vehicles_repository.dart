abstract class UserVehiclesRepository {
  Future<List<Map<String, dynamic>>?> fetchUserVehicles();
  Future<Map<String, dynamic>?> addUserVehicle({
    required String name,
    required String licensePlate,
    required String userId,
  });
}
