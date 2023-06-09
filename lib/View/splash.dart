import 'package:flutter/material.dart';

import 'navBar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: myHeight,
        width: myWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/image/1.gif'),
            const Column(
              children: [
                Text('CryptoPedia',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Learn everything to know about CryptoCurrency',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 104, 102, 102)),
                  ),
                ),
                SizedBox(height: 35),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.14),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NavBar()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFBC700),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: myWidth * 0.05, vertical: myHeight * 0.013),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create PortFolio',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800]),
                        ),
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(310 / 360),
                          child: Icon(Icons.arrow_forward_rounded),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
