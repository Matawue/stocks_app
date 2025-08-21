import 'package:flutter/material.dart';
import 'package:stocks_app/presentation/widgets/shared/custom_bottom_navigation.dart';



class MyPortafolioView extends StatelessWidget {
  const MyPortafolioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portafolio'),
      ),

      body: const Center(child: Text(':)'),),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}