import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/services/inscription_plante_service.dart';
import 'package:arosaje_flutter/services/location_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class InscriptionPlantePage extends StatefulWidget {
  @override
  _InscriptionPlanteFormState createState() => _InscriptionPlanteFormState();
  final TokenStorage _tokenStorage = TokenStorage();
}

class _InscriptionPlanteFormState extends State<InscriptionPlantePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _base64Image;
  String? _imageExtension;
  List<Ville> _villes = [];
  int? _selectedCityId;
  String? _selectedCategory;
  List<String> _categories = ['Intérieur', 'Extérieur', 'Fleur'];
  LatLng? _currentLocation;
  final LocationService _locationService = LocationService();
  bool _locationSaved = false;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    try {
      List<Ville> cities = await InscriptionPlanteService.fetchCities();
      setState(() {
        _villes = cities;
        print("Cities loaded: ${_villes.map((city) => city.nom).toList()}");
      });
    } catch (e) {
      print("Error loading cities: $e");
    }
  }

  Future<void> _getImage() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.bytes != null) {
      // Compress the image
      var compressedImage = await FlutterImageCompress.compressWithList(
        result.files.single.bytes!,
        minWidth: 800,
        minHeight: 600,
        quality: 80,
      );

      setState(() {
        _base64Image = base64Encode(compressedImage);
        _imageExtension = result.files.single.extension;
      });
    }
  } catch (e) {
    print('Error picking image: $e');
  }
}

  Future<void> _getCurrentLocation() async {
    var locationData = await _locationService.getLocation();
    if (locationData != null) {
      setState(() {
        _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _locationSaved = true;
      });
    }
  }

  Future<bool> _isUserLoggedIn() async {
    List? token = await widget._tokenStorage.getToken();
    return token != null && token[0] != null;
  }

  Future<void> _registerPlant() async {
    bool isLoggedIn = await _isUserLoggedIn();
    if (!isLoggedIn) {
      _showLoginAlertDialog();
      return;
    }

    print('Nom: ${_nameController.text}');
    print('Espèce: ${_speciesController.text}');
    print('Description: ${_descriptionController.text}');
    print('idVille: $_selectedCityId');
    print('Catégorie: $_selectedCategory');
    print('idPhoto: $_base64Image');
    print('Image Extension: $_imageExtension');

      // Ajoutez des impressions pour déboguer les valeurs
      print('nom: ${_nameController.text}');
      print('espece: ${_speciesController.text}');
      print('Description: ${_descriptionController.text}');
      print('idVille: $_selectedCityId');
      print('idPhoto: $_base64Image');
      print('Image Extension: $_imageExtension');

    await InscriptionPlanteService.registerPlant(
      _nameController.text,
      _speciesController.text,
      _descriptionController.text,
      _base64Image,
      _imageExtension,
      _selectedCityId!,
      _selectedCategory!,
      _currentLocation?.latitude.toString() ?? '',
      _currentLocation?.longitude.toString() ?? '',
    );

    print('Plant registered successfully');
    _resetForm();
  }

  void _showLoginAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Non connecté"),
          content: Text("Vous devez être connecté pour enregistrer une plante."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
          ],
        );
      },
    );
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _speciesController.clear();
      _descriptionController.clear();
      _base64Image = null;
      _imageExtension = null;
      _selectedCityId = null;
      _selectedCategory = null;
      _currentLocation = null;
      _locationSaved = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _getImage,
            child: _base64Image == null
                ? Container(
                    color: Colors.grey,
                    height: 150,
                    child: Icon(Icons.add_a_photo, size: 50, color: Colors.white),
                  )
                : Image.memory(base64Decode(_base64Image!), height: 150, fit: BoxFit.cover),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nom de la plante'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _speciesController,
            decoration: InputDecoration(labelText: 'Espèce de la plante'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description de la plante'),
            maxLines: null,
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<int>(
            decoration: InputDecoration(labelText: 'Ville'),
            items: _villes.map((ville) {
              return DropdownMenuItem<int>(
                value: ville.idVille,
                child: Text(ville.nom),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCityId = value;
              });
            },
            value: _selectedCityId,
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Catégorie'),
            items: _categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            value: _selectedCategory,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _getCurrentLocation,
            style: ElevatedButton.styleFrom(
              backgroundColor: _locationSaved ? Colors.green : Colors.red,
            ),
            child: Text('Enregistrer la position'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _registerPlant,
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}
