class StockInfoFinnhubResponse {
    final String country;
    final String currency;
    final String estimateCurrency;
    final String exchange;
    final String finnhubIndustry;
    final DateTime ipo;
    final String logo;
    final double marketCapitalization;
    final String name;
    final String phone;
    final double shareOutstanding;
    final String ticker;
    final String weburl;

    StockInfoFinnhubResponse({
        required this.country,
        required this.currency,
        required this.estimateCurrency,
        required this.exchange,
        required this.finnhubIndustry,
        required this.ipo,
        required this.logo,
        required this.marketCapitalization,
        required this.name,
        required this.phone,
        required this.shareOutstanding,
        required this.ticker,
        required this.weburl,
    });

    factory StockInfoFinnhubResponse.fromJson(Map<String, dynamic> json) => StockInfoFinnhubResponse(
        country: json["country"],
        currency: json["currency"],
        estimateCurrency: json["estimateCurrency"],
        exchange: json["exchange"],
        finnhubIndustry: json["finnhubIndustry"],
        ipo: DateTime.parse(json["ipo"]),
        logo: json["logo"],
        marketCapitalization: json["marketCapitalization"]?.toDouble(),
        name: json["name"],
        phone: json["phone"],
        shareOutstanding: json["shareOutstanding"]?.toDouble(),
        ticker: json["ticker"],
        weburl: json["weburl"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "currency": currency,
        "estimateCurrency": estimateCurrency,
        "exchange": exchange,
        "finnhubIndustry": finnhubIndustry,
        "ipo": "${ipo.year.toString().padLeft(4, '0')}-${ipo.month.toString().padLeft(2, '0')}-${ipo.day.toString().padLeft(2, '0')}",
        "logo": logo,
        "marketCapitalization": marketCapitalization,
        "name": name,
        "phone": phone,
        "shareOutstanding": shareOutstanding,
        "ticker": ticker,
        "weburl": weburl,
    };
}
