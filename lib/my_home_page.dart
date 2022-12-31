
import 'package:audio/detail_audio_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

 late List popularSong;
 late List songs;
 late ScrollController _scrollController;
 late TabController _tabController;

  ReadData() async {
   await DefaultAssetBundle.of(context).loadString("json/popularSong.json").then((s){
      setState(() {
        popularSong = json.decode(s);
      });
    });
   await DefaultAssetBundle.of(context).loadString("json/songs.json").then((s){
     setState(() {
       songs = json.decode(s);
     });
   });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10,),
                        Icon(Icons.notifications),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('Popular Songs',style: TextStyle(fontSize: 30,
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    // this is done to align the container with the heading
                    Positioned(
                      top:0,
                      left: -25,
                      right: 0,
                      child: Container(
                          height: 180,
                          child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount:popularSong==null? 0 : popularSong.length,
                            itemBuilder: (_,i){
                              return Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: AssetImage(popularSong[i]["img"]),
                                        fit: BoxFit.fill
                                    )
                                ),

                              );
                            },
                          ),
                        ),
                    )
                  ],
                ),
              ),
              Expanded(child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context ,  bool isScroll){
                  return[
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: EdgeInsets.only(left: 10,bottom: 20),
                          child: TabBar(
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.all(5),
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 blurRadius: 7,
                                 offset: Offset(0,0),
                               )
                              ]
                            ),
                            tabs: [
                              Container(
                                height:50,
                                width: 120,
                                child: Text(
                                  "New", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 7,
                                      offset: Offset(0,0),
                                    )
                                  ]
                                ),
                              ),
                              Container(
                                height:50,
                                width: 120,
                                child: Text(
                                  "Popular", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      blurRadius: 7,
                                      offset: Offset(0,0),
                                    )
                                  ]
                                ),
                              ),
                              Container(
                                height:50,
                                width: 120,
                                child: Text(
                                  "Trending", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      blurRadius: 7,
                                      offset: Offset(0,0),
                                    )
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                }, body: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                      itemCount: songs==null?0:songs.length,
                      itemBuilder: (_,i){
                    return Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>DetailAudioPage(songsData:songs,index:i )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 0),
                                color: Colors.grey.withOpacity(0.2),
                              )
                            ]
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(songs[i]['img'])),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      songs[i]["title"],
                                      style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),

                                    ),
                                    Text(
                                      songs[i]["text"],
                                      style: TextStyle(fontSize: 15,color: Colors.grey),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    );
                  }),
                  ListView.builder(
                      itemCount: popularSong==null?0:popularSong.length,
                      itemBuilder: (_,i){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>DetailAudioPage(songsData:popularSong,index:i)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  ]
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(popularSong[i]['img'])),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          popularSong[i]["title"],
                                          style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),

                                        ),
                                        Text(
                                          popularSong[i]["text"],
                                          style: TextStyle(fontSize: 15,color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  ListView.builder(
                      itemCount: songs==null?0:songs.length,
                      itemBuilder: (_,i){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>DetailAudioPage(songsData:songs,index:i)));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  ]
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(songs[i]['img'])),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          songs[i]["title"],
                                          style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),

                                        ),
                                        Text(
                                          songs[i]["text"],
                                          style: TextStyle(fontSize: 15,color: Colors.grey),

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ),
                        );
                      }),
                ],
              ),

              )),
            ],
          ),

        ),
      ),
    );
  }
}
