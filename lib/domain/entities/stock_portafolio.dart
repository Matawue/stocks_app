class StockPortafolio {
  final String name;
  final String symbol;
  final String imageUrl; //Este probablemente lo pondré
  final double currentPrice;
  final double previousClosePrice;
  final double amoutOfStock;
  //TODO: hacer uno de a cual precio se invirtio en la accion(coste promedio)

  StockPortafolio({
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.previousClosePrice,
    required this.amoutOfStock,
    required this.imageUrl,
  });
}
