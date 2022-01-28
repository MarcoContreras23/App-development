import 'package:app_develop/Database/db.dart';
import 'package:app_develop/model/data.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Data>>(
      future: DB.instance.readAllData(),
      builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshop) {
        if (snapshop.hasData) {
          return ListView.builder(
            itemCount: snapshop.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshop.data![index].value),
                subtitle: Text(snapshop.data![index].type),
              );
            },
          );
        } else if (snapshop.hasError) {
          return Center(
            child: Text("Error:\ ${snapshop.error}"),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    ));
  }

  Future<void> tuMetodoAsincrono() async {
    DB.instance.readAllData();
  }
}
