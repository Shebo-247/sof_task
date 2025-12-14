class ResponseCodes {
  static const int success = 200;
  static const int conflict = 409;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int paymentRequired = 402;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int unprocessableContent = 422;
  static const int manyRequest = 429;
  static const int serverError = 500;

  static bool isSuccess(int code) {
    return code >= 200 && code < 300;
  }

  static bool isClientError(int code) {
    return code >= 400 && code < 500;
  }

  static bool isServerError(int code) {
    return code >= 500;
  }

  static bool isNetworkError(int code) {
    return code == -1;
  }
}
