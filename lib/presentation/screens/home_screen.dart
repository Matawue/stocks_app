import 'package:flutter/material.dart';
import 'package:stocks_app/presentation/widgets/shared/custom_bottom_navigation.dart';

typedef GoBranchCallBack = void Function(int index);

class HomeScreen extends StatelessWidget {
  final Widget childView;
  final GoBranchCallBack goBranch;
  final int getCurrentIndex;


  const HomeScreen({
    super.key, 
    required this.childView, 
    required this.goBranch, 
    required this.getCurrentIndex
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: CustomBottomNavigation(goBranch: goBranch, currentIndex: getCurrentIndex,),
    );
  }
}