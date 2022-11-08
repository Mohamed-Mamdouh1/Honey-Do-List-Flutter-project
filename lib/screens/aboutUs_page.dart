import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width / 4,
                decoration: const BoxDecoration(
                  color: Colors.white54,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              const CircleAvatar(
                radius: 4,
                backgroundColor: Colors.white54,
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                  )),
            ],
          ),
          const Text(
            "About The Developer",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold),
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('lib/asset/developerPic.png'),
            radius: 60,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Mohamed Mamdouh  is a freelance flutter developer and a lover to-do lists. When he  is not programing , he usually has his head buried in a business book or fantasy novel.",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: "YanoneKaffeesatz"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width / 4,
                decoration: const BoxDecoration(
                  color: Colors.white54,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              const CircleAvatar(
                radius: 4,
                backgroundColor: Colors.white54,
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                  )),
            ],
          ),
        ],
      )),
    );
  }
}
