import 'dart:io';
import 'package:ecomplaintbharat/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Dustbins not Cleaned', 'icon': 'assets/dustbinicon.png'},
    {'name': 'Request for Garbage Truck', 'icon': 'assets/truckicon.png'},
    {'name': 'Garbage dump', 'icon': 'assets/garbagedump.png'},
    {'name': 'Roads not cleaned', 'icon': 'assets/roadscleanicon.png'},
    {'name': 'Public toilets not Cleaned', 'icon': 'assets/toiletnoicon.png'},
    {'name': 'Request for Street lights', 'icon': 'assets/streetlighticon.png'},
    {'name': 'Request to remove Dead animals', 'icon': 'assets/dustbinicon.png'},
    {'name': 'Fix Potholes quickly and efficiently', 'icon': 'assets/potholesiconcar.png'},
    {'name': 'Fix and cover all the Manholes', 'icon': 'assets/manholesicon.png'},
    {'name': 'Request to fix traffic signals', 'icon': 'assets/trafficicon.png'},
    {'name': 'Request to Plant Trees in city', 'icon': 'assets/planttreesicon.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select the category')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Image.asset(
              category['icon']!,
              width: 40,
              height: 40,
            ),
            title: Text(category['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailEntryScreen(categoryName: category['name']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailEntryScreen extends StatefulWidget {
  final String categoryName;

  DetailEntryScreen({required this.categoryName});

  @override
  _DetailEntryScreenState createState() => _DetailEntryScreenState();
}

class _DetailEntryScreenState extends State<DetailEntryScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  GoogleMapController? _mapController;
  Location _location = Location();
  LatLng? _userLocation;

  // Initialize location and get user's current location
  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location service is enabled
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }

    // Check for location permissions
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    // Get the user's current location and update the map
    var currentLocation = await _location.getLocation();
    setState(() {
      _userLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = selectedImage;
    });
  }

  void _showPickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Take a photo"),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Choose from gallery"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_userLocation != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_userLocation!, 15),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: _imageFile != null
                    ? Image.file(File(_imageFile!.path))
                    : Image.asset(
                  'assets/googlemapsicon.png',
                  height: 50,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Select area',
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 300,
              width: double.infinity,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _userLocation ?? LatLng(28.7041, 77.1025), // Default to Delhi if no location
                  zoom: 14,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Add Description about your problem',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            OutlinedButton.icon(
              onPressed: _showPickerDialog,
              icon: Icon(Icons.camera_alt),
              label: Text("Add a photo"),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
