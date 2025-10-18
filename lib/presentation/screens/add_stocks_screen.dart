import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_app/presentation/delegates/search_stock_delegate.dart';
import 'package:stocks_app/presentation/providers/providers.dart';

//TODO: Pantalla para añadir stocks al portafolio, seguir con esta luego de tener todo funcionando bien
class AddStocksScreen extends ConsumerWidget {
  const AddStocksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        leadingWidth: 0,
        title: SizedBox(
          width: size.width*0.75,
          
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

            label: const Text('Añadir acción', style: TextStyle(fontSize: 18),),
            icon: Icon(Icons.search, size: 22,),
            iconAlignment: IconAlignment.start,
            style: ButtonStyle(
              alignment: AlignmentGeometry.centerLeft,
              backgroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade300),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              context.pop();
            }, 
            child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold),)
          )
        ],
      ),




      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Spacer(),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: FilledButton(
                  onPressed: (){}, 
                  child: Text('Listo')
                ),
              ),
            ),

            SizedBox(height: 15,)
          ],
        ),
      ),



    );
  }
}