import 'package:app_develop/Database/db.dart';
import 'package:app_develop/model/data.dart';
import 'package:app_develop/src/page/data_geo.dart';
import 'package:app_develop/src/page/geo_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String _url = '';
  dataGeo datageo = new dataGeo();
  double altitude = 0.0;
  double longitude = 0.0;

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
              if (snapshop.data![index].type == "http") {
                _url = snapshop.data![index].value;
                return ListTile(
                  title: Text(snapshop.data![index].value),
                  subtitle: Text(snapshop.data![index].type),
                  onTap: () {
                    if (snapshop.data![index].type == "http") {
                      launcherUrl(_url);
                    } else {
                      var position = (snapshop.data![index].value).split(",");
                      altitude = double.parse(position[0]);
                      longitude = double.parse(position[1]);
                      dataGeo().etAltitud = altitude;
                      dataGeo().etLongitud = longitude;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MapaPage()));
                    }
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/1591060/pexels-photo-1591060.jpeg'),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              }else{
                return Center(child: Text(""));
              }
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
