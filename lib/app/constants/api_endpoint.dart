class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://localhost:8000/api/";
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String getUser = "user/details";
  static const String getAlluser = "auth/getAllusers";
  static const String getusersByBatch = "auth/getusersByBatch/";
  static const String getusersByCourse = "auth/getusersByCourse/";
  static const String updateuser = "user/update";
  static const String deleteuser = "auth/deleteuser/";
  static const String imageUrl = "http://localhost:8000/services/";
  static const String uploadImage = "auth/uploadImage";
  static const String currentUser = "auth/getMe";
  static const String pagination = "service/pagination";
  static const String photos = "photos";

  static const String createPost = "service/create/";
  static const String userPosts = "service/get_all_service_by_userid/";
  static const String deletePost = "/service/delete_service/";
  static const String getSingleService = "service/get_single_service/";
  static const limitPage = 20;

  // Favorite Routes
  static const String addFavorite = "favorites/add_favorite";
  static const String removeFavorite = "favorites/remove_favorite/";
  static const String getFavorites = "favorites/favorites/";

  // review
  static const String createReviews = "createReview/create_review";
  static const String getServiceReviews = "createReview/reviews/";

  // forgot routes
  static const String forgotPassword = "user/forgot_password";
  static const String verifyOtp = "user/verify_otp";

  // ====================== Batch Routes ======================
  static const String createBatch = "batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";

  // ====================== Course Routes ======================
  static const String createCourse = "course/createCourse";
  static const String deleteCourse = "course/";
  static const String getAllCourse = "course/getAllCourse";
}
