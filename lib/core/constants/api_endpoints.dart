class ApiEndpoints {

  ApiEndpoints._();

  static const String baseUrl = "https://api.escuelajs.co/api/v1";

  // products
  static const String products = "$baseUrl/products/";

  // categories
  static const String categories = "$baseUrl/categories/";

  // auth
  static const String auth = "$baseUrl/auth";
  static const String login = "$auth/login/";
  static const String profile = "$auth/profile/";
  // users
  static const String users = "$baseUrl/users/";

}