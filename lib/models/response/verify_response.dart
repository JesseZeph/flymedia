class VerifyResponse {
  VerifyResponse({
    String? message,
  }) {
    _message = message;
  }

  VerifyResponse.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
  VerifyResponse copyWith({
    String? message,
  }) =>
      VerifyResponse(
        message: message ?? _message,
      );
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}
