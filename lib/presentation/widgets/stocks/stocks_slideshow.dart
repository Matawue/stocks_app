import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/screens/screens.dart';
import 'package:stocks_app/presentation/widgets/shared/bouncy_card.dart';


class StocksSlideshow extends StatelessWidget {
  StocksSlideshow({super.key});

  final List<Stock> stocks = [
    Stock(currency: '', stockMarket: '', name: '', symbol: 'GOOGL', type: '', image: 'https://gbm.com/media/wp-content/uploads/2025/02/PortadaWeb_google.png'),
    Stock(currency: '', stockMarket: '', name: '', symbol: 'TSLA', type: '', image: 'https://qz.com/cdn-cgi/image/width=1920,quality=85,format=auto/https://assets.qz.com/media/35ae9ecda183041d12f97df49bd8b167.jpg'),
    Stock(currency: '', stockMarket: '', name: '', symbol: 'META', type: '', image: 'https://dnewpydm90vfx.cloudfront.net/wp-content/uploads/2023/01/Meta-pubblicita-comportamentale.jpg'),
    Stock(currency: '', stockMarket: '', name: '', symbol: 'MSFT', type: '', image: 'https://enlinea.santotomas.cl/web/wp-content/uploads/sites/2/2021/01/Microsoft-tecnologia.jpg'),
    Stock(currency: '', stockMarket: '', name: '', symbol: 'AAPL', type: '', image: 'https://cdn-3.expansion.mx/dims4/default/37ae869/2147483647/strip/true/crop/724x483+0+0/resize/1800x1201!/format/webp/quality/80/?url=https%3A%2F%2Fcdn-3.expansion.mx%2F6b%2F32%2F40be384c48eabc8379be6be19374%2Fistock-458610713.jpg'),
    Stock(currency: '', stockMarket: '', name: '', symbol: 'NVDA', type: '', image: 'https://static1.ara.cat/clip/79c88ac9-9d7d-4d54-8e59-17f2dd81b3b3_16-9-aspect-ratio_default_0_x2720y1564.jpg'),
    Stock(currency: '', stockMarket: '', name: '', symbol: 'AMZN', type: '', image: 'https://impulsapopular.com/wp-content/uploads/2020/11/4861-Conoce-los-cuatro-ciclos-para-hacer-crecer-tu-negocio-como-Amazon-.jpg'),

  ];

  @override
  Widget build(BuildContext context) {

    //final colors = Theme.of(context).colorScheme; 

    return SizedBox(
      height: 210,
      width: double.infinity,

      child: Swiper(
        scale: 0.9,
        viewportFraction: 0.8,
        autoplay: true,
        //pagination: SwiperPagination(
        //  margin: const EdgeInsets.only(top: 0,),
        //  builder: DotSwiperPaginationBuilder(
        //    activeSize: 13,
        //    color: Colors.black45,
        //    activeColor: colors.primary
        //  )
        //),


        itemCount: stocks.length,
        itemBuilder: (context, index) {
          return _Slide(stock: stocks[index]);
        },
      ),
    );
  }
}



class _Slide extends ConsumerWidget {

  final Stock stock;

  const _Slide({required this.stock});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stockPrice = ref.watch(stockPriceFromProvider(stock.symbol));
    

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(2, 6)
        )
      ]
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 30),

      child: BouncyCard(
        onPressed: () => context.push('/stock/${stock.symbol}'),
        child: Stack(
          fit: StackFit.expand,
          children: [
            
            
            DecoratedBox(
              decoration: decoration,
            
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.network(
                  stock.image,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress!=null){
                      return DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12) 
                      );
                    }
            
                    return FadeIn(child: child);
                  },
                )
              ),
            ),
        
        
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87] 
                )
              ),
            ),
        
            //TODO: Intentar quitar la logica aqui y solo poner el como se va a ver
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: stockPrice.when(
                  data: (data)=> _PriceOfStock(stockPrice: data, symbol: stock.symbol), 
                  error: (_ , __) => const Text('No se pudieron cargar los precios'), 
                  loading: () => Center(child: CircularProgressIndicator(strokeWidth: 2,),)
                )
              )
            ),
        
        
        
          ],
        ),
      ),
    );
  }
}

class _PriceOfStock extends StatelessWidget {
  
  final StockPrice stockPrice;
  final String symbol;

  const _PriceOfStock({
    required this.stockPrice,
    required this.symbol
  });

  @override
  Widget build(BuildContext context) {
    final percentageIncrease= ((stockPrice.currentPrice/stockPrice.previousClosePrice)-1)*100;
    
    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(symbol, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),),
          
          Row(
            children: [
              
              Text('\$${stockPrice.currentPrice}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),

              const SizedBox(width: 10,),
          
              (percentageIncrease > 0)
                ?Text('+${(stockPrice.currentPrice-stockPrice.previousClosePrice).toStringAsFixed(2)} (+${(percentageIncrease).toStringAsFixed(2)}%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green.shade700),)
                :Text('${(stockPrice.currentPrice-stockPrice.previousClosePrice).toStringAsFixed(2)} (${(percentageIncrease).toStringAsFixed(2)}%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red.shade700),),
              (percentageIncrease > 0)
                ?Icon(Icons.arrow_drop_up, color: Colors.green.shade700, size: 26,)
                :Icon(Icons.arrow_drop_down, color: Colors.red.shade700, size: 26,)
              
            ],
          ),
        ],
      ),
    );
  }
}