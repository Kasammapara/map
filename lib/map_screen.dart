
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  LatLng currloc;

  MapScreen(
  {
    super.key,
    required this.currloc
}
      );
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentloc;
  MapController _mapController = MapController();
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    if (widget.currloc != null) {
      _markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: widget.currloc,
          child:Icon(Icons.location_on, color: Colors.red, size: 50),
        ),
      );
      setState(() {}); // Update the state after adding the marker
    }
  }



  void _searchLocation(String query) async {
    final url = 'https://nominatim.openstreetmap.org/search?q=$query&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data != null && data.isNotEmpty) {
        final location = data[0];
        final latitude = double.parse(location['lat']);
        final longitude = double.parse(location['lon']);

        _markers.clear();


        _markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(latitude, longitude),
            child: Icon(Icons.location_on, color: Colors.green, size: 50),

          ),
        );


        _mapController.move(LatLng(latitude, longitude), 10.0);
      } else {
        // Handle no results found
      }
    } else {
      // Handle API call failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a location',
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: _searchLocation,
            ),
          ),
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: widget.currloc!,
                  zoom: 10.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: _markers),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}