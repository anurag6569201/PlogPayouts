import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

class garbageImagesDetailsScreen extends StatefulWidget {
  garbageImagesDetailsScreen(this.garbageImagesData, {super.key});

  var garbageImagesData;
  @override
  State<garbageImagesDetailsScreen> createState() =>
      __garbageImagesDetailsScreenScreenState();
}

class __garbageImagesDetailsScreenScreenState
    extends State<garbageImagesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
