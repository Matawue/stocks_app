import 'package:stocks_app/domain/entities/entities.dart';



abstract class StockDatasource {

  Future<StockPrice> getStockPrice();
  
  Future<List<Stock>> getStock({String marketIdentifierCode = 'XNYS'});

}