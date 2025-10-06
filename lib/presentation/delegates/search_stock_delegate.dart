import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/widgets/widgets.dart';


typedef SearchStocksCallback = Future<List<StockLookup>>Function( String query );



class SearchStockDelegate extends SearchDelegate<StockLookup?>{

  final SearchStocksCallback searchStocks;
  List<StockLookup> initialStocks;
  final String searchQuery;
  bool isInitialData;
  bool isLoading = false;
  bool wasTheResult = false;
  
  

  /* 
  
  Se hace un Stream con su metodo broadcast, ya que es posible de que tenga mas de un listener en las funciones
  Si tiene solo un listener entonces ocupar StreamController solo

  */ 
  StreamController<List<StockLookup>> debouncedStocks = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchStockDelegate({
    required this.searchStocks,
    required this.initialStocks,
    required this.searchQuery,
    required this.isInitialData
  }):super(
    searchFieldLabel: 'Buscar acciones', // texto que aparece en el campo de busqueda
    autocorrect: false, // para que no haga autocorrecciones
    //keyboardType: TextInputType.phone
    //searchFieldDecorationTheme: InputDecoration()
    //textInputAction: TextInputAction.done
  );
  


  void _onQueryChanged( String query ) {
    if(!isLoading) isLoading = true;
    if( _debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(seconds: 1), () async{
      
      final stocks = await searchStocks(query);
      initialStocks = stocks;
      
      /*
      
      Ahora que agregue esto cuando escribo algo y me salgo antes de que añada los stocks // el debouncedStocks, pero se añaden al initialStocks cuando obtiene el listado, por lo que si me vuelvo a meter a las busquedas antes de que se complete, sale que tengo el nuevo query, pero sin el nuevo listado, sino que el viejo, arreglar esto
      quedan los stocks de antes debido a que no se alcanzo a añadir el nuevo listado
      TODO: Arreglar este problema
      
      */

      // Si el debouncedStocks no esta cerrado, se añade el listado de stocks al stream
      if(!debouncedStocks.isClosed) debouncedStocks.add(stocks);
      isLoading = false;
    });
  }

  void _clearStreams() {
    debouncedStocks.close();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialStocks,
      stream: debouncedStocks.stream, 
      builder: (context, snapshot) {

        final stocks = snapshot.data ?? [];

        /*

        Si estan cargando las peliculas y hay texto en la consulta, 
        que me retorne un esqueleto de espera,
        si cargaron las peliculas o no hay texto de consulta entonces 
        que me retorne el listado de acciones
        
        */ 
        return (isLoading && query.isNotEmpty)
        ?Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: const Column(
              
              children: [
                
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
                LoadingStockBySearch(),
               
                
              ],
            ),
          ),
        )
        :ListView.builder(

          // TODO: Me gustaría cambiar a Clamping, pero queda raro el widget al extender el scroll
          physics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),

          /*

            Si no hay texto en la consulta que no hayan items
            para que no tenga tiempo de espera en lo que se demora 
            en devolver el listado vacío

          */
          itemCount: (query.isEmpty)
            ?0
            :stocks.length,
          itemBuilder: (context, index) =>StockItemBySearch(
            stock: stocks[index], 
            onStockSelected: (context, stock) {
              _clearStreams();
              close(context, stock); //esto es por si quieres que te saque de la busqueda, al presionar un elemento
            }
          )
        );
      }
    );
  }



  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
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
    wasTheResult = true;
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    //TODO: Aqui esta el error, tengo que ver porque

    /*
    
    Verifica si el query cambio
    
    */
    if(query != searchQuery) isInitialData = false;
  

    //TODO: ver si se puede llegar a simplificar esta logica
    /*
    
    !isInitialData Verifica si la data sigue siendo la inicial, o ya hay que cambiarla.
    !wasTheResult Verifica si ya se disparo el result, si es que se disparo, entonces no se llama el _onQueryChanged(query)
      porque ya se buscaron los stocks y ya se tiene su listado.

    explicación:
    
      Esto es para limitar la petición http al entar inicialmente al sector de busqueda
      con un listado ya cargado, ya que al tener query, lanza el _on_onQueryChanged denuevo,
      asi volviendo a disparar la petición http, ahora con estas condiciones, se logra
      el no volver a hacer la petición innecesariamente (porque ya se tienen los stocks cargados)
    
    */
    if(!isInitialData && !wasTheResult) {
      _onQueryChanged(query);
    }
    wasTheResult = false;
    
    return buildResultsAndSuggestions();
  }
}