

import 'package:dio/dio.dart';
import 'package:stocks_app/config/constants/environment.dart';
import 'package:stocks_app/domain/datasources/stock_datasource.dart';
import 'package:stocks_app/domain/entities/stock_price.dart';
import 'package:stocks_app/infraestructure/mappers/stock_price_mapper.dart';
import 'package:stocks_app/infraestructure/models/stockfinnhub/stock_finnhub_response.dart';

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

    final stockPriceResponse = StockFinnhubResponse.fromJson(response.data);
    final StockPrice stockPrice = StockPriceMapper.stockPriceFinnhubToEntity(stockPriceResponse); 


    return stockPrice;

  }

}