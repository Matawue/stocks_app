import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';


final FutureProviderFamily<StockPrice, String> stockPriceFromProvider =
FutureProviderFamily(( ref, String symbol ) async{
  return ref.watch(stockRepositoryProvider).getStockPrice(symbol);
});

class StockScreen extends ConsumerWidget {
  final String symbol;
  const StockScreen({
    super.key, 
    required this.symbol
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stockPrice = ref.watch(stockPriceFromProvider(symbol));

    return Scaffold(
      appBar: AppBar(
        title: Text(symbol),
        actions: [
          Image.network('https://images.financialmodelingprep.com/symbol/$symbol.png')
        ],
      ),

      body: stockPrice.when(
        data: (data) => Center(child: Text('Precio de la accion ${data.currentPrice}'),), 
        error: (_ , __) => const Text('No se pudieron cargar los precios'), 
        loading: () => Center(child: CircularProgressIndicator(strokeWidth: 2,),)
      )
    );
  }
}