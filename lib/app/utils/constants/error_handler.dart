import 'package:githubexplore/model/failure_model.dart';
import 'package:githubexplore/app/utils/constants/http_response_message.dart';
import 'package:githubexplore/app/utils/constants/http_responsecode.dart';
import 'package:http/http.dart' as http;

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  unprocessable,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is http.Response) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }
}

Failure _handleError(http.Response response) {
  switch (response.statusCode) {
    case 400:
      return DataSource.badRequest.getFailure();
    case 401:
      return DataSource.unauthorized.getFailure();
    case 403:
      return DataSource.forbidden.getFailure();
    case 404:
      return DataSource.notFound.getFailure();
    case 422:
      return DataSource.unprocessable.getFailure();
    case 500:
      return DataSource.internalServerError.getFailure();
    default:
      return DataSource.defaultError.getFailure();
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);

      case DataSource.unprocessable:
        return Failure(
            ResponseCode.notProcessable, ResponseMessage.notProcessable);

      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
      default:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}
