import 'dart:async';
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
          child: Messages(),
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
            child: StopWatch());
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

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => new _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Stopwatch watch = new Stopwatch();

  Timer timer;
  List<Text> laps=[];
  String elapsedTime = '00:00';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Positioned(
            left: 70,
            top:20,
            child: Text(elapsedTime,
                style: new TextStyle(fontSize: 25.0, color: Colors.white))),
         Center(
           child: Container(
              height: 100,
              width: 100,
              child:Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context,index){
                    return laps[index];
                  },
                ),
              )
            ),
         ),
        

        Positioned(
          left: 30,
          bottom: 10,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 40.0,
                child: new FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: startWatch,
                    child: new Icon(Icons.play_arrow)),
              ),
              Container(
                height: 40.0,
                child: new FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: stopWatch,
                    child: new Icon(Icons.watch_later)),
              ),
              Container(
                height: 40.0,
                child: new FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: resetWatch,
                    child: new Icon(Icons.refresh)),
              ),
            ],
          ),
        )
      ],
    );
  }

  startWatch() {
    watch.start();
    timer = new Timer.periodic(new Duration(milliseconds: 100), updateTime);
  }

  stopWatch() {
    setState(() {
            laps.add(Text("${laps.length+1}. ${elapsedTime}",
          style: new TextStyle(fontSize: 15.0, color: Colors.white)));
          print(laps);
    });

  }

  resetWatch() {
    watch.reset();
    watch.stop();
    setTime();
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }
}

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool isVisble = false;
  String from = "";
  String content = "";

  void setVisibilty() {
    setState(() {
      isVisble = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isVisble
        ? MessageDisply(from, content, setVisibilty)
        : ListView(
            children: <Widget>[
              ListTile(
                onTap: () => setState(() {
                  isVisble = true;
                  from = "Adithya";
                  content = "Message from Adithya";
                }),
                title: Text(
                  "Adithya",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text("Message from Adi",
                    style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                onTap: () => setState(() {
                  isVisble = true;
                  from = "Shreyas";
                  content = "Message from Shreyas";
                }),
                title: Text("Shreyas", style: TextStyle(color: Colors.white)),
                subtitle: Text("Message from Shreyas",
                    style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                onTap: () => setState(() {
                  isVisble = true;
                  from = "Riya";
                  content = "Message from Riya";
                }),
                title: Text("Riya", style: TextStyle(color: Colors.white)),
                subtitle: Text("Message from Riya",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          );
  }
}

class MessageDisply extends StatelessWidget {
  final String from;
  final String content;
  final Function setVisibilty;
  MessageDisply(this.from, this.content, this.setVisibilty);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 200.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: setVisibilty,
              ),
              Text(
                from,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Text(
            content,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
