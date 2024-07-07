import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/services/inscription_plante_service.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

class InscriptionPlantePage extends StatefulWidget {
  @override
  _InscriptionPlanteFormState createState() => _InscriptionPlanteFormState();
}

class _InscriptionPlanteFormState extends State<InscriptionPlantePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _base64Image;
  String? _imageExtension;
  List<Ville> _villes = [];
  int? _selectedCityId;

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
        setState(() {
          _base64Image = base64Encode(result.files.single.bytes!);
          _imageExtension = result.files.single.extension;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _registerPlant() async {

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
      );

      print('Plant registered successfully');
    
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
