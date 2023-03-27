import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:motorvelox/designParams/params.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return (Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 10.0),
              child: Center(
                child: Text('The best for your car',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: FadeInLeft(
                  animate: true,
                  duration: const Duration(seconds: 3),
                  child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.center,
                          end: FractionalOffset.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image(
                        image: const AssetImage('assets/images/car2.png'),
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.5,
                      )),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 22,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "auth");
              },
              child: const Text('Get Started'),
            )
          ],
        ),
      ),
    ));
  }
}
