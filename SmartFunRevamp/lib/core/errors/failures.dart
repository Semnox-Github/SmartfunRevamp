abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure implements Failure {
  @override
  final String message;
  ServerFailure(this.message);
}

class ClientFailure implements Failure {
  @override
  final String message;
  ClientFailure(this.message);
}

class InvalidCouponFailure implements Failure {
  @override
  final String message;
  InvalidCouponFailure(this.message);
}

class LocalDataSourceFailure implements Failure {
  @override
  final String message;
  LocalDataSourceFailure(this.message);
}
