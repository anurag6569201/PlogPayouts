import 'package:flutter/material.dart';
import 'package:solution_challenge_app/garbage_class.dart';
import 'package:solution_challenge_app/garbage_items_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class garbageItems extends StatelessWidget {
  garbageItems(this.fetchedGarbageData, {super.key});

  // final Meal meal;
  garbageData fetchedGarbageData;

  // String get complexityText {
  //   return meal.complexity.name[0].toUpperCase() +
  //       meal.complexity.name.substring(1);
  // }

  // String get affordabilityText {
  //   return meal.affordability.name[0].toUpperCase() +
  //       meal.affordability.name.substring(1);
  // }

  // void Function(BuildContext context, Meal meal) _onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          // _onSelectMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(fetchedGarbageData.image_url),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              top: 115,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      fetchedGarbageData.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        garbageItemTrait(
                            Icons.countertops, '${fetchedGarbageData.count}'),
                        const SizedBox(
                          width: 17,
                        ),
                        // mealItemTrait(Icons.work, complexityText),
                        // const SizedBox(
                        //   width: 17,
                        // ),
                        // mealItemTrait(Icons.attach_money, affordabilityText),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
