import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:arosaje_flutter/services/location_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _defaultLocation = LatLng(45.764043, 4.835659); // Centre par défaut (Lyon)
  LatLng? _currentLocation;
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();

  final List<LatLng> _plantesLocations = [
    LatLng(45.739197, 4.878883), // Chez Nathan
    LatLng(45.773518, 4.799943), // Chez Etienne
    LatLng(45.771899, 4.853012), // Chez Kilian
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
    });
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
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _currentLocation ?? _defaultLocation,
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    if (_currentLocation != null)
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _currentLocation!,
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.location_on,
                            color: const Color.fromARGB(255, 221, 20, 5),
                            size: 40,
                          ),
                        ),
                      ),
                    ..._plantesLocations.map(
                      (location) => Marker(
                        width: 80.0,
                        height: 80.0,
                        point: location,
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 5, 155, 37),
                            size: 40,
                          ),
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
