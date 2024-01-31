import 'package:flutter/material.dart';
import 'package:solution_challenge_app/data/location_categories.dart';
import 'package:solution_challenge_app/location_details.dart';

class locationGridItem extends StatelessWidget {
  locationGridItem(this.category, {super.key});

  Category category;

  void _onSelectCategory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => locationDetails(category),
      ),
    );
  }


  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // displayMeals(category.title, dummyMeals);
        _onSelectCategory(context);
        // const Text('Hi');
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
