import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/services/plante_service.dart';
import 'package:arosaje_flutter/secure_local_storage_token.dart';

class UserPlantesWidget extends StatefulWidget {
  @override
  _UserPlantesWidgetState createState() => _UserPlantesWidgetState();
}

class _UserPlantesWidgetState extends State<UserPlantesWidget> {
  Future<List<Plante>>? _userPlantesFuture;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  void _loadUserId() async {
    try {
      List? tokenData = await TokenStorage().getToken();
      if (tokenData != null) {
        _userId = int.tryParse(tokenData[2].toString());
        if (_userId != null) {
          print('User ID retrieved from token: $_userId');
          setState(() {
            _userPlantesFuture = PlantesService.getPlantesByUserId(_userId!);
          });
        } else {
          print('User ID is null after conversion.');
        }
      } else {
        print('Failed to retrieve user token data.');
      }
    } catch (error) {
      print('Error retrieving token data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plante>>(
      future: _userPlantesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('UserPlantesWidget: Waiting for data...');
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('UserPlantesWidget: Error occurred: ${snapshot.error}');
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('UserPlantesWidget: No plants found for user with ID $_userId');
          return Center(child: Text('Aucune plante inscrite.'));
        } else {
          final plantes = snapshot.data!;
          print('UserPlantesWidget: Plants found: $plantes');
          return ListView.builder(
            itemCount: plantes.length,
            itemBuilder: (context, index) {
              final plante = plantes[index];
              return Card(
                color: Color(0xFFFF6347), // Rouge coquelicot
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(plante.nom),
                  subtitle: Text(plante.description),
                ),
              );
            },
          );
        }
      },
    );
  }
}
