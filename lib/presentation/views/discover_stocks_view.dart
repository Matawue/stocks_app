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
    ref.read(getStocksProvider.notifier).loadNextPage();
  }


  @override
  Widget build(BuildContext context) {

    final stocks = ref.watch(getStocksProvider)
;    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portafolio'),
      ),

      body: (stocks.isEmpty)
      ? Center(child: CircularProgressIndicator(strokeWidth: 2,),)

      :Column(
        children: [
          StockHorizontalListview(
            stocks: stocks, 
            title: 'New York stocks'
          )
        ],
      )
    );
  }
}