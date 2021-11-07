import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:senses/screens/pdf.dart';
import 'package:senses/screens/speech.dart';
import 'package:senses/screens/vibration.dart';
import 'package:senses/screens/youtube.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> _display(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Youtube Link', style: TextStyle(
          color: Colors.redAccent,
          fontFamily: 'Cookie',
          fontSize: 20,
        ),),
        content: TextField(style: TextStyle(
          color: Colors.grey,
          fontFamily: 'Cookie',
          fontSize: 15,
        ),
          onSubmitted: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Youtube()),
            );
        },
        decoration: InputDecoration(hintText: "Paste link here"),),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top : 120, bottom: 0),
              child: Image.asset(
                "assets/logo.jpg",
                height: 150,
              ),
            ),
            const Text('Pick a format to convert into Braille !', style: TextStyle(
              color: Colors.black,
              fontFamily: 'Cookie',
              fontSize: 20,
            ),),
            SizedBox(height: 40,),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.8,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vibration()),
                );
              },
              color: HexColor('#DF9C8C'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                child: Text(
                  "Real-Time Speech",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Cookie"),
                ),
              ),
            ),

            SizedBox(height: 5,),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.8,
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();

                if (result != null) {
                  // File file = File(result.files.single.path);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PDF()),
                  );
                } else {
                  // User canceled the picker
                }
              },
              color: HexColor('#C195AF'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                child: Text(
                  "PDF Document",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Cookie"),
                ),
              ),
            ),
            SizedBox(height: 5,),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.8,
              onPressed: () {
                _display(context);
              },
              color: HexColor('#A48FAF'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                child: Text(
                  "Youtube Video",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Cookie"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
