class ResponseMessage {
  static const String success = "Success";
  static const String noContent = "Success with no content";
  static const String badRequest = "Bad request, try again later";
  static const String forbidden = "Forbidden request, try again later";
  static const String unauthorized = "User is unauthorized, try again later";
  static const String notFound = "Url is not found, try again later";
  static const String internalServerError =
      "Something went wrong, try again later";
  static const String notProcessable = "Your request is not processing";

  static const String defaultError = "Something went wrong, try again later";
  static const String connectTimeOut = "Time out error, try again later";
  static const String cancel = "Request was cancelled, try again later";
  static const String receiveTimeOut = "Time out error, try again later";
  static const String sendTimeOut = "Time out error, try again later";
  static const String cacheError = "Cache error, try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
}
