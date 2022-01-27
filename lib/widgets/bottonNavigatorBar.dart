import 'package:flutter/material.dart';


class BottonNavigator extends StatefulWidget {
  BottonNavigator({Key? key}) : super(key: key);

  @override
  State<BottonNavigator> createState() => _BottonNavigatorState();
}

class _BottonNavigatorState extends State<BottonNavigator> {
   int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //final screens = Provider.of<ScreenCurrent>(context);
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (value) {
        _currentIndex = value;
        //screens.screen = value;
        setState(() {});
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined), label: 'Map'),
        BottomNavigationBarItem(
            icon: Icon(Icons.near_me), label: 'Address')
      ],
    );
  }
}