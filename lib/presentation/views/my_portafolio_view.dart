import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';


// TODO: Hacer un filtro? no se como se llama, pero basicamente para si uno quiere ver el grafico de pie con porcentaje o con el monto de dinero invertido
class MyPortafolioView extends StatelessWidget {
  const MyPortafolioView({super.key});

  //TODO: La logica deberia ser que se escogen los primeros 7 o 6 mas grandes y los otros se ponen en Other, los cuales no mostraran ningun icono, a segundo ver donde podria poner los iconos
  static const Map<String, double> dataMap = {
    'Google': 950,
    'Adobe': 500,
    'NKE': 230,
    'Nvo': 190,
    'Ups': 180,
    'UNH': 150,
    'LULU': 93.50,
    'Other': 590
  };

  static const List<Color> colorList = [
    Color.fromARGB(255, 202, 39, 235),
    Color(0xff3EE094),
    Color(0xff3398F6),
    Color.fromARGB(255, 255, 53, 42),
    Color.fromARGB(255, 12, 16, 248),
    Color.fromARGB(255, 255, 0, 179),
    Color.fromARGB(255, 0, 255, 42),
    Color.fromARGB(255, 255, 146, 52),
  ];

  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    

    return Scaffold(
      appBar: AppBar(title: const Text('Mi portafolio')),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          
          children: [

            SizedBox(height: 20,),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                spacing: 5,
                children: [
                  _FilterButton('Valor inversión'),
                  _FilterButton('Distribución(%)'),
                  _FilterButton('Valor inversión'),
                  _FilterButton('Valor inversión'),
                ],
              ),
            ),

            Spacer(),

            // TODO: hay que crear un widget para esto, para no tener que copiar codigo por cada filtro de el grafico
            PieChart(
              dataMap: dataMap,
              colorList: colorList,
              chartRadius: size.width / 2,
              //centerText: 'Mi Portafolio', // texto que va al centro
              //centerTextStyle: ,
              //centerWidget: Icon(Icons.monetization_on_rounded, size: MediaQuery.of(context).size.width / 3, color: Colors.white,  ),
          
              animationDuration: const Duration(seconds: 2),
              
              
              chartValuesOptions: ChartValuesOptions(
                //showChartValues: false //!Para que los valores no aparezcan
                decimalPlaces: 2,
                //showChartValueBackground: false, // para no mostrar el background de los valores
                //showChartValuesInPercentage: true, // para que aparezcan como porcentajes los values
                showChartValuesOutside: true, // para que los valores aparezcan afuera
                chartValueBackgroundColor: colors.primary,
                chartValueStyle: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500) // el text style del valor
              ),
          
              //legendOptions: LegendOptions(
              //  //showLegends: false, // Esto es para no mostrar el contexto de que es cada cosa y su respectivo color
              //),
              //baseChartColor: Colors.red,
              
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón de añadir acción
                SizedBox(
                  width: size.width*0.45,
                  height: 40,
                  child: FilledButton.icon(
                    onPressed: (){}, 
                    label: Text('Añadir Acción'),
                    icon: Icon(Icons.add, size: 22),
                  ),
                ),

                Spacer(),

                // Botón de editar portafolio
                SizedBox(
                  width: size.width*0.45,
                  height: 40,
                  child: FilledButton.icon(
                    onPressed: (){}, 
                    label: Text('Editar portafolio'),
                    icon: Icon(Icons.edit, size: 22),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,)
          ],
        ),
      )
    );
  }
}

class _FilterButton extends StatelessWidget {

  final String filter;
  
  const _FilterButton(this.filter);

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed:(){} ,
    
      style: ButtonStyle(
        visualDensity: VisualDensity.compact
      ),
    
      child: Text(filter),
    
    );
  }
}
