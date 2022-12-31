import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancePlayer;
  final String audioPath;
  const AudioFile({Key? key, required this.advancePlayer,required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  String path = "audio/Do-I-Wanna-Know-Arctic-Monkeys.wav";
  Color color = Colors.black;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    this.widget.advancePlayer.onDurationChanged.listen((d) {setState(() {
      _duration=d;
    }); });
    this.widget.advancePlayer.onPositionChanged.listen((p) {setState(() {
      _position = p;
    }); });
    this.widget.advancePlayer.setSourceUrl(path);

    this.widget.advancePlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if(isRepeat == true){
          isPlaying = true;
        }else{
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart(){
    return IconButton(
        padding: EdgeInsets.only(bottom: 10),
        icon: isPlaying==false?Icon(_icons[0],size: 50,color: Colors.yellow[900],): Icon(_icons[1],size: 50,color: Colors.yellow[900],),
        onPressed: (){
          if(isPlaying == false){
            widget.advancePlayer.play();
            setState(() {
              isPlaying = true;
            });
          }else if(isPlaying == true){
            this.widget.advancePlayer.pause();
            setState(() {
              isPlaying = false;
            });
          }
        });
  }

  Widget loadAssets(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider(){
    return Slider(
        activeColor: Colors.yellow[900],
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value){
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }
  Widget btnFast(){
    return IconButton(
        onPressed: (){
          this.widget.advancePlayer.setPlaybackRate(1.5);
        },
        icon:Icon(
          Icons.keyboard_double_arrow_right
        )
        );
  }
  Widget btnSlow(){
    return IconButton(
        onPressed: (){
          this.widget.advancePlayer.setPlaybackRate(0.5);
        },
        icon: Icon(
          Icons.keyboard_double_arrow_left,
        )
        );
  }
  Widget btnRepeat(){
    return IconButton(
        onPressed: (){
          if(isRepeat==false){
            this.widget.advancePlayer.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat = true;
              color = Colors.yellow[900]!;
            });
          }else if(isRepeat == true){
            this.widget.advancePlayer.setReleaseMode(ReleaseMode.release);
            color = Colors.black;
            isRepeat = false;
          }
        },
        icon: Icon(
          Icons.repeat,
          color: color,
        ));
  }

  Widget btnLoop(){
    return IconButton(
        onPressed: (){
        },
        icon: Icon(
          Icons.loop,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_position.toString().split(".")[0],style: TextStyle(fontSize: 16),),
              Text(_duration.toString().split(".")[0],style: TextStyle(fontSize: 16),),

            ],
          ),),
          slider(),
          loadAssets(),

        ],
      ),
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancePlayer.seek(newDuration);
  }
}

