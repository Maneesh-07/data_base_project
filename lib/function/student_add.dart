import 'package:data_base_project/db/function/db_function.dart';
import 'package:data_base_project/model/data.dart';
import 'package:data_base_project/screens/widgets/addstudent.dart';

studentAdder(List data) {
  final student = StudentModel(
      name: data[0],
      age: data[1],
      number: data[2],
      division: data[3],
      image: data[4]);
  addStudent(student);
  findClear();
}

findClear() {
  nameController.clear();
  ageController.clear();
  numController.clear();
  divController.clear();
}
