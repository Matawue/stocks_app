import 'package:stocks_app/domain/entities/entities.dart';



abstract class StockRepository {

  Future<StockPrice> getStockPrice(String symbol);

  Future<void> getStock({required String marketIdentifierCode, required void Function(Stock) onStockFound});

  Future<bool> hasImageBySymbol(String symbol);

  Future<StockInfo> getStockInfo(String symbol);

  Future<List<StockLookup>> searchStocks(String query);

}