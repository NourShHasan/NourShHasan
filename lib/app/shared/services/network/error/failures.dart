/// General Failures
abstract class Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NotFoundFailure extends Failure {}

class NoInternetConnectionFailure extends Failure {}
