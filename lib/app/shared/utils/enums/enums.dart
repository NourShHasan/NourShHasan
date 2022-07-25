/// App Environment
enum AppEnvironment { PRODUCTION, STAGING, DEV }

/// Countries enums
/// EG ==> EGYPT
/// JO ==> Jordan
/// PK ==> Pakistan
/// IQ ==> Iraq
/// SA ==> Saudi Arabia
/// SD ==> Sudan
/// QA ==> Qatar
/// OM ==> Oman
/// PS ==> Palestine
enum CountriesCode { JO, PS, EG, SA, IQ, PK, SD, OM, QA, LANG, other }

/// Parse enum value to String.
extension ParseToString on Enum {
  String get name => this.toString().split('.').last;
}

/// Parse string to enum dynamic without initial value
T? enumValueFromString<T>(String? key, List<T> values, {required T onNull}) =>
    key != null
        ? values.firstWhere(
            (v) => key == v.toString().split('.').last,
            orElse: () => onNull,
          )
        : onNull ?? null;

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => MapEntry(v, k));
    }
    return reverseMap!;
  }
}

/// Handle Status of Email OTP Screen
/// if user open [EmailOTPScreen] from many routes eg: [SignUpScreen] or [ChangeEmailScreen]
///
/// [isUserSignedUpEmail] if user signed up with email then open [EmailOTPScreen].
/// [isUserChangeHisInfo] if user open settings page [ChangeEmailScreen] to change his email.
/// [isUserNotVerified] if user has unverified email after signed up.

/// Handle Type of Gender in [SettingsScreen] & [ChangeGenderScreen]
enum GenderType {
  MALE,
  FEMALE,
  None,
}

/// Handle Type of SignUp in [CompleteUserProfileScreen]
enum SignupType {
  signUpByEmail,
  signUpByPhone,
  signUpByFacebook,
  signUpByGoogle,
  none,
}

/// Handle Status of SMS OTP Screen
/// if user open [SmsOTPScreen] from many routes eg: [SignUpScreen] or [ChangePhoneScreen]
///
/// [isUserSignedUpByPhone] if user signed up with phone then open [SmsOTPScreen].
/// [isUserChangePhoneInfo] if user open settings page [ChangePhoneScreen] to change his phone.
/// [isUserForgetPassword] if user has forgot his password.
enum SMSOTPStatus {
  isUserSignedUpByPhone,
  isUserForgetPassword,
  isUserChangePhoneInfo,
}
