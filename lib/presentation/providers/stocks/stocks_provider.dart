

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/infrastructure/repositories/stock_repository_impl.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';



final getStocksProvider = StateNotifierProvider<StocksNotifier, List<Stock>>((ref) {
  final stocks = ref.watch(stockRepositoryProvider);
  return StocksNotifier(
    stocks: stocks
  );

});

typedef StockCallback = StockRepositoryImpl;


class StocksNotifier extends StateNotifier<List<Stock>> {
  int currentPage = 0;
  bool isLoading = false;
  final StockCallback stocks;

  final List<Stock> _allStocks = [];


  StocksNotifier({
    required this.stocks
  }) : super([]);

  Future<void> loadStocksIncremental() async {
    _allStocks.clear();
    await stocks.getStock(
        onStockFound: (stock) {
          _allStocks.add(stock);
          if(_allStocks.length == 10) loadNextPage();
        },
      );
  }

  Future<void> loadNextPage() async{

    if(isLoading) return;
    
    if(_allStocks.isEmpty) return;
    isLoading = true;
    int offset = currentPage*10;
    List<Stock> tempStocksList = [];
    //pensando en poner el modulo de 10 de el length para contar
    for(int i = offset; i<offset+10 && i<_allStocks.length; i++){
      tempStocksList.add(_allStocks[i]);
    }
    currentPage++;

    state = [...state, ...tempStocksList];
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;

  }



}