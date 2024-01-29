import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/display_location_cards_data.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/favourites_screen.dart';
import 'package:solution_challenge_app/location_grid_item.dart';
import 'package:flutter/material.dart';

class locationGridView extends StatefulWidget {
  locationGridView(this.categoryItems, {super.key});

  List<Category> categoryItems;

  @override
  State<locationGridView> createState() => _locationGridViewState();
}

class _locationGridViewState extends State<locationGridView> {
  // late Category category;
  // @override

  List<Category> _collectedData = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  // List<Category> _colectedData = [];
  void _loadItems() {
    setState(() {
      _collectedData = widget.categoryItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Locations',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => favouritesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.favorite_outline),
            label: const Text('Favourites'),
          ),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     deleteCollection('locations');
          //   },
          //   icon: const Icon(Icons.refresh),
          //   label: const Text('Refesh'),
          // ),
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        padding: const EdgeInsets.all(10),
        children: [
          for (final item in _collectedData) locationGridItem(item),
        ],
      ),
    );
  }
}
