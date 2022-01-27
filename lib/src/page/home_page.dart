import 'package:app_develop/provider/screen_provider.dart';
import 'package:app_develop/src/page/address_page.dart';
import 'package:app_develop/src/page/map_page.dart';
import 'package:app_develop/widgets/bottonNavigatorBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
           IconButton(
               onPressed: () async {
                 await Navigator.pushNamed(context, 'lista-favoritos');
                 setState(() {});
               },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Consumer<ScreenCurrent>(
        builder: (context, current, child) {
          switch (current.current) {
            case 0:
              return MapPage();
            case 1:
              return AddressPage();
            default:
              return MapPage();
          }
        },
      ),
      bottomNavigationBar: BottonNavigator(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.document_scanner_rounded),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#F13333', 'Cancelar', false, ScanMode.QR);

          if (barcodeScanRes != '-1') {
            print(barcodeScanRes);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}