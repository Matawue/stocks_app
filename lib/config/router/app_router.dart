

import 'package:go_router/go_router.dart';
import 'package:stocks_app/presentation/screens/home_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen()
    )
  ]
);