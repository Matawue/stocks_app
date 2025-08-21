import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class CustomBottomNavigation extends StatelessWidget {
  selectedIndex = 0;
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    // TODO: hacer widget personalizado sin splash

    return BottomNavigationBar(

      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,

      onTap: (value) {
        selectedIndex = value;
        context.go('/$value');
      },

      selectedItemColor: colors.primary,
      unselectedItemColor: Colors.grey,
      

      
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.motorcycle_outlined),
          activeIcon: Icon(Icons.motorcycle),
          label: 'Moto',
          backgroundColor: colors.primary
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          activeIcon: Icon(Icons.person_2),
          label: 'Persona',
          backgroundColor: colors.tertiary
        ),
      ],
    );
  }
}