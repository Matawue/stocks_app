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
      

      
      items: const[
        BottomNavigationBarItem(
          icon: Icon(Icons.motorcycle_outlined),
          activeIcon: Icon(Icons.motorcycle),
          label: 'Moto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          activeIcon: Icon(Icons.person_2),
          label: 'Persona',
        ),
      ],
    );
  }
}