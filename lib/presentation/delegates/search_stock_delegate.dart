import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app/domain/entities/entities.dart';

typedef SearchStocksCallback = Future<List<StockLookup>>Function( String query );

//TODO: Buscar una manera de poder hacer que cuando busque se quede guardado lo que busco

class SearchStockDelegate extends SearchDelegate<StockLookup?>{

  final SearchStocksCallback searchStocks;

  // Se hace un Stream con su metodo broadcast, ya que es posible de que tenga mas de un listener en las funciones
  // Si tiene solo un listener entonces ocupar StreamController solo
  StreamController<List<StockLookup>> debouncedStocks = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchStockDelegate({
    required this.searchStocks
  });

  //TODO: seria bueno implementar un isLoading, y que si esta con isLoading, entonces me muestre el esqueleto de carga
  void _onQueryChanged( String query ) {
    if( _debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () async{
      if(query.isEmpty) {
        debouncedStocks.add([]);
        return;
      }
      final stocks = await searchStocks(query);
      debouncedStocks.add(stocks);

    });
  }

  void _clearStreams() {
    debouncedStocks.close();
  }

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
      onPressed: () {
        _clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //TODO: Puede que aqui no deje nada de logica y la deje solo en el results, porque no me interesa hacer tantas peticiones http

    _onQueryChanged(query);
    return StreamBuilder(
      //future: searchStocks(query),
      stream: debouncedStocks.stream, 
      builder: (context, snapshot) {

        final stocks = snapshot.data ?? [];
        //TODO: hacer un if donde si no hay nada que me haga un esqueletos de ListTile de carga
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: stocks.length,
          itemBuilder: (context, index) =>_StockItem(
            stock: stocks[index], 
            onStockSelected: (context, stock) {
              _clearStreams();
              close(context, stock);
            }
          )
        );
      }
    );
  }
}

class _StockItem extends StatelessWidget {
  
  final StockLookup stock;
  final Function onStockSelected;


  const _StockItem({
    required this.stock, 
    required this.onStockSelected
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        
        
        //dense: true,
        minTileHeight: 60,
        visualDensity: VisualDensity.compact,
        tileColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10)
        ),

        //TODO: Probablemente en la imagen sea mejor poner un dato duro, en vez de dependiendo del size de la pantalla
        leading: ClipOval(
          child: Image.network(
            height: size.height*0.05,
            width: size.height*0.05,
            stock.image,
            loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
          ),
        ),

        title: Text(stock.name, style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
        subtitle: Text(stock.symbol, style: textStyle.bodySmall!.copyWith(color: Colors.black45, fontWeight: FontWeight.w500),),

        //TODO: podria ser una funcionalidad para agregar el stock a tu portafolio
        trailing: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.add_box_outlined)
        ),
        
        onTap: () {
          //context.push('/stock/${stock.symbol}');
          onStockSelected(context, stock);
        },

      ),
    );
  }
}