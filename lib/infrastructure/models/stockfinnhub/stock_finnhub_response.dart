
class StockFinnhubResponse {
    final String currency;
    final String description;
    final String mic;
    final String symbol;
    final String type;

    StockFinnhubResponse({
        required this.currency,
        required this.description,
        required this.mic,
        required this.symbol,
        required this.type,
    });

    factory StockFinnhubResponse.fromJson(Map<String, dynamic> json) => StockFinnhubResponse(
        currency: json["currency"] ?? '',
        description: json["description"],
        mic: json["mic"] ?? '',
        symbol: json["symbol"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "currency": currency,
        "description": description,
        "mic": mic,
        "symbol": symbol,
        "type": type,
    };
}


