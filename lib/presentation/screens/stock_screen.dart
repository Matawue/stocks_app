import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/providers/stocks/stocks_repository_provider.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: poner la logica en un archivo aparte
final FutureProviderFamily<StockPrice, String> stockPriceFromProvider =
FutureProviderFamily(( ref, String symbol ) {
  return ref.watch(stockRepositoryProvider).getStockPrice(symbol);
});

final FutureProviderFamily<StockInfo, String> stockInfoFromProvider =
FutureProviderFamily(( ref, String symbol ) {
  return ref.watch(stockRepositoryProvider).getStockInfo(symbol);
});

final combinedStockProvider = FutureProvider.family<({StockPrice price, StockInfo info}), String>((ref, symbol) async {
  final price = await ref.watch(stockPriceFromProvider(symbol).future);
  final info = await ref.watch(stockInfoFromProvider(symbol).future);
  return (price: price, info: info);
});

void openUrl(String url) async {
  final uri = Uri.parse(url);
  final bool canLaunch = await canLaunchUrl(uri); 
  if(canLaunch) {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  } else {
    throw 'No se pudo abrir el enlace'; //TODO: manejar error con un snackbar
  }
}

class StockScreen extends ConsumerWidget {
  final String symbol;
  const StockScreen({
    super.key, 
    required this.symbol
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final combined = ref.watch(combinedStockProvider(symbol));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(symbol),
        //actions: [
        //  Image.network('https://images.financialmodelingprep.com/symbol/$symbol.png')
        //],
      ),

      body: combined.when(
        data: (data) => _StockView(info: data.info, price: data.price, symbol: symbol,), 
        error: (_ , __) => const Text('No se pudieron cargar los precios'), 
        loading: () => Center(child: CircularProgressIndicator(strokeWidth: 2,),)
      )
    );
  }
}


class _StockView extends StatelessWidget {
  final StockInfo info;
  final StockPrice price;
  // TODO: Quitar este symbol y agregarle el ticket al StockInfo para no tener que pedir, que no se cual de las 2 sea mejor opción
  final String symbol;
  
  const _StockView({
    required this.info,
    required this.price,
    required this.symbol
  });

  @override
  Widget build(BuildContext context) {

    final percentageIncrease= ((price.currentPrice/price.previousClosePrice)-1)*100;

    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(color: Colors.black, height: 20,),
        
            // Imagen, nombre, precio actual y porcentaje de subida en el dia
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        
                //Imagen
                GestureDetector(
                  onTap: () {
                    if (info.weburl.isNotEmpty &&
                        (info.weburl.startsWith('http://') || info.weburl.startsWith('https://'))) {
                      openUrl(info.weburl);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Enlace no válido')),
                      );
                    }
                  },
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipOval(
                      child: Image.network('https://images.financialmodelingprep.com/symbol/$symbol.png')
                    ),
                  ),
                ),

                const SizedBox(width: 10,),
        
                //Nombre compañía con precio actual y porcentaje
                SizedBox(
                  height: 103,
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
        
                    children: [
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: 300,
                        child: Text(info.name, style: textStyle.titleSmall!.copyWith(fontWeight: FontWeight.bold), maxLines: 2,)
                      ),
                      
                      Text('US\$${price.currentPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),

                      Row(
                        children: [
                          (percentageIncrease > 0)
                            ?Text('+${(price.currentPrice-price.previousClosePrice).toStringAsFixed(2)}(+${(percentageIncrease).toStringAsFixed(2)}%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green.shade700),)
                            :Text('${(price.currentPrice-price.previousClosePrice).toStringAsFixed(2)}(${(percentageIncrease).toStringAsFixed(2)}%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red.shade700),),
                          (percentageIncrease > 0)
                          ?Icon(Icons.arrow_outward_rounded, color: Colors.green.shade700,)
                          :Icon(Icons.south_east_rounded, color: Colors.red.shade700,)
                          
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
        
            const SizedBox(height: 15,),
        
            const Divider(color: Colors.black, height: 20,),
        
            const SizedBox(height: 10,),
        
            //Apartado de precios
            Text('Precios', style: textStyle.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            _PriceWidget(textStyle: textStyle, price: price),

            const Divider(color: Colors.black, height: 20,),
            const SizedBox(height: 10,),

            //Apartado de Información de la compañía
            Text('Información de la compañía', style: textStyle.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            _InfoCompanyWidget(info: info, textStyle: textStyle),

            
          ],
        ),
      ),
    );
  }
}

class _InfoCompanyWidget extends StatelessWidget {
  const _InfoCompanyWidget({
    required this.info,
    required this.textStyle,
  });

  final StockInfo info;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      shrinkWrap: true,
      childAspectRatio: 3.5,
      
      children: [
        Text('País: ${info.country}', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),),
        
        Text('Divisa: ${info.currency}', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),),
        
        Text('Mercado: ${info.exchange}', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold), maxLines: 2,),
    
        Text('Industria: ${info.finnhubIndustry}', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold), ),
    
        //TODO: capaz le pongo Billions
        Text('Capitalización: \$${info.marketCapitalization.toStringAsFixed(2)}', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold), ),
        
        Text('Nombre: ${info.name}', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold), maxLines: 2, ),
        
        //Text('web: ${info.weburl}', style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold), ),
        
      ],
    );
  }
}

class _PriceWidget extends StatelessWidget {
  const _PriceWidget({
    required this.textStyle,
    required this.price,
  });

  final TextTheme textStyle;
  final StockPrice price;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      shrinkWrap: true,
      childAspectRatio: 3,
      
      children: [
        //Precio Apertura
        _StockPriceText(textStyle: textStyle, price: price.openPriceOfTheDay, description: 'Precio apertura',),
        
        
        //Precio Cierre Anterior
        _StockPriceText(textStyle: textStyle, price: price.previousClosePrice, description: 'Precio cierre anterior',),
        
    
        //Precio más alto
        _StockPriceText(textStyle: textStyle, price: price.highPriceOfTheDay, description: 'Precio más alto',),
        
        //Precio más bajo
        _StockPriceText(textStyle: textStyle, price: price.lowPriceOfTheDay, description: 'Precio más bajo',),
        
      ],
    );
  }
}

class _StockPriceText extends StatelessWidget {
  const _StockPriceText({
    required this.textStyle,
    required this.price,
    required this.description,
  });

  final TextTheme textStyle;
  final double price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description, style: textStyle.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
        Text('US\$${price.toStringAsFixed(2)}', style: textStyle.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
      ],
    );
  }
}