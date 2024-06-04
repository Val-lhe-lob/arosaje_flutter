import 'dart:convert';
import 'dart:io';
import 'package:arosaje_flutter/services/inscription_plante_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class InscriptionPlantePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InscriptionPlanteForm(),
    );
  }
}

class InscriptionPlanteForm extends StatefulWidget {
  @override
  _InscriptionPlanteFormState createState() => _InscriptionPlanteFormState();
}

class _InscriptionPlanteFormState extends State<InscriptionPlanteForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  String? _base64Image;
  String? _imageExtension;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);

        // Get the file extension
        _imageExtension = path.extension(pickedFile.path);

        // Read the file and encode it in base64
        _image!.readAsBytes().then((imageBytes) {
          setState(() {
            _base64Image = base64Encode(imageBytes);
          });
        }).catchError((error) {
          // Handle error in reading file
          print('Error reading image file: $error');
        });
      });
    }
  }

  Future<void> _registerPlant() async {
    if (_base64Image == null || _imageExtension == null) {
      throw Exception('Image is required');
    }

    await InscriptionPlanteService.registerPlant(
      _nameController.text,
      _speciesController.text,
      _descriptionController.text,
      _base64Image,
      _imageExtension,
    );
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
            child: _image == null
                ? Container(
                    color: Colors.grey,
                    height: 150,
                    child: Icon(Icons.add_a_photo, size: 50, color: Colors.white),
                  )
                : Image.file(_image!, height: 150, fit: BoxFit.cover),
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
          ElevatedButton(
            onPressed: _registerPlant,
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}
