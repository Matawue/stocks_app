import 'package:stocks_app/domain/entities/stock_info.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_info_finnhub_response.dart';

class StockInfoMapper {
  static StockInfo stockInfoFinnhubToEntity(
    StockInfoFinnhubResponse stockInfoFinnhub,
  ) => StockInfo(
    country: stockInfoFinnhub.country,
    currency: stockInfoFinnhub.currency,
    exchange: stockInfoFinnhub.exchange,
    ipo: stockInfoFinnhub.ipo,
    marketCapitalization: stockInfoFinnhub.marketCapitalization,
    name: stockInfoFinnhub.name,
    phone: stockInfoFinnhub.phone,
    shareOutstanding: stockInfoFinnhub.shareOutstanding,
    weburl: stockInfoFinnhub.weburl,
    finnhubIndustry: stockInfoFinnhub.finnhubIndustry,
  );
}
