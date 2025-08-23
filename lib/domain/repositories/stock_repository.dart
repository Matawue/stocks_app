import 'package:stocks_app/domain/entities/entities.dart';



abstract class StockRepository {

  Future<StockPrice> getStockPrice();

  Future<List<Stock>> getStock({String marketIdentifierCode = 'XNYS'});

}