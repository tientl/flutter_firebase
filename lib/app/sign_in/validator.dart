abstract class Stringvalidator{
  bool isValid(String value);
}

class NonEmptyStringValidator implements Stringvalidator{
  @override
  bool isValid(String value){
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator{
  final Stringvalidator emailValidator = NonEmptyStringValidator();
  final Stringvalidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = "Email can't empty";
  final String invalidPasswordErrorText = "Password can't empty";
}