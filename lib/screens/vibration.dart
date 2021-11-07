import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class Vibration extends StatefulWidget {
  @override
  _VibrationState createState() => _VibrationState();
}

class _VibrationState extends State<Vibration> {

  String text =  "re-present-ing mul-tip-le things";
  // String text = "";
  List<double> _radii = [10, 10, 10, 10, 10, 10];
  List stuff = [];
  String _prevText = '';
  String _futureText = '';
  String _currentText = '';
  late List<String> gen;

  @override
  void initState() {
    super.initState();
    String newText = '';
    for (String s in text.split(' ')) {
      newText = newText + '- ' + s;
    }
    text = newText.substring(2);
    gen = text.split('-');
    generateBraille();
  }

  Widget ball(BuildContext context, int gap) {
    return AvatarGlow(
      glowColor: HexColor('#C195AF'),
      endRadius: 50.0,
      duration: Duration(milliseconds: 500),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: gap),
      child: Material(
        // Replace this child with your own
        elevation: 8.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: HexColor('#DF9C8C'),
          child: Container(
            height: 5,
            width: 5,
          ),
          radius: 10.0,
        ),
      ),
    );
  }

  Future waitUp(dur) async {
    await Future.delayed(Duration(milliseconds: dur));
  }

  void generateBraille() async {
    Random random = new Random();

    for (String s in gen) {
      String braille = '';
      int num;
      for (int i = 0; i < 6; i++) {
        num = random.nextInt(2);
        braille = braille + num.toString();
      }
      stuff.add(braille);
    }
    pulse();
  }
  String generate(int i) {
    int start = 0;
    if (i - 3 > 0) {
      start = i - 3;
    }
    String ans = start == 0 ? gen[start] : '. . . ' + gen[start];

    if (i + 1 < gen.length) {
      if (gen[i + 1][0] != ' ') {
        _futureText = gen[i + 1];
        start = start - 1;
      } else {
        _futureText = '';
      }
    } else {
      _futureText = '';
    }
    for (int j = start + 1; j < i; j++) {
      ans = ans + gen[j];
    }
    return i == 0 ? '' : ans;
  }
  void pulse() async {
    int j = 0;
    await waitUp(1000);

    for (String s in stuff) {
      List<double> _radiiCopy = [10, 10, 10, 10, 10, 10];
      for (int i = 0; i < 6; i++) {
        if (s[i] == '1') {
          _radiiCopy[i] = 20;
        }
      }
      await waitUp(200);
      setState(() {
        _currentText = gen[j];
        _prevText = generate(j);
        _radii[0] = _radiiCopy[0];
        _radii[1] = _radiiCopy[1];
        _radii[2] = _radiiCopy[2];
        _radii[3] = _radiiCopy[3];
        _radii[4] = _radiiCopy[4];
        _radii[5] = _radiiCopy[5];
      });
      Clipboard.setData(ClipboardData());
      HapticFeedback.heavyImpact();
      await waitUp(200);
      _radiiCopy = [10, 10, 10, 10, 10, 10];
      setState(() {
        _radii[0] = _radiiCopy[0];
        _radii[1] = _radiiCopy[1];
        _radii[2] = _radiiCopy[2];
        _radii[3] = _radiiCopy[3];
        _radii[4] = _radiiCopy[4];
        _radii[5] = _radiiCopy[5];
      });
      j += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top : 150.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       MaterialButton(
            //         minWidth: MediaQuery.of(context).size.width * 0.8,
            //         onPressed: () {
            //           pulse();
            //         },
            //         color: HexColor('#A48FAF'),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
            //           child: Text(
            //             "Switch It Up",
            //             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Cookie"),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Column(
                children: [
                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_prevText, style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Cookie',
                        fontSize: 25,
                      ),),
                      Text(_currentText, style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cookie',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),),
                      Text(_futureText +  ' . . .', style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cookie',
                        fontSize: 25,
                      ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  AvatarGlow(
                    glowColor: HexColor('#C195AF'),
                    endRadius: 60.0,
                    duration: Duration(milliseconds: 1000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 250),
                    child: Material(
                      // Replace this child with your own
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent.withOpacity(0.8),
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                        radius: 22.0,
                      ),
                    ),
                  )

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: [
                    Spacer(),
                    buildRow(0, 1, HexColor('#DF9C8C'), HexColor('#DF9C8C')),
                    Spacer(),
                    buildRow(2, 3, HexColor('#C195AF'), HexColor('#C195AF')),
                    Spacer(),
                    buildRow(4, 5, HexColor('#A48FAF'), HexColor('#A48FAF')),
                    Spacer(),
                  ],
                ),
              ),
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ball(context, 50),
            //     ball(context, 300),
            //   ],
            // ),
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ball(context, 200),
            //     ball(context, 150),
            //   ],
            // ),
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ball(context, 250),
            //     ball(context, 100),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Row buildRow(int l, int r, Color le, Color ri) {
    return Row(
      children: [
        Spacer(),
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          child: Material(
            // Replace this child with your own
            elevation: 8.0,
            shape: const CircleBorder(),
            child: CircleAvatar(
              backgroundColor: le,
              child: Container(),
              radius: _radii[l],
            ),
          ),
        ),
        Spacer(),
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          child: Material(
            // Replace this child with your own
            elevation: 8.0,
            shape: const CircleBorder(),
            child: CircleAvatar(
              backgroundColor: ri,
              child: Container(),
              radius: _radii[r],
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
