import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

const String _kPasswordPattern = r"^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$";

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _regex = RegExp(_kPasswordPattern);

  @override
  PasswordValidationError? validator(String value) {
    if (_regex.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else {
      return PasswordValidationError.invalid;
    }
  }

  static String? showErrorPasswordMessage(PasswordValidationError? error) {
    if (error == PasswordValidationError.empty) {
      return 'Password is required';
    } else if (error == PasswordValidationError.invalid) {
      return 'Password must contain a special character(@,#), uppercase and lowercase letter';
    } else {
      return null;
    }
  }
}