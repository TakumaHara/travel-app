import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map_screen';
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    LatLng initialLocation = const LatLng(37.422131, -122.084801);
    Set<Marker> markerList ={};
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14,
        ),
        markers:markerList,
        onTap: (LatLng latLang) {
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("情報入力"),
                  actions: [
                    TextFormField(
                      controller: controller,
                    ),
                    TextButton(onPressed: (){
                      setState(() {
                        Marker marker = Marker(
                            infoWindow: InfoWindow(title: controller.text),
                            position: LatLng(latLang.latitude,latLang.longitude),
                            markerId: MarkerId(latLang.toString()));
                        markerList.add(marker);
                        Navigator.pop(context);
                      });
                    }, child: Text("保存"))
                  ],
                );
              });
        },

      ),
    );
  }
}
