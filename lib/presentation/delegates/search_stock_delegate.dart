import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app/domain/entities/entities.dart';

typedef SearchStocksCallback = Future<List<StockLookup>>Function( String query );

class SearchStockDelegate extends SearchDelegate<StockLookup?>{

  final SearchStocksCallback searchStocks;

  SearchStockDelegate({
    required this.searchStocks
  });

  @override
  String get searchFieldLabel => 'Buscar acciones';

  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
      //if(query.isNotEmpty) 
        FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: () => query = '', 
            icon: const Icon(Icons.clear_rounded)
          ),
        )
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchStocks(query), 
      builder: (context, snapshot) {
        final stocks = snapshot.data ?? []; 
        return ListView.builder(
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(stocks[index].name),);
          }
        );
      }
    );
  }




}