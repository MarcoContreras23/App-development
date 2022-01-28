class dataGeo{

  

  double _altitud = 0;
  double _long = 0;

  get altitud {
    return  _altitud;
  }

  get long {
    return  _long;
  }

  set etAltitud(double altitud) {
    _altitud = altitud;

  }
  set etLongitud(double altitud) {
    _altitud = altitud;
  }

  void positionx(x) {
    _altitud =  double.parse(x);
  }
  void getPositiony(y) {
    _long =  double.parse(y);
  }

}

