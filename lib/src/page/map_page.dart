import 'package:app_develop/Database/db.dart';
import 'package:app_develop/model/data.dart';
import 'package:app_develop/src/page/data_geo.dart';
import 'package:app_develop/src/page/geo_page.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
              if (snapshop.data![index].type == "geo") {
                return ListTile(
                  title: Text(snapshop.data![index].value),
                  subtitle: Text(snapshop.data![index].type),
                  onTap: () {
                    var position = (snapshop.data![index].value).split(",");
                    altitude = double.parse(position[0]);
                    longitude = double.parse(position[1]);
                    Navigator.pushNamed(context,"map",arguments:{
                      "lat" : double.parse(position[0]),
                      "long" : double.parse(position[1])
                    });
                    MapaPage();
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/87651/earth-blue-planet-globe-planet-87651.jpeg'),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              } else {
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
}
