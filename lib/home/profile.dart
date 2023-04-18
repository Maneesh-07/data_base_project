import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:data_base_project/model/data.dart';

class StudentProfile extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 160;

  StudentProfile({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  StudentModel passValue;
  final int passId;

//functions or widgets========================================================

  Widget top() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(clipBehavior: Clip.none, children: [
      Container(margin: EdgeInsets.only(bottom: bottom), child: CoverImage()),
      Positioned(
        top: top,
        left: 120,
        child: ProfileImage(),
      ),
    ]);
  }

  Widget content() {
    var size =const SizedBox(
      height: 5,
    );
    return Container(
      width: 200,
      height: 170,
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: flipAxis(Axis.horizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              ' ${passValue.name}',
              style: const TextStyle(fontSize: 28, fontFamily: 'Ubuntu'),
            ),
            size,
            Text('Age : ${passValue.age}',
                style: const TextStyle(fontSize: 18, color: Colors.brown)),
            size,
            Text('Number : ${passValue.number}',
                style: const TextStyle(fontSize: 18, color: Colors.brown)),
            size,
            Text('Division : ${passValue.division}',
                style: const TextStyle(fontSize: 18, color: Colors.brown)),
            size
          ],
        ),
      ),
    );
  }

  Widget CoverImage() => Container(
        color: Color.fromARGB(252, 61, 69, 78),
        width: double.infinity,
        height: coverHeight,
      );

  Widget ProfileImage() => CircleAvatar(
        backgroundImage: FileImage(File(passValue.image)),
        radius: profileHeight / 2,
      );

  // Widget floatbtn(BuildContext context) {
  //   return IconButton(
  //       onPressed: () {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => StudentProfile(
  //                   passValue: passValue,
  //                    passId: passId)));
  //       },
  //       icon: const Icon(Icons.access_alarm_outlined));
  // }

//builder====================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          // actions: [
          //   floatbtn(context),
          // ],
        ),
        body: Container(
          color: Colors.lightBlue.shade200,
          child: ListView(children: <Widget>[
            top(),
            content(),
          ]),
        ));
  }
}
