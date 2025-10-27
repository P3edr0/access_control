abstract class ILauncher {
  Future<void> phoneCall(String phone);
  Future<void> sendEmail(String email);
  Future<void> openMap({required String latitude, required String longitude});
}
