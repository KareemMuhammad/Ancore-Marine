class BaseAPI{
  Map<String,String> headers = {"Accept" : "application/json"};
  static String base = "https://anchormarine-kw.com/api";
  var loginPath = base + "/login?";
  var registrationPath = base + "/signup?";
  var logoutPath = base + "/logout?";
  var resetPassword = base + '/ForgetPasswordMail?';
  var getUserById = base + '/getUserById?';
  var getPurchases = base + '/orderUser?';
  var adsPath = base + "/allImages";
  var getCategories = base + "/getCategories";
  var aboutPath = base + "/getAbout?";
  var updateUserPath = base + '/updateProfile?';
  var productsByCategoryPath = base + '/getCategoryProduct?';
  var servicesPath  = base + '/getServices';
  var bestSellerPath  = base + '/getBestSeller';
  var offersPath  = base + '/getOfferProducts';
  var slotsPath = base + '/getSlots';
  var cartDataPath = base + '/getCartData?';
  var addToCartPath = base + '/addToCart?';
  var removeFromCartPath = base + '/removeFromCart?';
  var payServicesPath = base + '/servicePayment?';
  var payOrderPath = base + '/orderPayment?';
  var productPath = base + '/product?';
  var deleteAccPath = base + '/deleteAccount?';
}