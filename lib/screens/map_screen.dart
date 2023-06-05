import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_icon/marker_icon.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map_screen';
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;
  LatLng initialLocation = const LatLng(37.422131, -122.084801);
  TextEditingController controller = TextEditingController();
  Future<Set<Marker>>? markers;

  Future<Set<Marker>>fetchData() async {
    Set<Marker> temp = <Marker>{};
    var doc = await FirebaseFirestore.instance.collection("users").doc("MJa9qeJWiRdVovP00W9L3dc6lHR2").collection("markers").get();
    for(var item in doc.docs){
      Marker marker = Marker(
        position:LatLng(item.data()["latlng"].latitude,item.data()["latlng"].longitude) ,
          markerId:  MarkerId(item.data()["markerId"]),
          icon: await MarkerIcon.downloadResizePictureCircle(
              item.data()["image"],
              size: 150,
              addBorder: false,
              borderColor: Colors.white,
              borderSize: 15),
          infoWindow: InfoWindow(title: item.data()["title"])
      );
      temp.add(marker);
    }
    return temp;
  }

  @override
  void initState() {
    markers = fetchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MJa9qeJWiRdVovP00W9L3dc6lHR2"),
      ),
      body:  FutureBuilder(
        future: markers,
        builder: (context, snapshot) {
          if(!snapshot.hasData)return Center(child: CircularProgressIndicator());
          print(snapshot.data!);
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 1,
            ),
            markers:snapshot.data!,
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
                        TextButton(onPressed: () async {
                          await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).collection("markers").add({
                            "image": 'https://firebasestorage.googleapis.com/v0/b/travelapp-440a0.appspot.com/o/2223593_s.png?alt=media&token=c6d8f6c2-892d-4af4-a61d-941ef0f9a96a&_gl=1*p8pvpp*_ga*ODU5MzMzMTk4LjE2ODA0OTUwMTc.*_ga_CW55HF8NVT*MTY4NTc4MjI1NC42NS4xLjE2ODU3ODM2MTEuMC4wLjA.',
                            "uid":currentUser!.uid,
                            "title":controller.text,
                            "latlng":GeoPoint(latLang.latitude,latLang.longitude),
                            "markerId":latLang.toString()
                          });
                          Navigator.pop(context);
                          markers = fetchData();
                          setState(() {});
                        }, child: Text("保存"))
                      ],
                    );
                  });
            },
          );
        }),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: FittedBox(child: Text('Add Markers')),
      //   onPressed: () {
      //     markers = fetchData();
      //     setState(() {});
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
