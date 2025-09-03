

import 'package:dio/dio.dart';
import 'package:stocks_app/config/constants/environment.dart';
import 'package:stocks_app/domain/datasources/stock_datasource.dart';
import 'package:stocks_app/infrastructure/mappers/stock_mapper.dart';
import 'package:stocks_app/infrastructure/mappers/stock_price_mapper.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_finnhub_response.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_price_finnhub_response.dart';

class StockFinnhubDatasource extends StockDatasource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://finnhub.io/api/v1',
    queryParameters: {
      'token': Environment.theFinnhubKey
    }
  ));

  final dioImage = Dio(BaseOptions(
    baseUrl: 'https://images.financialmodelingprep.com/symbol'
  ));

  @override
  Future<StockPrice> getStockPrice(String symbol) async{ // TODO: pasarle argumento de nombre del symbol que la persona desee
    final response = await dio.get('/quote',
    queryParameters: {
      'symbol': symbol
    });

    final stockPriceResponse = StockPriceFinnhubResponse.fromJson(response.data);
    final StockPrice stockPrice = StockPriceMapper.stockPriceFinnhubToEntity(stockPriceResponse);


    return stockPrice;

  }

  @override
  Future<List<Stock>> getStock({String marketIdentifierCode = 'XNYS'}) async{
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

    final filteredStock = <StockFinnhubResponse>[];

    for(final stockFinnhub in stockResponse){
      if(await hasImageBySymbol(stockFinnhub.symbol)){
        filteredStock.add(stockFinnhub);
      }
    }
    
    final List<Stock> stock = filteredStock
    //quiero que si la llamada a la imagen su respuesta es de 200(Existosa) si se mapee, por el contrario, no me interesa
    //Pienso que tendre que poner un metodo tanto en el datasource como en el repository para esto
    //.where(
    //  (stockFinnhub) => (hasImageBySymbol(stockFinnhub.symbol)) 
    //)
    .map(
      (stockFinnhub) => StockMapper.stockFinnhubToEntity(stockFinnhub)
    ).toList();

    
    return stock;
  }
  
  @override
  Future<bool> hasImageBySymbol(String symbol) async{
   try {
      final response = await dioImage.get('/$symbol.png');
      return response.statusCode == 200;
    } on DioException catch (e) {
    if (e.response?.statusCode == 404) return false;
    if(e.response?.statusCode != 200) return false;
    rethrow; // otros errores, relanza la excepción
  }
  }

}