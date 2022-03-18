import 'package:fluro/fluro.dart';
import 'package:todo_app/presentation/screens/my_homepage.dart';
import '../presentation/screens/login_page.dart';
import '../presentation/screens/onboarding.dart';
import '../presentation/screens/signup_page.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String signup = "/signup";
  static String login = "/login";
  static String demoFunc = "/demo/func";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;
    router.define(root, handler: configHandler(const OnboardingPage()));
    router.define(home, handler: configHandler(const MyHomePage()));
    router.define(signup, handler: configHandler(const SignUpPage()));
    router.define(login, handler: configHandler(const LoginPage()));
  }
}
