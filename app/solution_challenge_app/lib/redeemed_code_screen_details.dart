import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:solution_challenge_app/data/coupons.dart';
import 'package:transparent_image/transparent_image.dart';

class redeemedCodesDetailsScreen extends StatefulWidget {
  redeemedCodesDetailsScreen(this.redeemedCardData, {super.key});

  var redeemedCardData;
  @override
  State<redeemedCodesDetailsScreen> createState() =>
      _redeemedCodesDetailsScreenState();
}

void showCodes(BuildContext context, String code) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            scrollable: true,
            contentPadding: EdgeInsets.all(20),
            content: Column(
              children: [
                SelectableText(
                  code,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}

class _redeemedCodesDetailsScreenState
    extends State<redeemedCodesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCodes(context, widget.redeemedCardData[4]);
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
              image: NetworkImage(widget.redeemedCardData[3]),
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
                      widget.redeemedCardData[0],
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
                          Icons.currency_rupee,
                          color: Colors.white,
                        ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        Text(
                          '${widget.redeemedCardData[2]}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.point_of_sale,
                          color: Colors.white,
                        ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        Text(
                          '${widget.redeemedCardData[1]}',
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
