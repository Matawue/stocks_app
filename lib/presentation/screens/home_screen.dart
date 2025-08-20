import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/stock_price.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';


final FutureProvider<StockPrice> stockPriceFromProvider =
FutureProvider(( ref ) async{
  return ref.watch(stockRepositoryProvider).getStockPrice();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stockPrice = ref.watch(stockPriceFromProvider);


    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Google')),
      ),

      body: stockPrice.when(
        data: (data) => Center(child: Text('Precio de la accion: ${data.currentPrice}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),)), 
        error: (_ , __) => const Center(child: Text('No se ha pordido cargar el precio de la accion'),), 
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2,),),
      )
    );
  }
}