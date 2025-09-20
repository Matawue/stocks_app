//Este es del search/lookup
class StockFromFinnhub {
    final String description;
    final String symbol;
    final String type;

    StockFromFinnhub({
        required this.description,
        required this.symbol,
        required this.type,
    });

    factory StockFromFinnhub.fromJson(Map<String, dynamic> json) => StockFromFinnhub(
        description: json["description"],
        symbol: json["symbol"],
        type: json["type"]
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "symbol": symbol,
        "type": type,
    };
}