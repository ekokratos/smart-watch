import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

enum Screen { message, music, timer }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int state = 0;

  Screen selectedScreen = Screen.message;

  switchScreen() {
    switch (state) {
      case 0:
        return Container(
          height: 250,
          width: 250,
          margin: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 10.0,
              color: Colors.black,
            ),
          ),
          child: Center(
              child: const Text(
            'messsage',
            textAlign: TextAlign.center,
          )),
        );
      case 1:
        return Container(
          height: 250,
          width: 250,
          margin: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 10.0,
              color: Colors.black,
            ),
          ),
          child: Center(
              child: const Text(
            'Music',
            textAlign: TextAlign.center,
          )),
        );
      case 2:
        return Container(
          height: 250,
          width: 250,
          margin: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 10.0,
              color: Colors.black,
            ),
          ),
          child: Center(
              child: const Text(
            'Timer',
            textAlign: TextAlign.center,
          )),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 450,
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 80,
//                    width: 150,
                    margin: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                  ),
                  Container(
                    height: 80,
//                    width: 150,
                    margin: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.message,
                              color: selectedScreen == Screen.message
                                  ? Colors.blueAccent
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                state = 0;
                                selectedScreen = Screen.message;
                              });
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.music_note,
                              color: selectedScreen == Screen.music
                                  ? Colors.blueAccent
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                state = 1;
                                selectedScreen = Screen.music;
                              });
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.timer,
                              color: selectedScreen == Screen.timer
                                  ? Colors.blueAccent
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                state = 2;
                                selectedScreen = Screen.timer;
                              });
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //switch
            switchScreen()
          ],
        ),
      ),
    );
  }
}
