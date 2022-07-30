import 'package:gymmat/app/shared/services/network/error/exceptions.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NOT_FOUND_EXCEPTION_MESSAGE = 'Not Found Exception';
const String BAD_REQUEST_EXCEPTION_MESSAGE = 'Bad Request Exception';
const String NO_INTERNET_EXCEPTION_MESSAGE = 'No Internet Exception';
const String UNAUTHORIZED_EXCEPTION_MESSAGE = 'UnAuthorization Exception';

String mapExceptionToMessage(Exception exception) {
  switch (exception.runtimeType) {
    case ServerException:
      return SERVER_FAILURE_MESSAGE;
    case BadRequestException:
      return BAD_REQUEST_EXCEPTION_MESSAGE;
    case UnAuthorizationException:
      return UNAUTHORIZED_EXCEPTION_MESSAGE;
    case CacheException:
      return CACHE_FAILURE_MESSAGE;
    case NotFoundException:
      return NOT_FOUND_EXCEPTION_MESSAGE;
    case NoInternetConnectionException:
      return NO_INTERNET_EXCEPTION_MESSAGE;
    default:
      return 'Unexpected error, try again later';
  }
}
