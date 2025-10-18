import 'package:flutter/material.dart';
import 'package:stocks_app/domain/entities/entities.dart';

class AddStockDialog extends StatefulWidget {
  final StockLookup stock;
  const AddStockDialog({super.key, required this.stock});

  @override
  State<AddStockDialog> createState() => _AddStockDialogState();
}

class _AddStockDialogState extends State<AddStockDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return AlertDialog(
      title: const Text('Agregar Acción'),
      //TODO: aqui va el input de texto para poner cuantas
      content: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
        
            SizedBox(height: 10,),
        
            Text(widget.stock.symbol, style: textStyle.titleSmall,),

            SizedBox(height: 10,),
        
            TextField(
              controller: _nameController,

              decoration: InputDecoration(
                labelText: 'Numero de acciones', 
                prefix: Text('0'), 
                border: OutlineInputBorder(),
                visualDensity: VisualDensity.compact
              ),

              keyboardType: TextInputType.numberWithOptions(),
            ),
            
          ]
        ),
      ),

      actions: <Widget>[
        
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
