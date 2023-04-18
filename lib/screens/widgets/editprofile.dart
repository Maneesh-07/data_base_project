import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:data_base_project/db/function/db_function.dart';
import 'package:data_base_project/home/homescreen.dart';
import 'package:data_base_project/model/data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditProfile extends StatefulWidget {
  EditProfile(
      {Key? key,
      // required this.passValue01,
      required this.index,
      required this.passValueProfile})
      : super(key: key);

  StudentModel passValueProfile;
  int index;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final _nameController =
      TextEditingController(text: widget.passValueProfile.name);

  late final _ageController =
      TextEditingController(text: widget.passValueProfile.age);

  late final _numController =
      TextEditingController(text: widget.passValueProfile.number);

  late final _divController =
      TextEditingController(text: widget.passValueProfile.division);

  String? imagePath;

  // final ImagePicker _picker = ImagePicker();

//function or widget==================================================

  Future<void> StudentAddBtn(int index) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final number = _numController.text.trim();
    final division = _divController.text.trim();
    // final _image = imagePath;

    // if (name.isEmpty) {
    //   return;
    // }

    print('$name $age $number $division');

    final _students = StudentModel(
      name: name,
      age: age,
      number: number,
      division: division,
      image: imagePath ?? widget.passValueProfile.image,
    );
    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    studentDB.putAt(index, _students);
    getStudents();
  }

  Future<void> takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        StudentAddBtn(widget.index);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => HomeScreen()),
            (route) => false);
      },
      icon: Icon(Icons.update_rounded),
      label: Text('Update'),
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, required String hintName}) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: hintName,
        // counterText: myController.text
      ),
      // initialValue: 'hintName',
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: imagePath == null
              ? FileImage(File(widget.passValueProfile.image))
              : FileImage(File(imagePath!)),
        ),
        Positioned(
            bottom: 2,
            right: 10,
            child: InkWell(
                child: const Icon(
                  Icons.add_a_photo_rounded,
                  size: 30,
                ),
                onTap: () {
                  takePhoto();
                })),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  //build======================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(myController: _nameController, hintName: 'name'),
              szdBox,
              textFieldName(
                  myController: _ageController,
                  hintName: 'age'),
              szdBox,
              textFieldName(
                  myController: _numController,
                  hintName: 'number'),
              szdBox,
              textFieldName(
                  myController: _divController,
                  hintName: 'division'),
              szdBox,
              elavatedbtn(),
            ]),
          ),
        ));
  }
}
