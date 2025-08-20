import 'package:stocks_app/domain/entities/stock_price.dart';



abstract class StockRepository {

  Future<StockPrice> getStockPrice();

}