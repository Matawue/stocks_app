

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/entities.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

//final searchedStocksProvider = StateNotifierProvider<>((ref) {
//  return 
//});

class SearchedStocksNotifier extends StateNotifier<List<StockLookup>>{
  
  SearchedStocksNotifier(): super([]);

  Future<List<StockLookup>> searchStocksByQuery(String query) async{


    return [];
  }


}