

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

  @override
  Future<StockPrice> getStockPrice() async{ // TODO: pasarle argumento de nombre del symbol que la persona desee
    final response = await dio.get('/quote',
    queryParameters: {
      'symbol': 'GOOGL'
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

    final List<StockFinnhubResponse> stockResponse = data
    .map(
      (json) => StockFinnhubResponse.fromJson(json)
    ).toList();
    
    final List<Stock> stock = stockResponse.map(
      (stockFinnhub) => StockMapper.stockFinnhubToEntity(stockFinnhub)
    ).toList();

    
    return stock;
  }

}