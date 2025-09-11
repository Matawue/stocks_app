class StockInfo {
  final String country;
  final String currency;
  final String exchange;
  final DateTime ipo;
  final double marketCapitalization;
  final String name;
  final String phone;
  final double shareOutstanding;
  //final String ticker; para que hacerlo si tengo el symbol por la navegacion de paginas
  final String weburl;
  //final String logo; podria hacerlo, pero tendria que hacer mucho para rehacer lo que ya hice con el llamado de imagenes, tengo que pensarlo
  final String finnhubIndustry;

  StockInfo({
    required this.country,
    required this.currency,
    required this.exchange,
    required this.ipo,
    required this.marketCapitalization,
    required this.name,
    required this.phone,
    required this.shareOutstanding,
    required this.weburl,
    required this.finnhubIndustry,
  });
}
