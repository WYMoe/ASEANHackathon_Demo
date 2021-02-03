import 'package:flutter/material.dart';
import 'package:json_serializable_test/widgets/circular_background_painter.dart';
import 'package:json_serializable_test/services/services.dart' as services;
class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: [Colors.purple, Colors.purple[200], Colors.purple],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter)),

            child: CustomPaint(
              painter: new CircularBackgroundPainter(),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'ATLAS Demo',
                  style: TextStyle(
                      fontFamily: 'BalooTamma2-Regular',
                      fontSize: MediaQuery.of(context).size.width * 0.2,
                     color: Colors.green
                    ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    services.googleSignIn.signIn();
                  },
                  child: Container(
                    width: 260.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/google_signin_button.png'),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );;
  }
}
