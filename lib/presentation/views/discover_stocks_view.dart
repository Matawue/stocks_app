import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/presentation/delegates/search_stock_delegate.dart';
import 'package:stocks_app/presentation/providers/providers.dart';
import 'package:stocks_app/presentation/widgets/stocks/stock_horizontal_listview.dart';
import 'package:stocks_app/presentation/widgets/stocks/stocks_slideshow.dart';





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

    final stocksFromNY = ref.watch(getStocksFromNYProvider);
    final stocksFromNAS = ref.watch(getStocksFromNASProvider);

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () {
              
              final searchedStocks = ref.read(searchedStocksProvider);
              final searchQuery = ref.read(searchQueryProvider);
              showSearch(
                query: searchQuery,
                context: context, 
                delegate: SearchStockDelegate(
                  initialStocks: searchedStocks,
                  searchStocks: ref.read(searchedStocksProvider.notifier).searchStocksByQuery,
                  searchQuery: searchQuery,
                  isInitialData: true
                )
              );
            }, 

            label: const Text('Buscar', style: TextStyle(fontSize: 18),),
            icon: Icon(Icons.search, size: 22,),
            iconAlignment: IconAlignment.start,
            style: ButtonStyle(
              alignment: AlignmentGeometry.centerLeft,
              backgroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade300),
            ),
          ),
        )
      ),

      //TODO: Capaz hacer una capa aparte que me vea si todos cargaron, o hasta hacerle un esqueleto a el StockHorizontal para que no aparezca la pantalla de carga y pueda ver el boton de busqueda
      body: (stocksFromNY.isEmpty && stocksFromNAS.isEmpty)
      ? Center(child: CircularProgressIndicator(strokeWidth: 2,),)

      :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 15,),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Las 7 Magníficas', style: TextStyle(fontSize: 18,),),
            ),
        
            SizedBox(height: 10,),
        
            StocksSlideshow(),
        
            StockHorizontalListview(
              stocks: stocksFromNY, 
              title: 'Acciones de New York',
              loadNextPage: () => ref.read(getStocksFromNYProvider.notifier).loadNextPage(),
            ),
        
            StockHorizontalListview(
              stocks: stocksFromNAS, 
              title: 'Acciones de NASDAQ',
              loadNextPage: () => ref.read(getStocksFromNASProvider.notifier).loadNextPage(),
            )
          ],
        ),
      )
    );
  }
}