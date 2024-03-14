class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;
  static const int notProcessable = 422;

  static const int defaultError = -1;
  static const int connectTimeOut = -2;
}
