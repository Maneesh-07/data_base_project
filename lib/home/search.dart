import 'dart:io';

import 'package:data_base_project/home/profile.dart';
import 'package:data_base_project/model/data.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  final _searchController = TextEditingController();

  List<StudentModel> studentList =
      Hive.box<StudentModel>('Student_db').values.toList();

  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);



  Widget expanded() {
    return Expanded(
      child: studentDisplay.isNotEmpty
          ? ListView.builder(
              itemCount: studentDisplay.length,
              itemBuilder: (context, index) {
                // final data = studentList[index];
                File img = File(studentDisplay[index].image);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(img),
                    // studentDisplay[index].image.toString(),
                    radius: 22,
                  ),
                  title: Text(studentDisplay[index].name),
                  // subtitle: Text(
                  //     '${studentDisplay[index]["age"].toString()} years old'),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentProfile(
                                  passValue: studentDisplay[index],
                                  passId: index,
                                )));
                  }),
                );
              },
            )
          : const Text(
              'No match found',
              style: TextStyle(fontSize: 20),
            ),
    );
  }

  Widget searchTextField() {
    
    return TextFormField(
      autofocus: true,
      controller: _searchController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon:const Icon(Icons.search),
        suffixIcon: IconButton(
          icon:const Icon(Icons.clear),
          onPressed: () => clearText(),
        ),
        filled: true,
        fillColor:const Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: 'search',
      ),
      onChanged: (value) {
        _searchStudent(value);
      },
    );
  }

  void _searchStudent(String value) {
    setState(() {
      studentDisplay = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
          
    });
  }

  void clearText() {
    _searchController.clear();
  }

  //builder-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              searchTextField(),
              expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
