import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:solution_challenge_app/data/coupons.dart';
import 'package:transparent_image/transparent_image.dart';

class rankingDetails extends StatefulWidget {
  rankingDetails(this.ranks, {super.key});

  var ranks = [];
  @override
  State<rankingDetails> createState() => _rankingDetailsState();
}

void randomRewards() {}

class _rankingDetailsState extends State<rankingDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image.asset('assets/images/trophies.jpg', scale: 2),
        InkWell(
          onTap: () {
            randomRewards();
          },
          child: Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: InkWell(
              onTap: () {
                randomRewards();
              },
              child: Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(widget.ranks[3]),
                    fit: BoxFit.cover,
                    height: 210,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    top: 130,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 44),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.ranks[1],
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
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.money,
                                color: Colors.white,
                              ),
                              // const SizedBox(
                              //   height: 25,
                              // ),
                              Text(
                                '${widget.ranks[2]}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              CircleAvatar(
                                radius: 15.0,
                                backgroundImage: NetworkImage(widget.ranks[0]),
                                backgroundColor: Colors.transparent,
                              ),
                            ],
                          ),
                          // const Spacer(),
                          // const Icon(
                          //   Icons.point_of_sale,
                          //   color: Colors.white,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
