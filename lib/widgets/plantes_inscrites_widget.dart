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

  @override
  void initState() {
    super.initState();
    _loadUserPlantes();
  }

  void _loadUserPlantes() async {
    List? tokenData = await TokenStorage().getToken();
    if (tokenData != null) {
      int userId = tokenData[0];
      setState(() {
        _userPlantesFuture = PlantesService.getPlantesByUserId(userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Plante>>(
        future: _userPlantesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune plante inscrite.'));
          } else {
            final plantes = snapshot.data!;
            return ListView.builder(
              itemCount: plantes.length,
              itemBuilder: (context, index) {
                final plante = plantes[index];
                return Card(
                  color: Color(0xFFFF6347), // Rouge coquelicot
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(plante.nom),
                    subtitle: Text(plante.description ?? ''),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
