import 'package:gymmat/app/shared/utils/enums/enums.dart';

/// If you want to change the environment of the app
/// whether it be [AppEnvironment.PRODUCTION] or [AppEnvironment.STAGING]
/// some of URLs, Firebase Options and GraphQL that depends on the environment
/// that you working on so make sure you use the correct [AppEnvironment].
const AppEnvironment appEnv = AppEnvironment.PRODUCTION;
