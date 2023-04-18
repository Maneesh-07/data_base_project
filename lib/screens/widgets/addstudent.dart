import 'package:data_base_project/function/error_message.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

final nameController = TextEditingController();

final ageController = TextEditingController();

final numController = TextEditingController();

final divController = TextEditingController();

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  String? imagePath;


//functionss-----------------------------------------
  
  Future<void> StudentAddBtn() async {
    List data = [
      nameController.text.trim(),
      ageController.text.trim(),
      numController.text.trim(),
      divController.text.trim(),
      imagePath
    ];

    SnackBar mysnackbar = CheckError(data);
    ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
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

  Widget elavatedbtn({required Icon myIcon, required Text myLabel}) {
    return ElevatedButton.icon(
      onPressed: () {
        if (nameController.text.isNotEmpty &&
            ageController.text.isNotEmpty &&
            numController.text.isNotEmpty &&
            divController.text.isNotEmpty) {
          StudentAddBtn();
          Navigator.of(context).pop();
        } else {
        StudentAddBtn();
          // const snackBar = SnackBar(
          //   content: Text('Every field is Empty'),
          //   backgroundColor: Colors.red,
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      icon: myIcon,
      label: myLabel,
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, hintName}) {
    return TextFormField(
      // textCapitalization: TextCapitalization.characters,
      controller: myController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        labelText: hintName,
      ),
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: imagePath == null
              ? const AssetImage('assets/images/avatar_1.png') as ImageProvider
              : FileImage(File(imagePath!)),
        ),
        Positioned(
            bottom: 9,
            right: 25,
            child: InkWell(
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 30,
                ),
                onTap: () {
                  takePhoto();
                })),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

// builder----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Student Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(myController: nameController, hintName: "Name"),
              szdBox,
              textFieldName(myController: ageController, hintName: "Age"),
              szdBox,
              textFieldName(myController: numController, hintName: "Number"),
              szdBox,
              textFieldName(myController: divController, hintName: "Division"),
              szdBox,
              elavatedbtn(
                  myIcon: const Icon(Icons.person_add_alt_outlined),
                  myLabel: const Text('Add student')),
              // elavatedbtn(
              //     myIcon: Icon(Icons.access_alarm), myLabel: 'saample2'),
            ]),
          ),
        ));
  }
}
