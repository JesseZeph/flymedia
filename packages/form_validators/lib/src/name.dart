import 'package:formz/formz.dart';

enum NameValidationError { empty, invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    }  else if (value.length < 5) {
      return NameValidationError.invalid;
    } else {
      return null;
    }
  }
  static String? showNameErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Name is Empty';
    } else if (error == NameValidationError.invalid) {
      return '';
    } else {
      return null;
    }
  }
}

