class StockLookup {
  //TODO: borrar esta entidad y usar el Stock normal
  final String name;
  final String symbol;
  final String type;
  final String image;

  StockLookup({
    required this.name,
    required this.symbol, 
    required this.type,
    this.image = 'No hay imagen'
  });
}
