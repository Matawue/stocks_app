import 'package:flutter/material.dart';
import 'package:stocks_app/domain/entities/entities.dart';



class StockHorizontalListview extends StatelessWidget {
  final List<Stock> stocks;
  final VoidCallback? loadNextPage;
  final String title;

  const StockHorizontalListview({
    super.key, 
    this.loadNextPage, 
    required this.stocks, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return SizedBox(height: 250,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text(title, style: textStyle,),
          SizedBox(height: 15,),

          
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                
                return _StocksSwipe(stock: stocks[index]);
              }
            ),
          )
          
        ],
      ),
    );
  }
}


class _StocksSwipe extends StatelessWidget {
  final Stock stock;
  const _StocksSwipe({
    required this.stock
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),

      child: SizedBox(
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: Column(
            children: [
              // TODO: Poner imagen del stock, gesture detector y el symbol del stock
              Placeholder()
            ],
          ),
        ),
      )
        
    );
   
  }
}