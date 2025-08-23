


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/infrastructure/datasources/stock_finnhub_datasource.dart';
import 'package:stocks_app/infrastructure/repositories/stock_repository_impl.dart';

final stockRepositoryProvider = Provider((ref) {
  return StockRepositoryImpl(StockFinnhubDatasource());
});