import 'package:stocks_app/domain/datasources/stock_datasource.dart';
import 'package:stocks_app/domain/entities/stock.dart';
import 'package:stocks_app/domain/entities/stock_price.dart';
import 'package:stocks_app/domain/repositories/stock_repository.dart';



class StockRepositoryImpl extends StockRepository{

  final StockDatasource datasource;

  StockRepositoryImpl(this.datasource);


  @override
  Future<StockPrice> getStockPrice(String symbol) {
    return datasource.getStockPrice(symbol);
  }

  @override
  Future<void> getStock({required String marketIdentifierCode, required void Function(Stock) onStockFound}) {
    return datasource.getStock(onStockFound: onStockFound, marketIdentifierCode: marketIdentifierCode);
  }
  
  @override
  Future<bool> hasImageBySymbol(String symbol) {
    return datasource.hasImageBySymbol(symbol);
  }
  

}