import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/screens/home_screen.dart';
import 'package:flutter_chatgpt/utils/colors.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              "images/myRobo.png",
              height: MediaQuery.of(context).size.height / 2,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const Spacer(),
          const Text(
            "How may i help\nyou today?",
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 2,
            strutStyle: StrutStyle(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          const Text(
            "Using this software, you can ask your\nquestions and receive articles using\nartificial intelligence assitant.",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: Container(
              height: 76,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
              decoration: BoxDecoration(
                  color: MyColors.secondColor,
                  borderRadius: BorderRadius.circular(50)),
              child: const Center(
                child: Text(
                  "Start a new chat",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
