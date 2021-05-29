class Failure {
  // Use something like "int code;" if you want to translate error messages
  // throw Failure('No Internet connection 😑');
  // throw Failure("Couldn't find the post 😱");
  // throw Failure("Bad response format 👎");
  final int? statusCode;
  final String message;

  Failure(this.message, {this.statusCode});

  @override
  String toString() =>
      statusCode != null ? '😐 $statusCode: $message' : '😱  $message';
}
