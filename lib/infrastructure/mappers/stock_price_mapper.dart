import 'package:stocks_app/domain/entities/stock_price.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_price_finnhub_response.dart';

class StockPriceMapper {
  static StockPrice stockPriceFinnhubToEntity(
    StockPriceFinnhubResponse stockPriceFinnhub,
  ) => StockPrice(
    currentPrice: stockPriceFinnhub.c,
    change: stockPriceFinnhub.d,
    percentChange: stockPriceFinnhub.dp,
    highPriceOfTheDay: stockPriceFinnhub.h,
    lowPriceOfTheDay: stockPriceFinnhub.l,
    openPriceOfTheDay: stockPriceFinnhub.o,
    previousClosePrice: stockPriceFinnhub.pc,
    t: stockPriceFinnhub.t,
  );
}
