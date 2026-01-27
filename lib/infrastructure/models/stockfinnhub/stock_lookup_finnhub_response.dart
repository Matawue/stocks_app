import 'package:stocks_app/infrastructure/models/stockfinnhub/stock_finnhub_response.dart';

class StockLookupFinnhubResponse {
    final int count;
    final List<StockFinnhubResponse> result;

    StockLookupFinnhubResponse({
        required this.count,
        required this.result,
    });

    factory StockLookupFinnhubResponse.fromJson(Map<String, dynamic> json) => StockLookupFinnhubResponse(
        count: json["count"],
        result: List<StockFinnhubResponse>.from(json["result"].map((x) => StockFinnhubResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}