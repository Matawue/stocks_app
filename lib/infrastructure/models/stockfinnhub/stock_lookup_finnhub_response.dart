import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_from_finnhub.dart';

class StockLookupFinnhubResponse {
    final int count;
    final List<StockFromFinnhub> result;

    StockLookupFinnhubResponse({
        required this.count,
        required this.result,
    });

    factory StockLookupFinnhubResponse.fromJson(Map<String, dynamic> json) => StockLookupFinnhubResponse(
        count: json["count"],
        result: List<StockFromFinnhub>.from(json["result"].map((x) => StockFromFinnhub.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}