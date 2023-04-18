import 'package:data_base_project/function/error_check.dart';
import 'package:data_base_project/function/student_add.dart';
import 'package:flutter/material.dart';

SnackBar CheckError(List data) {
  
  String field = ErrorCheck(data);

  if (field != "success") {
    SnackBar mysnackbar = SnackBar(
      content: Row(
        children: [const Icon(Icons.error), Text("$field is empty")],
      ),
      backgroundColor: Colors.red,
    );
    return mysnackbar;
  } else {
    studentAdder(data);
    SnackBar mysnackbar = SnackBar(
        content: Row(
      children:const [Icon(Icons.done), Text("Successfullty added"),
      
      ],
      
            
    ));
    return mysnackbar;
  }
}
