import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class garbageImagesDetailsScreen extends StatefulWidget {
  garbageImagesDetailsScreen(this.garbageImagesData, {super.key});

  var garbageImagesData;
  @override
  State<garbageImagesDetailsScreen> createState() =>
      __garbageImagesDetailsScreenScreenState();
}

void deleteItems(BuildContext context, garbageImagesData) {
  print(garbageImagesData);
  Navigator.of(context).pop();
  var useruid = FirebaseAuth.instance.currentUser!.uid; 
  var uuid = garbageImagesData.uuid;
  var url =
      'https://solution-challenge-app-409f6-default-rtdb.firebaseio.com/solution-challenge/${useruid}/collected-garbage/${uuid}.json';
  print(Uri.parse(url));
  http.delete(Uri.parse(url));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "Deleted!",
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ));
}

void editItems(BuildContext context, garbageImagesData) async {
  Navigator.of(context).pop();
  // var useruid = FirebaseAuth.instance.currentUser!.uid;
  // var uuid = garbageImagesData.uuid;
  var url =
      'https://solution-challenge-app-409f6-default-rtdb.firebaseio.com/solution-challenge/${useruid}/collected-garbage/${uuid}.json';
  print(Uri.parse(url));
  var response = await http.get(Uri.parse(url));
  print(response.body);
}

class __garbageImagesDetailsScreenScreenState
    extends State<garbageImagesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // _deleteItem(widget.garbageImagesData);
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: AlertDialog(
                  title: Text(
                    "Please choose an option below-",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        deleteItems(context, widget.garbageImagesData);
                      },
                      child: Text(
                        "Delete",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        editItems(context, widget.garbageImagesData);
                      },
                      child: Text(
                        "Edit",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(widget.garbageImagesData[1]),
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
                      widget.garbageImagesData[2],
                      maxLines: 2,
                      textAlign: TextAlign.center,
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
                        const Icon(
                          Icons.numbers,
                          color: Colors.white,
                        ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        Text(
                          '${widget.garbageImagesData[0]}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        // const Spacer(),
                        // TextButton.icon(
                        //     onPressed: _deleteItem(),

                        //     icon: Icon(Icons.delete),
                        //     label: Text(
                        //       'Duplicate/Error ?',
                        //       style: const TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     ))
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
