import 'package:ecomplaintbharat/screens/complaint.dart';
import 'package:ecomplaintbharat/screens/complaintcategory.dart';
import 'package:ecomplaintbharat/screens/settings.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    FeedsScreen(),
    Complaint(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            _selectedIndex == 0 ? 'Welcome There!' : '',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feeds'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Complaints'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Image.asset(
                    'assets/logo.png',
                    height: 170,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pot Holes Not Repaired',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatusScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 13.0),
                      backgroundColor: Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.black.withOpacity(0.2),
                      elevation: 4,
                    ),
                    child: Text('VIEW STATUS'),
                  ),
                  SizedBox(height: 5),
                  Text('Id: 074518', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.black),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Law Gate, Maheru, Phagwara, India.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 400,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildMenuItem(Icons.edit, 'File A Complaint', context, CategorySelectionScreen()),
                  buildMenuItem(Icons.track_changes, 'Track Status', context, TrackStatusScreen()),
                  buildMenuItem(Icons.thumb_up, 'Feedback & Rating', context, FeedbackScreen()),
                  buildMenuItem(Icons.person_search, 'Ask a Query', context, AskQueryScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String label, BuildContext context, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class FeedsScreen extends StatefulWidget {
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final List<Map<String, String>> complaints = [
    {
      "title": "Street Lights Not Working",
      "description": "The street lights in our area have not been working for the past week.",
      "location": "Sector 21, Chandigarh, India",
      "date": "2024-11-05",
      "id": "001"
    },
    {
      "title": "Potholes on Road",
      "description": "Multiple potholes on the main road causing accidents.",
      "location": "Law Gate, Phagwara, India",
      "date": "2024-11-03",
      "id": "002"
    },
    {
      "title": "Garbage Not Collected",
      "description": "Garbage has not been collected for over two weeks.",
      "location": "Sector 34, New Delhi, India",
      "date": "2024-10-31",
      "id": "003"
    },
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                query = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search Complaints...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              if (complaints[index]["title"]!.toLowerCase().contains(query) ||
                  complaints[index]["description"]!.toLowerCase().contains(query)) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaints[index]["title"]!,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          complaints[index]["description"]!,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              complaints[index]["location"]!,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                            Text(
                              complaints[index]["date"]!,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink(); // Return an empty widget if it doesn't match
              }
            },
          ),
        ),
      ],
    );
  }
}

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complaint Status")),
      body: Center(child: Text("Status of the complaint.")),
    );
  }
}

class TrackStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Track Your Complaint Status")),
      body: Center(child: Text("Track the status of your complaint.")),
    );
  }
}

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback & Rating")),
      body: Center(child: Text("Provide feedback and rating.")),
    );
  }
}

class AskQueryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ask a Query")),
      body: Center(child: Text("Ask a Query")),
    );
  }
}
