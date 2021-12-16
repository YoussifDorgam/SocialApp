

abstract class SocialLoginStatus {}
class SocialLoginInitialStatus extends SocialLoginStatus {}
class SocialLoginLodingStatus extends SocialLoginStatus {}
class SocialLoginSuccessStatus extends SocialLoginStatus
{
  final String uid ;

  SocialLoginSuccessStatus(this.uid);

}
class SocialLoginErrorStatus extends SocialLoginStatus {
  final String error ;
  SocialLoginErrorStatus(this.error);
}

class IseyeShow extends SocialLoginStatus {}