class VerificationCode {
  VerificationCode({
    String? email,
    String? verificationCode,
  }) {
    _email = email;
    _verificationCode = verificationCode;
  }

  VerificationCode.fromJson(dynamic json) {
    _email = json['email'];
    _verificationCode = json['verificationCode'];
  }
  String? _email;
  String? _verificationCode;
  VerificationCode copyWith({
    String? email,
    String? verificationCode,
  }) =>
      VerificationCode(
        email: email ?? _email,
        verificationCode: verificationCode ?? _verificationCode,
      );
  String? get email => _email;
  String? get verificationCode => _verificationCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['verificationCode'] = _verificationCode;
    return map;
  }
}
