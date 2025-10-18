

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
              routes: [
                GoRoute(
                  path: 'stock/:symbol',
                  builder: (context, state) {
                    final symbol = state.pathParameters['symbol'] ?? 'no-symbol';

                    return StockScreen(symbol: symbol);
                  }, 
                )
              ]
            ),
          ]
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/portafolio',
              builder: (context, state) => const MyPortafolioView() 
            ),

          ]
        ),

        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/descubrir', //capaz deberia ponerlo en ingles jeje
              builder: (context, state) => const DiscoverStocksView(),
            )
          ]
        ),

      ],


      builder: (context, state, StatefulNavigationShell navigationShell) {
        return HomeScreen(
          childView: navigationShell,
          goBranch: navigationShell.goBranch,
          getCurrentIndex: navigationShell.currentIndex,
        );
      }
    ),

    GoRoute(
      path: '/addstock',
      builder: (context, state) => const AddStocksScreen(),
    )



  ]
);