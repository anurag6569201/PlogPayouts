import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/location_categories.dart';

// class localStoreLocations {
//   localStoreLocations(this.id, this.title, this.coordinates);

//   String id;
//   String title;
//   List<double> coordinates;
// }

class locationDetails extends StatelessWidget {
  locationDetails(this.category, {super.key});

  Category category;

  void _getLocationsData(String keyword) async {
    var _userData = await FirebaseFirestore.instance
        .collection('locations')
        .doc(keyword)
        .get();

    category.id = _userData.data()!['id'];
    category.title = _userData.data()!['title'];
    category.coordinates = _userData.data()!['coordinates'];

    // local.id = id;
    // print(userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _favourite(meal);
        //     },
        //     icon: const Icon(Icons.star),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              //Add map here

              // Image.network(
              //   meal.imageUrl,
              //   height: 300,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              const SizedBox(
                height: 16,
              ),

              Text(
                "Id: ${category.id}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 16,
              ),

              Text(
                "Time: ",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 16,
              ),

              Text(
                "Distance: ",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
