import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/user_mdel.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(user.latitude, user.longitude),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(user.id.toString()),
                  position: LatLng(user.latitude, user.longitude),
                  infoWindow: InfoWindow(
                    title: user.name,
                    snippet:
                        user.email, // Display email in the marker's snippet
                  ),
                ),
              },
            ),
          ),
          ListTile(
            title: Text('Name: ${user.name}'),
            subtitle: Text('User ID: ${user.id}'),
          ),
          ListTile(
            title: Text('Email: ${user.email}'),
            subtitle: Text('Phone: ${user.phone}'),
          ),
          Image.network(user.image),
        ],
      ),
    );
  }
}
