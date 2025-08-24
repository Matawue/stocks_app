import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';



final FutureProvider<List<Stock>> stockListProvider = 
FutureProvider((ref) async{
  final stockRepository = ref.watch(stockRepositoryProvider);
  return stockRepository.getStock();
});

class DiscoverStocksView extends ConsumerWidget {
  const DiscoverStocksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockList = ref.watch(stockListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portafolio'),
      ),

      body: stockList.when(
        data: (stocks) => ListView.builder(
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(stocks[index].name),
              onTap: () => context.push('/stock/${stocks[index].symbol}'),
            );
          }
        ), 
        error: (_, __) => const Text('Algo ha salido mal'), 
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2,),)
      )
    );
  }
}