
import 'package:flutter/cupertino.dart';
import 'package:ura_taxi/layout/base.dart';
import 'package:ura_taxi/screens/auth/forgotpassword.dart';
import 'package:ura_taxi/screens/auth/login.dart';
import 'package:ura_taxi/screens/auth/signup.dart';
import 'package:ura_taxi/screens/home/home.dart';
import 'package:ura_taxi/screens/splash/splash.dart';
import 'package:ura_taxi/widgets/home/home_widget.dart';

class Routes {
  Routes._();

  static const splashScreen = '/splash-screen';
  static const login = '/login';
  static const intro = '/intro';
  static const signup = '/signup';
  static const forgotpassword = "/forgotpassword";
  static const home = "/home";
  static const profile = "/profile";


  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      splashScreen: (BuildContext context) =>
    const BaseLayout(page: SplashScreen(), isAppBar: false,),
      login: (BuildContext context) =>
      const BaseLayout(page: LoginScreen(), isAppBar: false,),
      signup: (BuildContext context) =>
      const BaseLayout(page: SignupScreen(), isAppBar: false,),
      forgotpassword: (BuildContext context) =>
      const BaseLayout(page: ForgotPasswordScreen(), isAppBar: false,),
      home: (BuildContext context) =>
      const BaseLayout(page: HomeScreen(), isAppBar: false,),
      profile: (BuildContext context) =>
      const BaseLayout(page: HomeScreen(), isAppBar: false,)
    };
  }
}