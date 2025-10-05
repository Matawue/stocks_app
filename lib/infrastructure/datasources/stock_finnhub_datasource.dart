import 'package:dio/dio.dart';
import 'package:pool/pool.dart';
import 'package:stocks_app/config/constants/environment.dart';
import 'package:stocks_app/domain/datasources/stock_datasource.dart';
import 'package:stocks_app/infrastructure/mappers/stock_info_mapper.dart';
import 'package:stocks_app/infrastructure/mappers/stock_lookup_mapper.dart';
import 'package:stocks_app/infrastructure/mappers/stock_mapper.dart';
import 'package:stocks_app/infrastructure/mappers/stock_price_mapper.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_finnhub_response.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_info_finnhub_response.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_lookup_finnhub_response.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_price_finnhub_response.dart';

class StockFinnhubDatasource extends StockDatasource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://finnhub.io/api/v1',
    queryParameters: {
      'token': Environment.theFinnhubKey
    }
  ));

  final dioImage = Dio(BaseOptions(
    baseUrl: 'https://images.financialmodelingprep.com/symbol',
    validateStatus: (status) {
      return status != null && status <= 500;
    },
  ));

  @override
  Future<StockPrice> getStockPrice(String symbol) async{
    final response = await dio.get('/quote',
    queryParameters: {
      'symbol': symbol
    });

    final stockPriceResponse = StockPriceFinnhubResponse.fromJson(response.data);
    final StockPrice stockPrice = StockPriceMapper.stockPriceFinnhubToEntity(stockPriceResponse);


    return stockPrice;

  }

  @override
  Future<void> getStock({required String marketIdentifierCode, required void Function(Stock) onStockFound,}) async{
    final response = await dio.get('/stock/symbol',
    queryParameters: {
      'exchange': 'US',
      'mic': marketIdentifierCode,
      'currency': 'USD'
    });
    

    final List<dynamic> data = response.data;

    final stockResponse = data
    .map(
      (json) => StockFinnhubResponse.fromJson(json)
    );


    final pool = Pool(10);


    for(final stockFinnhub in stockResponse) {
      pool.withResource(() async {
        final hasImage = await hasImageBySymbol(stockFinnhub.symbol);
        if(hasImage) {
          onStockFound(StockMapper.stockFinnhubToEntity(stockFinnhub));
        }
      });
    }
    //final filteredStock = results.whereType<StockFinnhubResponse>();
    await pool.close();
  
  }
  
  @override
  Future<bool> hasImageBySymbol(String symbol) async{
  /*

  Bloque try que usaba antes, decidi no usarlo para no crear 
  objetos innecesarios de Excepciones, ya que al ser muchas llamadas
  puede haber un retraso significativo. Además no me interesa una
  excepción en especifico, y para eso se suelen usar los try, yo quiero tratar
  los errores de manera generalizada
    
  */

   //try {
   //   final response = await dioImage.get('/$symbol.png');
   //   return response.statusCode == 200;
   // } on DioException catch (e) {
   //   if(e.response?.statusCode != 200) return false;
   //   rethrow; // otros errores, relanza la excepción
   // }

    
    /*

    Esta es mejor, ya que no me interesa manejar las excepciones,
    solo me interesa saber si cargo la imagen o no, si la cargo correctamente 
    la podré ocupar(retorna true) y si me da un error, pues no(retorna false) 


    */
    final response = await dioImage.get('/$symbol.png');
    if(response.statusCode==200) {
      return true;
    } else {
      return false;
    }
  }
  
  @override
  Future<StockInfo> getStockInfo(String symbol) async{
    final response = await dio.get(
      '/stock/profile2',
      queryParameters: {
        'symbol': symbol
      }
    );

    final stockInfoResponse = StockInfoFinnhubResponse.fromJson(response.data);

    final stockInfo = StockInfoMapper.stockInfoFinnhubToEntity(stockInfoResponse);

    return stockInfo;
    
  }
  
  @override
  Future<List<StockLookup>> searchStocks(String query) async{
    
    // Si no hay nada en el query de busqueda no realizar petición http
    if(query.isEmpty || query == '') return [];
    
    final response = await dio.get(
      '/search',
      queryParameters: {
        'q': query,
        'exchange': 'US'
      }
    );
    

    //TODO: capaz tambien deberia poner como entidad que sea un stock en vez de stocklookup y poner que pueden ser nulos los atributos que no posee el lookup
    final stocksLookupResponse = StockLookupFinnhubResponse.fromJson(response.data);
    final pool = Pool(5);

    List<StockLookup> stocksLookup = [];

    for(final stockLookup in stocksLookupResponse.result) {
      await pool.withResource(() async {
        final hasImage = await hasImageBySymbol(stockLookup.symbol);
        if(hasImage) {
          stocksLookup.add(StockLookupMapper.stockLookupFinnhubToEntity(stockLookup));
        }
      });
    }
    await pool.close();
    return stocksLookup;
  }
}