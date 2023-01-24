abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure implements Failure {
  @override
  final String message;
  ServerFailure(this.message);
}
