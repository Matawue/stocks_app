import 'package:stocks_app/domain/entities/entities.dart';



abstract class StockRepository {

  Future<StockPrice> getStockPrice(String symbol);

  Future<List<Stock>> getStock({String marketIdentifierCode = 'XNYS'});

}