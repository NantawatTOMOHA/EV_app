import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:my_flutter/screen/maphome.dart';
import 'package:my_flutter/screen/booking.dart';

List stations = [
  {'id': 0, 'name': '', 'distance': 0.0},
  {
    'id': 1,
    'name': 'สถานีชาร์จรถยนต์ไฟฟ้า บริษัท 909 มหาคุณ จำกัด',
    'distance': 0.3131,
    'Latitude': 13.72206606,
    'Longitude': 100.7614321
  },
  {
    'id': 2,
    'name': 'สถานีชาร์จรถยนต์ไฟฟ้า สถานีทดสอบ KMITL',
    'distance': 1.0192,
    'Latitude': 13.72739,
    'Longitude': 100.772332
  },
  {
    'id': 3,
    'name':
        'สถานีชาร์จรถยนต์ไฟฟ้า บริษัท เบสท์เอ็นเนอร์ยี่พลัส จำกัด สาขา 20 (ลาดกระบัง)',
    'distance': 3.0713,
    'Latitude': 13.722112,
    'Longitude': 100.735832
  },
  {
    'id': 4,
    'name': 'สถานีชาร์จรถยนต์ไฟฟ้า เซเว่นอีเลฟเว่น ร่มเกล้า 23 (5496)',
    'distance': 3.1357,
    'Latitude': 13.745192,
    'Longitude': 100.746872
  },
];

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

double polylinela = 13.72206606;
double polylinelon = 100.7614321;
double markerla = 13.72206606;
double markerlon = 100.7614321;

class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  String testText = "";
  final val = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
          markerId: MarkerId('Target'), position: LatLng(markerla, markerlon))
    };
    _addPolyLine() {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id, color: Colors.blue, points: polylineCoordinates);
      polylines[id] = polyline;
      setState(() {});
    }

    _getPolyline() async {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyB8Ua5i3pBy_h_NYQI1AOvCy-yyDYBydHE',
          PointLatLng(userLocation.latitude, userLocation.longitude),
          PointLatLng(polylinela, polylinelon),
          travelMode: TravelMode.driving);
      polylineCoordinates.clear();
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
    }

    String firstFewWords(String bigSentence) {
      int startIndex = 0;
      late int indexOfSpace;

      for (int i = 0; i < 4; i++) {
        indexOfSpace = bigSentence.indexOf(' ', startIndex);
        if (indexOfSpace == -1) {
          //-1 is when character is not found
          return bigSentence;
        }
        startIndex = indexOfSpace + 1;
      }
      return bigSentence.substring(0, indexOfSpace) + '...';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MapHomeScreen();
            }));
          },
          icon: Icon(Icons.home, color: Colors.white),
        ),
        title: (Container(
          width: 3000,
          decoration: BoxDecoration(
            color: Color.fromRGBO(50, 55, 65, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 39,
          child: FormHelper.inputFieldWidget(
            context,
            "batterylevel",
            "Search Location",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Host URL can\'t be empty.';
              }

              return null;
            },
            (onSavedVal) => {
              this.testText = onSavedVal,
            },
            initialValue: this.testText,
            obscureText: false,
            borderFocusColor: Colors.black.withOpacity(0),
            prefixIconColor: Theme.of(context).primaryColor,
            borderColor: Colors.black.withOpacity(0),
            borderRadius: 8,
            borderWidth: 1,
            focusedBorderWidth: 1,
            hintColor: Color.fromRGBO(81, 82, 90, 1),
            fontSize: 14,
            hintFontSize: 14,
            paddingLeft: 10,
          ),
        )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.phone, color: Colors.white),
          ),
        ],
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        elevation: 1,
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return ValueListenableBuilder(
                      valueListenable: val,
                      builder: (context, value, widget) {
                        return SizedBox(
                          height: constraints.maxHeight / 4 * 3,
                          child: GoogleMap(
                            polylines: Set<Polyline>.of(polylines.values),
                            mapType: MapType.normal,
                            onMapCreated: (GoogleMapController controller) {
                              _getPolyline();
                            },
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(userLocation.latitude,
                                    userLocation.longitude),
                                zoom: 15),
                            markers: Set.from(_markers),
                          ),
                        );
                      });
                }),
                DraggableScrollableSheet(
                    initialChildSize: 0.25,
                    minChildSize: 0.25,
                    maxChildSize: 1,
                    snapSizes: [1],
                    snap: true,
                    builder: (BuildContext context, scrollSheetController) {
                      return Container(
                          color: Color.fromRGBO(20, 20, 20, 1),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: ClampingScrollPhysics(),
                            controller: scrollSheetController,
                            itemCount: stations.length,
                            itemBuilder: (BuildContext context, int index) {
                              final station = stations[index];
                              if (index == 0) {
                                return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: Divider(
                                            thickness: 5,
                                            color:
                                                Color.fromRGBO(50, 55, 65, 1),
                                          ),
                                        ),
                                      ],
                                    ));
                              }
                              return Container(
                                height: 130, //
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 10,
                                      bottom: 10),
                                  elevation: 0,
                                  color: Color.fromARGB(255, 43, 44, 46),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(10),
                                    onTap: () {
                                      setState(() {
                                        //selectedCarId = car['id'];
                                      });
                                    },

                                    title: Text(
                                      firstFewWords(station['name'].toString()),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    trailing: Text(
                                      '(' +
                                          (station['distance'] * 1000)
                                              .toStringAsFixed(1) +
                                          ' M)',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(212, 17, 17, 1)),
                                    ),
                                    //selected: selectedCarId == car['id'],
                                    selectedTileColor: Colors.grey[200],
                                    subtitle: Row(children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          fixedSize: const Size(90, 15),
                                          primary: const Color.fromRGBO(
                                              76, 77, 79, 1), // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () {
                                          _markers
                                              .remove(_markers.elementAt(0));
                                          _markers.add(Marker(
                                              markerId: MarkerId('Target'),
                                              position: LatLng(
                                                  station['Latitude'],
                                                  station['Longitude'])));
                                          markerla = (LatLng(
                                                  station['Latitude'],
                                                  station['Longitude'])
                                              .latitude);
                                          markerlon = (LatLng(
                                                  station['Latitude'],
                                                  station['Longitude'])
                                              .longitude);
                                          polylinela = (LatLng(
                                                  station['Latitude'],
                                                  station['Longitude'])
                                              .latitude);
                                          polylinelon = (LatLng(
                                                  station['Latitude'],
                                                  station['Longitude'])
                                              .longitude);
                                          _getPolyline();
                                          val.value++;
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                                Icons
                                                    .arrow_circle_right_outlined,
                                                color: Color.fromRGBO(
                                                    212, 17, 17, 1)),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              'Route',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          fixedSize: const Size(97, 15),
                                          primary: const Color.fromRGBO(
                                              76, 77, 79, 1), // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return BookingScreen();
                                          }));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.approval_rounded,
                                                color: Color.fromRGBO(
                                                    212, 17, 17, 1)),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            const Text(
                                              'Booking',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            },
                          ));
                    }),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
