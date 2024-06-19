import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:arosaje_flutter/services/location_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var locationData = await _locationService.getLocation();
    if (locationData != null) {
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _mapController.move(_currentLocation!, 15.0);
      });
    }
  }

  void _fetchLocation() async {
    await _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentLocation == null
                ? Center(child: CircularProgressIndicator())
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: _currentLocation,
                      zoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: _currentLocation!,
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _fetchLocation,
              child: Text('Obtenir la position'),
            ),
          ),
        ],
      ),
    );
  }
}
