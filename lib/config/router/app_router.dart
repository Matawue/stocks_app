

import 'package:go_router/go_router.dart';
import 'package:stocks_app/presentation/screens/screens.dart';
import 'package:stocks_app/presentation/views/views.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: '/',

          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              // TODO: aqui deberia ir el stockScreen cuando exista
            ),
          ]
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/portafolio',
              builder: (context, state) => const MyPortafolioView() 
            )
          ]
        )

      ],


      builder: (context, state, StatefulNavigationShell navigationShell) {
        return HomeScreen(
          childView: navigationShell,
          goBranch: navigationShell.goBranch,
          getCurrentIndex: navigationShell.currentIndex,
        );
      }
    )



  ]
);