

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';


final Provider <Future<List<Stock>>> stockListProvider = 
Provider((ref) async{
  final stockRepository = ref.watch(stockRepositoryProvider);
  final stocks = await stockRepository.getStock();
  return stocks;
});

final getStocksProvider = StateNotifierProvider<StocksNotifier, List<Stock>>((ref) {
  final stocks = ref.watch(stockListProvider);
  return StocksNotifier(
    stocks: stocks
  );

});

typedef StockCallback = Future<List<Stock>>;


class StocksNotifier extends StateNotifier<List<Stock>> {
  int currentPage = 0;
  bool isLoading = false;
  final StockCallback stocks;


  StocksNotifier({
    required this.stocks
  }) : super([]);



  Future<void> loadNextPage() async{

    if(isLoading) return;
    final stocksList = await stocks;
    if(stocksList.isEmpty) return;
    isLoading = true;
    int offset = currentPage*10;
    List<Stock> tempStocksList = []; 
    for(int i = offset; i<offset+10 && i<stocksList.length; i++){
      tempStocksList.add(stocksList[i]);
    }
    currentPage++;

    state = [...state, ...tempStocksList];
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;

  }



}