import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:solution_challenge_app/auth.dart';

class previewScreen extends StatefulWidget {
  const previewScreen({super.key});

  @override
  State<previewScreen> createState() => _previewScreenState();
}

class _previewScreenState extends State<previewScreen> {
  final _controller = PageController();
  bool _onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 100,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/jogging-removebg-preview.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Jog",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 400,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pick_up_garbage-removebg-preview.png',
                        height: 400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Collect",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 400,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/click_2-1-removebg-preview.png',
                        height: 400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Snap",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 200,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/analyse-removebg-preview.png',
                        height: 400,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Analyse",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 400,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/verify-removebg-preview.png',
                        height: 400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Verify",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 400,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/repeat-removebg-preview_1.png',
                        height: 400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Repeat!",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 400,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/rewards-0-removebg-preview.png',
                        height: 400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Get Rewarded!",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 400,
                  // foregroundDecoration:
                  //     BoxDecoration(border: Border.all(color: Colors.greenAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/share-1-removebg-preview.png',
                        height: 400,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Share with Communiity",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 134, 72),
                            fontSize: 30),
                      ),
                    ],
                  )),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 180, 249, 183)),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 134, 10),
                    ),
                  ),
                ),
                SmoothPageIndicator(controller: _controller, count: 8),
                _onLastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Auth(),
                          ));
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 180, 249, 183)),
                        child: const Text(
                          'Get Started!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 5, 134, 10),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.jumpToPage(8);
                          setState(() {
                            _onLastPage = true;
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 180, 249, 183)),
                        child: const Text(
                          'Skip!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 5, 134, 10),
                          ),
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
