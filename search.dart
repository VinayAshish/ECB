import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<String> complaints = ['Complaint 1', 'Complaint 2']; // Replace with actual complaints

  List<String> searchResults = [];

  void searchComplaints(String query) {
    setState(() {
      searchResults = complaints.where((complaint) => complaint.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Complaints')),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: searchComplaints,
            decoration: InputDecoration(labelText: 'Search complaints'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
