import 'package:flutter/material.dart';

class Complaint extends StatefulWidget {
  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        backgroundColor: Colors.grey[100],
        elevation: 0,
        title: Text(
          'Complaints',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.0,
                  mainAxisSpacing: 18.0,
                  childAspectRatio: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ComplaintButton(
                      icon: Icons.upload,
                      label: 'Uploaded',
                      screen: UploadedScreen(),
                    ),
                    ComplaintButton(
                      icon: Icons.thumb_up,
                      label: 'Voted',
                      screen: VotedScreen(),
                    ),
                    ComplaintButton(
                      icon: Icons.near_me,
                      label: 'Nearby',
                      screen: NearbyScreen(),
                    ),
                    ComplaintButton(
                      icon: Icons.location_city,
                      label: 'City',
                      screen: CityScreen(),
                    ),
                    ComplaintButton(
                      icon: Icons.person,
                      label: 'Your Activity',
                      screen: ActivityScreen(),
                    ),
                    ComplaintButton(
                      icon: Icons.search,
                      label: 'Search',
                      screen: SearchScreen(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Latest complaint around you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                color: Colors.grey[300],
                child: Center(
                  child: Text('Latest Complaint Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplaintButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget screen;

  ComplaintButton({required this.icon, required this.label, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// Search Screen added directly in this file
class SearchScreen extends StatelessWidget {
  final List<String> recentSearches = ["Road Issues", "Water Supply", "Electricity", "Healthcare"];
  final List<Map<String, String>> searchResults = [
    {"title": "Water Leakage in Sector 10", "description": "Leakage causing inconvenience to residents"},
    {"title": "Potholes on Main Street", "description": "Large potholes leading to traffic jams"},
    {"title": "Power Outage in Block C", "description": "Frequent outages affecting work and studies"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        title: Text(
          'Search Complaints',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for complaints...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Recent searches section
            Text(
              'Recent Searches',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: recentSearches.map((search) {
                return Chip(
                  label: Text(search),
                  backgroundColor: Colors.grey[300],
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Search results section
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        searchResults[index]["title"] ?? "",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        searchResults[index]["description"] ?? "",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16),
                      onTap: () {
                        // Implement navigation to detailed complaint view here
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample Pages for each Complaint option
class UploadedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Uploaded Complaints')),
      body: Center(child: Text('Uploaded Complaints Page')),
    );
  }
}

class VotedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voted Complaints')),
      body: Center(child: Text('Voted Complaints Page')),
    );
  }
}

class NearbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Complaints')),
      body: Center(child: Text('Nearby Complaints Page')),
    );
  }
}

class CityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('City Complaints')),
      body: Center(child: Text('City Complaints Page')),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Activity')),
      body: Center(child: Text('Your Activity Page')),
    );
  }
}
