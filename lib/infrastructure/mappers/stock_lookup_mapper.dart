import 'package:stocks_app/domain/entities/stock_lookup.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_from_finnhub.dart';

class StockLookupMapper {
  static StockLookup stockLookupFinnhubToEntity(
    StockFromFinnhub stockFromFinnhub,
  ) => StockLookup(
    name: stockFromFinnhub.description, 
    symbol: stockFromFinnhub.symbol, 
    type: stockFromFinnhub.type
  );
}
