

import 'package:dio/dio.dart';
import 'package:pool/pool.dart';
import 'package:stocks_app/config/constants/environment.dart';
import 'package:stocks_app/domain/datasources/stock_datasource.dart';
import 'package:stocks_app/infrastructure/mappers/stock_info_mapper.dart';
import 'package:stocks_app/infrastructure/mappers/stock_mapper.dart';
import 'package:stocks_app/infrastructure/mappers/stock_price_mapper.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_finnhub_response.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_info_finnhub_response.dart';
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

    final pool = Pool(3);


    for(final stockFinnhub in stockResponse) {
      pool.withResource(() async {
        final hasImage = await hasImageBySymbol(stockFinnhub.symbol);
        if(hasImage) {
          final stock = StockMapper.stockFinnhubToEntity(stockFinnhub); 
          onStockFound(stock);
        }
      });
    }
    //final filteredStock = results.whereType<StockFinnhubResponse>();
    await pool.close();
  
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

}