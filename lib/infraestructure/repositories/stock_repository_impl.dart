import 'package:stocks_app/domain/datasources/stock_datasource.dart';
import 'package:stocks_app/domain/entities/stock_price.dart';
import 'package:stocks_app/domain/repositories/stock_repository.dart';



class StockRepositoryImpl extends StockRepository{

  final StockDatasource datasource;

  StockRepositoryImpl(this.datasource);


  @override
  Future<StockPrice> getStockPrice() {
    return datasource.getStockPrice();
  }

}