import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'audio_file.dart';

class DetailAudioPage extends StatefulWidget {
  final songsData;
  final int index;
  const DetailAudioPage({Key? key , this.songsData,required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {

  late AudioPlayer advancePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancePlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      // we are using stack becz we want 3 things on top of each other
      body: Stack(
        children: [
          Positioned(
            right: 0,
              left: 0,
              top: 0,
              height: screenHeight/3,
              child: Container(
                color: Colors.amber,

              )
          ),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AppBar(
                leading: IconButton(
                   icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search,color: Colors.white,),
                    onPressed: (){},
                  ),
                ],
                elevation: 0.0,
              )),
          Positioned(
            left: 0,
              right: 0,
              top: screenHeight*0.22,
              height: screenHeight*0.42,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight*0.1,),
                      Text(this.widget.songsData[this.widget.index]["title"],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),),
                      Text(this.widget.songsData[this.widget.index]["text"], style: TextStyle(
                        fontSize: 18,
                      ),),
                      AudioFile(advancePlayer:advancePlayer,audioPath : this.widget.songsData[this.widget.index]["audio"]),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: screenHeight*0.12,
              left: (screenWidth-150)/2,
              right: (screenWidth-150)/2,
              height: screenHeight*0.18,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white,width: 2),
                  color: Colors.grey[100],
                ),

                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 3),
                      image: DecorationImage(
                        image: AssetImage(this.widget.songsData[this.widget.index]["img"]),
                        fit: BoxFit.cover,
                      )
                    ),

                  ),
                ),
          )),

        ],

      ),


    );
  }
}
