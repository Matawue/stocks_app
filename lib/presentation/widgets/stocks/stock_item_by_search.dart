import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stocks_app/domain/entities/entities.dart';
import 'package:stocks_app/presentation/widgets/shared/add_stock_dialog.dart';

class StockItemBySearch extends StatelessWidget {
  
  final Stock stock;
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
        title: Text(stock.symbol, style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
        subtitle: Text(stock.name, style: textStyle.bodySmall!.copyWith(color: Colors.black45, fontWeight: FontWeight.w500, fontSize: 12.5),),

        //TODO: podria ser una funcionalidad para agregar el stock a tu portafolio
        trailing: IconButton(
          onPressed: (){
            
            // TODO: hacer un provider que me reciba el retorno de esto y que sea la accion y cuantas acciones, para asi ponerlo en el portafolio
            showDialog(
              context: context, 
              builder: (context){
                return AddStockDialog(stock: stock);
              } 
            );
          
          }, 
          icon: Icon(Icons.add_circle_outline)
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