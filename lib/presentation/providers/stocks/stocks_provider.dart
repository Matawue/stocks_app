

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';



final getStocksFromNYProvider = StateNotifierProvider<StocksNotifier, List<Stock>>((ref) {
  final stocks = ref.watch(stockRepositoryProvider).getStock;
  return StocksNotifier(
    stocks: stocks,
    marketIdentifierCode: 'XNYS'
  );

});

final getStocksFromNASProvider = StateNotifierProvider<StocksNotifier, List<Stock>>((ref) {
  final stocks = ref.watch(stockRepositoryProvider).getStock;
  return StocksNotifier(
    stocks: stocks,
    marketIdentifierCode: 'XNAS'
  );

});

typedef StockCallback = Future<void> Function ({required String marketIdentifierCode, required void Function(Stock) onStockFound});

class StocksNotifier extends StateNotifier<List<Stock>> {
  int currentPage = 0;
  bool isLoading = false;
  final StockCallback stocks;
  final String marketIdentifierCode;

  final List<Stock> _allStocks = [];


  StocksNotifier({
    required this.stocks,
    required this.marketIdentifierCode
  }) : super([]);

  Future<void> loadStocksIncremental() async {

    await stocks(
        marketIdentifierCode: marketIdentifierCode,

        // Función que me permite agregar uno a uno los stocks desde el datasource de Finnhub
        onStockFound: (stock) {
          _allStocks.add(stock);

          /* 
          
          Si el listado de _allStocks tiene menos de 20 elementos y el estado esta vacío, 
          llama a loadNextPage para empezar a agregar stocks al estado
          
          */
          if(_allStocks.length >= 4 && state.isEmpty) loadNextPage();
        },
      );
  }

  Future<void> loadNextPage() async{
    // Si esta cargando retorna
    if(isLoading) return;
    
    // Si el _allStocks esta vacío retorna
    if(_allStocks.isEmpty) return;

    isLoading = true;
    
    /* 
    
    El offset será usado para desplazarme en el listado, 
    donde se multiplicara por 10 dependiendo de la pagina en la que estemos, 
    ya que cada pagina tendra 10 elementos(stocks)
    
    */
    int offset = currentPage*4;

    //creo tempStocksList para ir guardando aqui las acciones que luego agregare al state
    List<Stock> tempStocksList = [];

    //*pensando en poner el modulo de 10 de el length para contar

    // for para agregar 10 stocks dependiendo del desplazamiento del offset
    for(int i = offset; i<offset+4 && i<_allStocks.length; i++){
      tempStocksList.add(_allStocks[i]);
    }

    // Pasamos a la siguiente pagina sumandole 1 a la actual
    currentPage++;

    // Se agrega el nuevo listado tempStocksList al state
    state = [...state, ...tempStocksList];

    // Damos un tiempo de 2 segundos antes de que el isLoading sea false y nos permita cargar mas stocks
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;

  }
}