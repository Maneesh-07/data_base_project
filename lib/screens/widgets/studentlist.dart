import 'dart:io';
import 'package:data_base_project/home/profile.dart';
import 'package:data_base_project/screens/widgets/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:data_base_project/db/function/db_function.dart';
import 'package:data_base_project/model/data.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getStudents();
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<StudentModel> studentList,
          Widget? child) {
        return ListView.separated(
            itemBuilder: ((context, index) {
              final data = studentList[index];
              return Container(
                color: const Color.fromARGB(255, 218, 239, 239),
                child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.image)),
                      radius: 30,
                    ),
                    title: Text(data.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          passValueProfile: data,
                                          index: index,
                                        )));
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.green.shade400,
                        ),
                        IconButton(
                          onPressed: () {
                            deleteAlert(context, index);
                            // deleteStudent(index);
                          },
                          icon: const Icon(Icons.delete_outlined),
                          color: Colors.red,
                        ),
                      ],
                    ),
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentProfile(
                                    passValue: data,
                                    passId: index,
                                  )));
                    })),
              );
            }),
            separatorBuilder: (context, index) {
              return const Divider(
                height: 3,
              );
            },
            itemCount: studentList.length);
      },
    );
  }
}

deleteAlert(BuildContext context, index) {
  showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('Are you sure you want to delete'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudent(index);
                    Navigator.of(context).pop(ctx);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text('Cancel'),
              )
            ],
          )));
}
