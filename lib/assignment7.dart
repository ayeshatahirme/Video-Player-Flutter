import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart';
import 'package:video_player_flutter/assignment7.dart';
import 'dart:async';


class Assignment7 extends StatefulWidget {

  @override
  _Assignment7State createState() => _Assignment7State();
}

class _Assignment7State extends State<Assignment7> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/assignment7.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment 4'),
        centerTitle: true,
        backgroundColor: Colors.purple[800],
        elevation: 5,
        shadowColor: Colors.grey[300],
      ),
      body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,              
                child: Container(
                  width: 300.0,
                  margin: EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text('Validation Form using TextFormField',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('A form is created using textformfield, text, button, checkbox widgets. It verifies that correct format of data is entered in respective text fields. If something is missing, incomplete or incorrect, the form will show an error. If all errors are resolved; the form is submitted!',
                      style: TextStyle(
                        height: 1.25,
                        color: Colors.black,
                        fontSize: 16,
                        )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Video explanation is given below:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        )
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.purple[800],
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ]
                  ),
                ),
              )
            ]
        )
    );
  }
}
