import 'package:flutter/material.dart';

//TODO: hacer este widget y el stockitembysearch uno, para no romper el principio de DRY

/*

Esqueleto de el listado de busquedas,
para cuando esten cargando las acciones

*/
class LoadingStockBySearch extends StatelessWidget {
  const LoadingStockBySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(    
        //dense: true,
        //TODO: Cambiar tamaño para que se vea igual al LisTile de stocks
        minTileHeight: 56,
        visualDensity: VisualDensity.compact,
        tileColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10)
        ),
      
        /*

        Aqui va la imagen
        
        */
        leading:  ClipOval(
          child: Container(
            height: 36.6,
            width: 36.6,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 5
                )
              ]
            ),
          )
        ),
        title: Container(
          height: 14,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  blurRadius: 5
                )
            ]
          ),
        ),
        subtitle: Container(
          height: 8,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  blurRadius: 5
                )
            ]
          ),
        ),
        //trailing: //Boton de agregar un stock capaz no lo pongo en el esqueleto
      ),
    );
  }
}