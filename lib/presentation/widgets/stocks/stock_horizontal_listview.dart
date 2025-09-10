import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_app/domain/entities/entities.dart';



class StockHorizontalListview extends StatefulWidget {
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
  State<StockHorizontalListview> createState() => _StockHorizontalListviewState();
}

class _StockHorizontalListviewState extends State<StockHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if(scrollController.position.pixels+100 >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return SizedBox(height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.title, style: textStyle,),
          ),
          SizedBox(height: 15,),

          
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.stocks.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                
                return _StocksSwipe(stock: widget.stocks[index]);
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
    final textStyle = Theme.of(context).textTheme.titleLarge;
    
    return GestureDetector(
      onTap: () => context.push('/stock/${stock.symbol}'),
      child: Container(
        width: 130,
        margin: EdgeInsets.symmetric(horizontal: 10,),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey
        ),
        
      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ClipOval(
                  child: Image.network(
                    stock.image,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
      
            SizedBox(
              width: 100,
              child: Center(child: Text(stock.symbol, style: textStyle,)),
            )
      
      
          ],
        )
          
      ),
    );
   
  }
}