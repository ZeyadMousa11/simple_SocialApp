abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingStat extends RegisterStates {}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class ChangeIconPassword extends RegisterStates {}

class CreateSuccessState extends RegisterStates
{
 final String uId;
 CreateSuccessState(this.uId);
}

class CreateErrorState extends RegisterStates {
  final String error;

  CreateErrorState(this.error);
}
