

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedStocksProvider = StateNotifierProvider<SearchedStocksNotifier, List<StockLookup>>((ref) {
  final stockRepository = ref.watch(stockRepositoryProvider);
  return SearchedStocksNotifier(
    searchStocks: stockRepository.searchStocks, 
    ref: ref
  );
});


typedef SearchStocksCallback = Future<List<StockLookup>> Function(String query);

class SearchedStocksNotifier extends StateNotifier<List<StockLookup>>{
  
  final SearchStocksCallback  searchStocks;
  final Ref ref;

  SearchedStocksNotifier({
    required this.searchStocks,
    required this.ref
  }): super([]);

  Future<List<StockLookup>> searchStocksByQuery(String query) async{

    ref.read(searchQueryProvider.notifier).update((state) => query);
    //if(query.isEmpty || query == '') {
    //  state = [];
    //  return [];
    //}
  
    final List<StockLookup> stocks = await searchStocks(query);
    

    state = stocks;
    return stocks;
  }


}