import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../presentation/screens/addtask_screen.dart';
import '../../presentation/screens/login_page.dart';
import '../../presentation/screens/my_homepage.dart';
import '../../presentation/screens/onboarding.dart';
import '../../presentation/screens/signup_page.dart';
import '../../presentation/screens/welcome_page.dart';
import '../../shared/constants/strings.dart';

class AppRoute {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        {
          return MaterialPageRoute(builder: (_) => const OnboardingPage());
        }

      case welcomepage:
        {
          return MaterialPageRoute(builder: (_) => const WelcomePage());
        }

      case loginpage:
        {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
      case signuppage:
        {
          return MaterialPageRoute(builder: (_) => const SignUpPage());
        }
      case homepage:
        {
          return MaterialPageRoute(builder: (_) => const MyHomePage());
        }
      case addtaskpage:
        {
          final task = settings.arguments as TaskModel?;
          return MaterialPageRoute(
              builder: (_) => AddTaskScreen(
                    task: task,
                  ));
        }
      default:
        throw 'No Page Found!!';
    }
  }
}
