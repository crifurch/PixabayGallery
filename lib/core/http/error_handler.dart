import 'package:pixabay_gallery/core/http/responses/handled_response.dart';

class ErrorHandler {
  ErrorHandler();

  void handleError(HandledResponse response) {
    if (response.isSuccess) {
      return;
    }
  }
}