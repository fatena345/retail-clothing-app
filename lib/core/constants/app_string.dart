class AppString {
  AppString._();

  // app title
  static const String appTitle = 'Geeta.';

  // home page
  static const String filterAndSort = 'FILTER & SORT';
  static const String popular = 'Popular';
  static const String mens = 'Mens';
  static const String womens = 'Womens';
  static const String sale = 'Sale';

  // product details screen
  static const String description = 'DESCRIPTION';
  static const String noDescription = 'No description';
  static const String selectSize = 'SELECT SIZE';
  static const String addToCart = 'ADD TO CART';
  static const String small = 'S';
  static const String medium = 'M';
  static const String large = 'L';
  static const String xLarge = 'XL';
  static const String xxLarge = 'XXL';
  static const String detail = 'detail';

  // favorite screen
  static const String favorite = 'Favorite';
  static const String addAllToCart = 'ADD ALL TO CART';
  static const String removedSuccess = 'removed from favorites';
  static const String addedToFavorite = 'added to favorites';


  // handle error states
  static const String noData = 'No Data Available';
  static const String wrong = 'Something went wrong';
  static const String antherError = 'Another Error occured';
  static const String noInternet = 'No Internet Connection';
  static const String loginFailed = 'Login failed';
  static const String signupFailed = 'Signup failed';

  
  // create & delete product
  static const String addNewProduct = 'Add New Product';
  static const String productTitle = 'Product Title';
  static const String priceInDollar = 'Price (USD)';
  static const String dollar = ' USD';
  static const String category = 'Category';
  static const String categoryId = 'Category ID';
  static const String productCreatedSuccess = 'Product created successfully!';
  static const String failedCreateProduct = 'Failed to create product';
  static const String createProduct = 'Create Product';
  static const String productDeletedSuccess = 'Product deleted successfully!';
  static const String failedDeleteProduct = 'Failed to delete product';
  static const String imageUrl = 'Image URL';
  static const String permissionNotExist = "you don't have permission to add product";
  static const String alert = "Alert";
  static const String findProducts = 'Find Products';
  static const String geetaCollection = 'GEETA COLLECTION';
  static const String itemsFoundFor = 'Items found for';
  static const String done = "Done";
  static const String  inValidCategoryId = "CategoryId is invalid";
  static const String  inValidPrice = "Price is invalid";
  static const String deleteProduce = 'Delete Product';
  static const String deleteMessage = 'Are you sure you want to delete this product?';
  static const String delete = 'Delete';
  static const String cancel = 'Cancel';
  static const String geetaMens = 'Geeta Mens';
  static const String addedToCart = ' added to cart!';
  static const String cart  = 'Cart';

  // splash screen
  static const String shopNow = 'SHOP NOW';

  // welcome screen
  static const String welcomeTitle = 'Create your fashion in your own way';
  static const String welcomeSubTitle =
      'Each men and women has their own style, Geeta help you to create your unique style.';
  static const String login = 'LOG IN';
  static const String or = 'OR';
  static const String register = 'REGISTER';

  // login screen
  static const String welcomeBack = 'Welcome Back!';
  static const String loginParagraph =
      'Yay! You\'re back! Thanks for shopping with us We have excited deals and promotions going on, pick now!';
  static const String emailAddress = 'Email address';
  static const String password = 'Password';
  static const String rememberMe = 'Remember me';
  static const String forgotPassword = 'Forgot Password?';
  static const String notRegistered = 'Not registered yet';
  static const String createAccount = 'Create an Account';
  static const String loginSuccessful = 'Login successful';
  static const String validation = 'Validation';
  static const String validationHint = 'Please fill all fields';
  static const String success = 'Success';
  static const String failed = 'Failed';

  // hints
  static const Map<String, String> hints = {
    'email': 'Enter your email',
    'password': 'Enter your password',
    'name': 'Your full name',
    'title': 'Enter product title',
    'price': 'Enter price',
    'description': 'Enter product description',
    'categoryId': 'Enter category id (e.g. 1)',
    'imageUrl': 'Enter image URL',
    'name on card': 'Enter your name as it appears on the card',
    'card number': '4747 4747 4747 4747',
    'expiry date': '07/21',
    'cvc': '474',
    'search': 'Hoodies',
  };

  // register screen
  static const String registerTitle = "Get's started with Geeta.";
  static const String registerSubTitle = 'Already have an account?';
  static const String yourName = 'your Name';
  static const String agreeToReceiveEmail =
      'By enjoying I agree to receive emails from Geeta!';
  static const String registerSuccess = 'Registered successfully';

  // cart
  static const String myCart = 'My Cart';
  static const String goToCheckout = 'GO TO CHECKOUT';

  // add all to cart bottom sheet
  static const String checkout = 'Checkout';
  static const String delivery = 'Delivery';
  static const String payment = 'Payment';
  static const String promoCode = 'Promo Code';
  static const String totalCost = 'Total Cost';
  static const String pickDiscount = 'Pick discount';
  static const String selectMethod = 'Select Method';
  static const String agreeTermsPlacingOrder =
      'By placing an order you agree to our Terms And Conditions.';
  static const String placeOrder = 'PLACE ORDER';

  // payment screen
  static const String creditDebitCard = 'Credit / Debit card';
  static const String nameOnCard = 'Name on card';
  static const String cardNumber = 'Card number';
  static const String expiryDate = 'Expiry date';
  static const String cvc = 'CVC';
  static const String useThisCard = 'USE THIS CARD';

  // order placed success
  static const String congratsPlacingOrder =
      'Congrats! Your Order has been placed';
  static const String congratsSubTitle =
      'Your items has been placed and is on it\'s way to being processed';
  static const String trackOrder = 'TRACK ORDER';
  static const String continueShopping = 'CONTINUE SHOPPING';
  static const String backToHome = 'Back to home';

  // order placed failed
  static const String failedPlacedOrderTitle = 'Oh Snap! Order Failed';
  static const String tryAgain = 'PLEASE TRY AGAIN';
  static const String failedPlacedOrderSubTitle =
      'Looks like something went wrong while processing your request.';

  // profile
  static const String orders = 'Orders';
  static const String wishlist = 'Wishlist';
  static const String deliveryAddress = 'Delivery Address';
  static const String paymentMethods = 'Payment Methods';
  static const String promoCord = 'Promo Cord';
  static const String notifications = 'Notifications';
  static const String help = 'Help';
  static const String about = 'About';
  static const String logout = 'LOG OUT';


  //notifications
  
static const String loginSuccessTitle = 'Login Successful';

static String loginSuccessBody(String? name) =>
    name == null || name.isEmpty
        ? 'Welcome back! You have successfully logged in.'
        : 'Welcome back, $name! You have successfully logged in.';

static const String paymentSuccessTitle = 'Payment Successful 🎉';
static const String paymentSuccessBody =
    'Your order has been confirmed. Thank you for shopping with us!';

}