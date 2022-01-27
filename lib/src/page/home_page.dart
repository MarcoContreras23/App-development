import 'package:app_develop/widgets/bottonNavigatorBar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
           IconButton(
               onPressed: () async {
                 await Navigator.pushNamed(context, 'lista-favoritos');
                 setState(() {});
               },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
      bottomNavigationBar: BottonNavigator(),
    );
  }
}