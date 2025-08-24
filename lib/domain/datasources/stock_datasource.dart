import 'package:stocks_app/domain/entities/entities.dart';



abstract class StockDatasource {

  Future<StockPrice> getStockPrice(String symbol);
  
  Future<List<Stock>> getStock({String marketIdentifierCode = 'XNYS'});

}