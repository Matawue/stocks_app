import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_provider.dart';
import 'package:stocks_app/presentation/widgets/stocks/stock_horizontal_listview.dart';





class DiscoverStocksView extends ConsumerStatefulWidget {
  const DiscoverStocksView({super.key});

  @override
  ConsumerState<DiscoverStocksView> createState() => _DiscoverStocksViewState();
}

class _DiscoverStocksViewState extends ConsumerState<DiscoverStocksView> {

  @override
  void initState() {
    super.initState();
    ref.read(getStocksFromNYProvider.notifier).loadStocksIncremental();
    ref.read(getStocksFromNASProvider.notifier).loadStocksIncremental();
  }


  @override
  Widget build(BuildContext context) {

    final stocks1 = ref.watch(getStocksFromNYProvider);
    final stocks2 = ref.watch(getStocksFromNASProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portafolio'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search_rounded)
          )
        ],
      ),

      //TODO: Capaz hacer una capa aparte que me vea si todos cargaron, o hasta hacerle un esqueleto a el StockHorizontal para que no aparezca la pantalla de carga y pueda ver el boton de busqueda
      body: (stocks1.isEmpty && stocks2.isEmpty)
      ? Center(child: CircularProgressIndicator(strokeWidth: 2,),)

      :Column(
        children: [
          StockHorizontalListview(
            stocks: stocks1, 
            title: 'New York stocks',
            loadNextPage: () => ref.read(getStocksFromNYProvider.notifier).loadNextPage(),
          ),

          StockHorizontalListview(
            stocks: stocks2, 
            title: 'NASDAQ stocks',
            loadNextPage: () => ref.read(getStocksFromNASProvider.notifier).loadNextPage(),
          )
        ],
      )
    );
  }
}