import 'package:data_base_project/db/function/db_function.dart';
import 'package:data_base_project/home/search.dart';
import 'package:data_base_project/screens/widgets/studentlist.dart';
import 'package:flutter/material.dart';
import 'package:data_base_project/screens/widgets/addstudent.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getStudents();
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: const Text('Student Data'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => SearchScreen())));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ListStudent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddStudent()));
          // AddStudent();
        },
        icon:const Icon(Icons.add),
        label:const Text('Add Details'),
      ),
    );
  }
}
