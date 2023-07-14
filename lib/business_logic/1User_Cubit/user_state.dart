abstract class UserStates {}

class UserInitialState extends UserStates {}

class LoginLoading extends UserStates {}

class LoginSuceccful extends UserStates {}

class Loginerrorinvalid_email extends UserStates {}

class Loginerroruser_not_found extends UserStates {}

class Loginerrorwrong_password extends UserStates {}

class Loginerror extends UserStates {}

class SignUpLoading extends UserStates {}

class SignUpSuceccful extends UserStates {}

class SignUperror extends UserStates {}

class SocialChangePasswordVisibilityState extends UserStates {}

class UploadImageState extends UserStates {}

class DropdownState extends UserStates {}
