import 'package:flutter/material.dart';

typedef GoBranchCallBack = void Function(int index);

class CustomBottomNavigation extends StatelessWidget {

  final GoBranchCallBack goBranch;
  final int currentIndex;

  const CustomBottomNavigation({
    super.key, 
    required this.goBranch, 
    required this.currentIndex
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    // TODO: hacer widget personalizado sin splash

    return BottomNavigationBar(

      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,

      onTap: (value) {
        goBranch(value);
      },

      selectedItemColor: colors.primary,
      unselectedItemColor: Colors.grey,
      //selectedIconTheme: IconThemeData(size: 26),
      unselectedFontSize: 14.0,

      
      items: const[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_center_outlined),
          label: 'Portafolio',
        ),
      ],
    );
  }
}