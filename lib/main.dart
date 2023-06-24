import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import "package:audioplayers/audioplayers.dart";

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  cllick() {
    return Center(
      child: Column(children: [
        Container(
          width: 200,
          height: 300,
          color: Colors.black,
        )
      ]),
    );
  }

  int shakeCount = 0;
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          isVisible = !isVisible;
          textvisible = false;
        });
        final player = AudioPlayer();

        player.play(AssetSource('check.mp3'));
        //player.play("check.mp3");
        //PlayerAudio.play(UrlSource('check.mp3'));
        shakeCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You can hear the sound'),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      // shakeSlopTimeMS: 500,
      // shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  bool isVisible = false;
  bool textvisible = true;
  int shakeCount = 0;
  @override
  Widget build(BuildContext context) {
    ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        shakeCount++;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BELL BOY",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isVisible,
              child: Container(
                //height: 300,
                //width: 300,
                //color: Colors.black,
                child: Image.network(
                    "https://i.gifer.com/origin/06/06d3da7e7d8e8a51bfbdd2f34465e4d9.gif"),
              ),
            ),
            Visibility(
              visible: textvisible,
              child: Container(
                child: Text(
                  "Flip Up and Down to ring a bell",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    textvisible = !textvisible;
                  });
                },
                child: Text("Hello"))
          ],
        ),
      ),
    );
    /*return Scaffold(
      body: Center(
        child: Image.network(
            "https://i.gifer.com/origin/06/06d3da7e7d8e8a51bfbdd2f34465e4d9.gif"),
      ),
    );*/
  }
}
