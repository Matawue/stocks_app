import 'package:stocks_app/domain/entities/stock_price.dart';



abstract class StockDatasource {

  Future<StockPrice> getStockPrice();

}