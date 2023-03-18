
/// Api Paths Class
class ApiPaths {
  /// Live and Local base url
  static String liveBaseURL = "https://e-parent-kit.herokuapp.com/api/";
  static String localBaseUrl = "http://0.0.0.0:8080/api/";

  /// Base url variable used throughout
  static String baseURL = localBaseUrl;

  /// Endpoints
  static String authRoute =  "auth";
  static String todoRoute =  "todo";

  // User Auth Apis
  static String login =  "$baseURL$authRoute/login";
  static String register =  "$baseURL$authRoute/register";
  static String profile =  "$baseURL$authRoute/profile";
  static String changePassword =  "$baseURL$authRoute/change_password";
  static String resendOtp =  "$baseURL$authRoute/resend";
  static String verifyOtp =  "$baseURL$authRoute/verify";
  static String logout =  "${baseURL}logout";

  /// Todo Apis
  static String fetchAllTodos =  "$baseURL$todoRoute";
  static String createTodo =  "$baseURL$todoRoute/create/";
  static String updateTodo =  "$baseURL$todoRoute/update/";
  static String deleteTodo =  "$baseURL$todoRoute/delete/";

}
