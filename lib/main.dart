import 'assignment4.dart';
import 'assignment5.dart';
import 'assignment7.dart';
import 'assignment8.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarouselDemoState(),
    );
  }
}

class CarouselDemoState extends StatefulWidget {
  @override
  _CarouselDemoStateState createState() => _CarouselDemoStateState();
}

class _CarouselDemoStateState extends State<CarouselDemoState> {
  CarouselSlider carouselSlider;
  List imgList = [
    'https://images.unsplash.com/photo-1623097261790-810608ab3162?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=374&q=80',
    'https://images.unsplash.com/photo-1623098443780-d74154121a7f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=374&q=80',
    'https://images.unsplash.com/photo-1623097200485-968c999ff130?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=374&q=80',
    'https://images.unsplash.com/photo-1623073344463-67b7e23e9de9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=374&q=80',
  ];

  final List titles = [
  'DropdownButton, ToggleButton & CheckboxListTile',
  'Add Record & Integrate Web API to Add Records',
  'Validation Form using TextFormField',
  'TabBar, TabBarView & TabController',
  ];

  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  goToPrevious() {
    carouselSlider.previousPage(
        duration: Duration(seconds: 2), curve: Curves.ease);
  }

  goToNext() {
    carouselSlider.nextPage(
        duration: Duration(seconds: 2), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
        centerTitle: true,
        backgroundColor: Colors.purple[800],
      ),
      body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      carouselSlider = CarouselSlider(
                        height: 450.0,
                        initialPage: 0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        reverse: false,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 3),
                        pauseAutoPlayOnTouch: Duration(seconds: 10),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        items: imgList.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.only(bottom: 30),
                                width: 300.0,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      '${titles[_current]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                    ),
                                    Image.network(
                                      imgUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ]
                                )                      
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(imgList, (index, url) {
                          return Container(
                            width: 7.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index ? Colors.red[900] : Colors.grey,
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlineButton(
                            onPressed: goToPrevious,
                            child: Text("<"),
                          ),
                          OutlineButton(
                            onPressed: goToNext,
                            child: Text(">"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                      child: Text('Show Details'),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllVideos()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[800],
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                          textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                            height: 30.0,
                          ),
                ],
              ),
            ),
          )
        ]
      )
    );
  }
}

class AllVideos extends StatefulWidget {
  @override
  _AllVideosState createState() => _AllVideosState();
}

class _AllVideosState extends State<AllVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
        centerTitle: true,
        backgroundColor: Colors.purple[800],
      ),
        body: Center(          
          child: Card(
            elevation: 50,
            shadowColor: Colors.grey[400],
            color: Colors.purple[800],
            child: SizedBox(
              width: 300,
              height: 350,
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children:[
                    SizedBox(
                        height: 30,
                      ),
                      Text('Assignment 9',
                      style: TextStyle(
                        height: 3,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text('Assignment 4, 5, 7, 8 videos created including brief description.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        wordSpacing: 1,
                        color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        ),
                      ],
                  ),
                ),
              )
            ),            
          ),      
          drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    SizedBox(
                        height: 20,
                      ),
                    Padding(padding: EdgeInsets.all(1.0),
                    ),
                    Text('Assignment list',
                    style: TextStyle(
                      height: 2,
                      color: Colors.white,
                      fontSize: 18,
                    )
                    ),
                    SizedBox(
                        height: 8,
                      ),
                    Text('Select to see details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      )
                    ),
                  ],
                ),
                
                decoration: BoxDecoration(
                  color: Colors.purple[800],
                  ),
                ),
                ListTile(
                  leading: new Icon(Icons.input),
                  title: Text('Input widgets'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Assignment4()));
                  }
                ),
                ListTile(
                  leading: new Icon(Icons.add),
                  title: Text('Add Records'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Assignment5()));
                   // Navigator.pop(context);
                  }
                ),
                ListTile(
                  leading: new Icon(Icons.text_fields),
                  title: Text('Validation form'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Assignment7()));
                   // Navigator.pop(context);
                  }
                ),
                ListTile(
                  leading: new Icon(Icons.tab),
                  title: Text('Tab widgets'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Assignment8()));
                   // Navigator.pop(context);
                  }
                ),
                ListTile(
                  leading: new Icon(Icons.arrow_back),
                  title: Text('Main Screen'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CarouselDemoState()));
                   // Navigator.pop(context);
                  }
                ),
            ]
          ),
        ),
      

      /*CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[]
                )
              )
            )
          ]
      )*/
    );
  }
}