import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/widgets/shared/bouncy_card.dart';



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
    return SizedBox(
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.title, style: textStyle,),
          ),
          SizedBox(height: 5,),

          
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
    final textStyle = Theme.of(context).textTheme;
    
    return FadeInRight(
      child: BouncyCard(
        onPressed: () => context.push('/stock/${stock.symbol}'),
        child: Container(
          width: 125,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          padding: EdgeInsets.symmetric(vertical: 15,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 245, 245, 245),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 0),
                blurRadius: 1.6
              )
            ]
          ),
          
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 85,
                height: 85,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: ClipOval(
                    child: Image.network(
                      stock.image,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 2,),
        
              SizedBox(
                width: 70,
                child: Center(child: Text(stock.symbol, style: textStyle.titleMedium!.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)),
              ), 
              
              SizedBox(height: 5,), 
              
              SizedBox(
                width: 70,
                child: Text(stock.name, style: textStyle.bodySmall!.copyWith(color: Colors.black45, fontWeight: FontWeight.w500, fontSize: 11.5,), maxLines: 1, overflow: TextOverflow.ellipsis,),
              ),
        
        
            ],
          )
            
        ),
      ),
    );
   
  }
}