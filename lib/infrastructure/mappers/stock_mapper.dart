import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_finnhub_response.dart';

class StockMapper {
  static Stock stockFinnhubToEntity(StockFinnhubResponse stockFinnhub) => Stock(
    currency: stockFinnhub.currency,
    stockMarket: stockFinnhub.mic,
    name: stockFinnhub.description,
    symbol: stockFinnhub.symbol,
    type: stockFinnhub.type,
    image: 'https://images.financialmodelingprep.com/symbol/${stockFinnhub.symbol}.png'
  );
}
