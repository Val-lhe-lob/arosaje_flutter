import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:arosaje_flutter/services/plante_service.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/pages/plante_detail_page.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();

  // Liste dynamique des emplacements des plantes
  List<Plante> _plantes = [];
  List<LatLng> _plantesLocations = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadPlantesLocations(); // Charger les emplacements des plantes
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check if service is enabled
    _serviceEnabled = await location.serviceEnabled();
    print('_serviceEnabled: $_serviceEnabled');
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      print('Requested service, _serviceEnabled: $_serviceEnabled');
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    print('_permissionGranted: $_permissionGranted');
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      print('Requested permission, _permissionGranted: $_permissionGranted');
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print('_locationData: $_locationData');

    setState(() {
      if (_locationData.latitude != null && _locationData.longitude != null) {
        _currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
        print('_currentLocation: $_currentLocation');
        _mapController.move(_currentLocation!, 15.0);
      } else {
        print('Location data is null');
      }
    });
  }

  Future<void> _loadPlantesLocations() async {
    try {
      List<Plante> plantes = await PlantesService.getPlantes();
      setState(() {
        _plantes = plantes;
        _plantesLocations = plantes.map((plante) => LatLng(double.parse(plante.lat), double.parse(plante.lon))).toList();
      });
    } catch (e) {
      print('Error loading plantes locations: $e');
    }
  }

  void _fetchLocation() async {
    await _getCurrentLocation();
  }

  void _onPlanteTap(Plante plante) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanteDetailPage(plante: plante),
      ),
    );
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
                center: _currentLocation ?? LatLng(45.764043, 4.835659), // Centre par défaut (Lyon)
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
                    for (var i = 0; i < _plantes.length; i++)
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _plantesLocations[i],
                        builder: (ctx) => GestureDetector(
                          onTap: () => _onPlanteTap(_plantes[i]),
                          child: Container(
                            child: Icon(
                              Icons.local_florist,
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
