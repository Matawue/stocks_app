import 'package:stocks_app/domain/entities/stock_price.dart';
import 'package:stocks_app/infraestructure/models/stockfinnhub/stock_finnhub_response.dart';

class StockPriceMapper {
  static StockPrice stockPriceFinnhubToEntity(
    StockFinnhubResponse stockFinnhub,
  ) => StockPrice(
    currentPrice: stockFinnhub.c,
    change: stockFinnhub.d,
    percentChange: stockFinnhub.dp,
    highPriceOfTheDay: stockFinnhub.h,
    lowPriceOfTheDay: stockFinnhub.l,
    openPriceOfTheDay: stockFinnhub.o,
    previousClosePrice: stockFinnhub.pc,
    t: stockFinnhub.t,
  );
}
