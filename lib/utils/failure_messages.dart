


import '../core/error/failures.dart';


String SERVER_FAILURE_MESSAGE = 'Server failure';
String ACCESS_DENIED_FAILURE_MESSAGE =
    'Access denied';
String CACHE_FAILURE_MESSAGE = 'Cache failure';
String CHAT_LIMIT_EXCEEDED = 'Chat limit reached';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case AccessDeniedFailure:
      return ACCESS_DENIED_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case ChatLimitExceededFailure:
      return CHAT_LIMIT_EXCEEDED;
    default:
      return 'Unexpected error';
  }
}
