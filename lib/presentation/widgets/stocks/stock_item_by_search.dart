import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_app/domain/entities/entities.dart';

class StockItemBySearch extends StatelessWidget {
  
  final StockLookup stock;
  final Function onStockSelected;


  const StockItemBySearch({
    super.key, 
    required this.stock, 
    required this.onStockSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        
        
        //dense: true,
        minTileHeight: 60,
        visualDensity: VisualDensity.compact,
        tileColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10)
        ),

        /*

        Aqui va la imagen
        del stock
        
        */
        leading: ClipOval(
          child: Image.network(
            height: 36.6,
            width: 36.6,
            stock.image,
            loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
          ),
        ),
        
        /*

        Nombre y simbolo del stock

        */
        title: Text(stock.name, style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
        subtitle: Text(stock.symbol, style: textStyle.bodySmall!.copyWith(color: Colors.black45, fontWeight: FontWeight.w500),),

        //TODO: podria ser una funcionalidad para agregar el stock a tu portafolio
        trailing: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.add_box_outlined)
        ),
        
        /*

        Si presionas el ListTile, navegas
        al stock screen.

        */
        onTap: () {
          context.push('/stock/${stock.symbol}');
          onStockSelected(context, stock);
        },

      ),
    );
  }
}