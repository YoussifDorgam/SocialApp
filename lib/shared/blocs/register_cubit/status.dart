

abstract class SocialRegisterStatus {}
class SocialRegisterInitialStatus extends SocialRegisterStatus {}
class SocialRegisterLodingStatus extends SocialRegisterStatus {}
class SocialRegisterSuccessStatus extends SocialRegisterStatus
{
}
class SocialRegisterErrorStatus extends SocialRegisterStatus {
  final String error ;
  SocialRegisterErrorStatus(this.error);
}

class IseyeRegisterShow extends SocialRegisterStatus {}

/// User creating
 class SocialCreateUserSuccessStatus extends SocialRegisterStatus
{
}
class SocialCreateUserErrorStatus extends SocialRegisterStatus {
  final String error ;
  SocialCreateUserErrorStatus(this.error);
}