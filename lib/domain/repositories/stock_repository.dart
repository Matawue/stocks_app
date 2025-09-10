import 'package:stocks_app/domain/entities/entities.dart';



abstract class StockRepository {

  Future<StockPrice> getStockPrice(String symbol);

  Future<void> getStock({String marketIdentifierCode = 'XNYS', required void Function(Stock) onStockFound});

  Future<bool> hasImageBySymbol(String symbol);

}