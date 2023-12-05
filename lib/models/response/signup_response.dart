import 'dart:convert';

SignupResponse signupResponseModelFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

class SignupResponse {
  SignupResponse({
    bool? status,
    User? user,
  }) {
    _status = status;
    _user = user;
  }

  SignupResponse.fromJson(dynamic json) {
    _status = json['status'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _status;
  User? _user;
  SignupResponse copyWith({
    bool? status,
    User? user,
  }) =>
      SignupResponse(
        status: status ?? _status,
        user: user ?? _user,
      );
  bool? get status => _status;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    String? fullname,
    String? email,
    String? uid,
    String? password,
    bool? isVerified,
    String? userType,
    String? profile,
    String? id,
    String? verificationCode,
    String? userToken,
  }) {
    _fullname = fullname;
    _email = email;
    _uid = uid;
    _password = password;
    _isVerified = isVerified;
    _userType = userType;
    _profile = profile;
    _id = id;
    _verificationCode = verificationCode;
    _userToken = userToken;
  }

  User.fromJson(dynamic json) {
    _fullname = json['fullname'];
    _email = json['email'];
    _uid = json['uid'];
    _password = json['password'];
    _isVerified = json['isVerified'];
    _userType = json['userType'];
    _profile = json['profile'];
    _id = json['_id'];
    _verificationCode = json['verificationCode'];
    _userToken = json['userToken'];
  }
  String? _fullname;
  String? _email;
  String? _uid;
  String? _password;
  bool? _isVerified;
  String? _userType;
  String? _profile;
  String? _id;
  String? _verificationCode;
  String? _userToken;
  User copyWith({
    String? fullname,
    String? email,
    String? uid,
    String? password,
    bool? isVerified,
    String? userType,
    String? profile,
    String? id,
    String? verificationCode,
    String? userToken,
  }) =>
      User(
        fullname: fullname ?? _fullname,
        email: email ?? _email,
        uid: uid ?? _uid,
        password: password ?? _password,
        isVerified: isVerified ?? _isVerified,
        userType: userType ?? _userType,
        profile: profile ?? _profile,
        id: id ?? _id,
        verificationCode: verificationCode ?? _verificationCode,
        userToken: userToken ?? _userToken,
      );
  String? get fullname => _fullname;
  String? get email => _email;
  String? get uid => _uid;
  String? get password => _password;
  bool? get isVerified => _isVerified;
  String? get userType => _userType;
  String? get profile => _profile;
  String? get id => _id;
  String? get verificationCode => _verificationCode;
  String? get userToken => _userToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['uid'] = _uid;
    map['password'] = _password;
    map['isVerified'] = _isVerified;
    map['userType'] = _userType;
    map['profile'] = _profile;
    map['_id'] = _id;
    map['verificationCode'] = _verificationCode;
    map['userToken'] = _userToken;
    return map;
  }
}
