import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //final stockPrice = ref.watch(stockPriceFromProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Google')),
      ),

      body: const Center(child: Text('Bienvenido')) 
      
      //stockPrice.when(
      //  data: (data) => Center(child: Text('Precio de la accion: ${data.currentPrice}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),)), 
      //  error: (_ , __) => const Center(child: Text('No se ha pordido cargar el precio de la accion'),), 
      //  loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2,),),
      //),

    );
  }
}