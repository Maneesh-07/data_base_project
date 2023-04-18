import 'package:data_base_project/model/data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  final _id = await studentDB.add(value);
  value.id = _id;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}


Future<void> getStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}


Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  await studentDB.deleteAt(id);
  getStudents();
}
