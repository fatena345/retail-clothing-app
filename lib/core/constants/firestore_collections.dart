class FirestoreCollections {
  FirestoreCollections._();

  static const String users = 'users';
  static const String products = 'products';
  static String favorites(String uid) => '$users/$uid/favorites';
  static String cart(String uid) => '$users/$uid/cart';
}