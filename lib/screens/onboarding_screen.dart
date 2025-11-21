import 'package:flutter/material.dart';
import 'package:loginsignup/screens/constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -330,
              right: -330,
              child: Container(
                height: 600,
                width: 600 ,
                decoration: BoxDecoration(color: Colors.lightBlue, shape: BoxShape.circle),
              )),
          Row(
            children: [
              SizedBox(
                height: 60,
                width: 160,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "login",
                      style: h2.copyWith(color: white, fontSize: 20),)),
              )
            ],
          )
        ],
      ),
    );
  }
}