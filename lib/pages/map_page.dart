import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget{
  @override
  _MyMapPage createState()=> _MyMapPage();
}

class _MyMapPage extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
      body:Center(
        child:Container(
          child:Column(children:[
            Flexible(child : 
            FlutterMap(
              options:MapOptions(
                center:LatLng(45.780421, 4.823683),
                zoom:8
              ),
              layers:[
                TileLayerOptions()
              ]
              )
              )
              ]
              )
              )
              ));}}
       