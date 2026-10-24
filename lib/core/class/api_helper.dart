class ApiHelper {
  static Map<String, String> getHeaders({
    bool requiredToken = true,
    String? token,
  }) {
    return requiredToken
        ? {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }
        : {"Content-Type": "application/json", "Accept": "application/json"};
  }
}
