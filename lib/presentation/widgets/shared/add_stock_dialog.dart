import 'package:flutter/material.dart';
import 'package:stocks_app/domain/entities/entities.dart';

class AddStockDialog extends StatefulWidget {
  final Stock stock;
  const AddStockDialog({super.key, required this.stock});

  @override
  State<AddStockDialog> createState() => _AddStockDialogState();
}

class _AddStockDialogState extends State<AddStockDialog> {
  final TextEditingController _numberOfStockController = TextEditingController();
  final TextEditingController _priceOfStockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return AlertDialog(
      title: const Text('Agregar Acción Al Portafolio'),
      //TODO: aqui va el input de texto para poner cuantas
      content: SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
        
            SizedBox(height: 10,),
        
            Text(widget.stock.symbol, style: textStyle.titleSmall,),

            SizedBox(height: 10,),
        
           

            _TextFieldStock(textEditingController: _numberOfStockController, labelText: 'Numero de acciones',),


            SizedBox(height: 10,),
            
            _TextFieldStock(textEditingController: _priceOfStockController, labelText: 'Precio compra',),

            
          ]
        ),
      ),

      actions: <Widget>[
        //TODO: Hacer que la accion se agregue
        // AQUI AGREGO LA ACCIÓN
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Aceptar'),
        ),

        // SALE DEL ALERTDIALOG
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
      ],
    );
  }
}

class _TextFieldStock extends StatelessWidget {
  
  
  final TextEditingController textEditingController;
  final String labelText;
  
  const _TextFieldStock({
    required this.textEditingController, required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
    
      decoration: InputDecoration(
        labelText: 'Precio compra', 
        border: OutlineInputBorder(),
        prefix: Text('\$'),
        visualDensity: VisualDensity.compact
      ),
    
      keyboardType: TextInputType.numberWithOptions(),
    );
  }
}
