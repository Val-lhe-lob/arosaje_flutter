import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InscriptionPlantePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription de plante'),
      ),
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

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
            onPressed: () {
              // À implémenter : logique d'enregistrement de la plante
              // Vous pouvez accéder aux valeurs des champs avec _nameController.text, _speciesController.text, _descriptionController.text
              // Et l'image avec _image
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}
