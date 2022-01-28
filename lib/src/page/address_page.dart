import 'package:app_develop/Database/db.dart';
import 'package:app_develop/model/data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String _url = '';
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
              _url = snapshop.data![index].value;
              return ListTile(
                title: Text(snapshop.data![index].value),
                subtitle: Text(snapshop.data![index].type),
                onTap: () {
                  if (snapshop.data![index].type == "http") {
                    launcherUrl(_url);
                  }else{
                    print(snapshop.data![index].type);
                  }
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://previews.123rf.com/images/cowpland/cowpland1412/cowpland141200270/34978675-contactos-icono-dise%C3%B1o-plano-.jpg'),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        } else if (snapshop.hasError) {
          return Center(
            child: Text("Error:\ ${snapshop.error}"),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  void launcherUrl(url) async {
    var concatUrl = "http://$url";
    print(concatUrl);
    if (!await launch(concatUrl)) throw 'Could not launch $_url';
  }
}
