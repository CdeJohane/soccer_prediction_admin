import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class AddPlayerBtn extends StatelessWidget {
  const AddPlayerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(context: context, builder: (BuildContext context){
          TextEditingController nameController = TextEditingController();
          return AlertDialog(
            title: Text('Add Player'),
            content: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'username'),
                ),
          actions: [
            TextButton(
              onPressed: () async{
                String name = nameController.text;
                // Name has to be >3 Characters
                if(name.length<=3){
                  Fluttertoast.showToast(msg: "Enter Correct Length. More than 3 Characters");
                }else{
                  final Map<String, String> data = {
                    'name': name,
                  };
                  // Send Details to database for verification and addition
                  var httpResponse = await http.post(
                    Uri.parse(dotenv.env['BACKEND_SITE_ADD_PLAYER']!),
                    headers: {
                      'Content-Type': 'application/json',
                    },
                    body: jsonEncode(data)
                  );
                  if (httpResponse.statusCode == 200){
                    Fluttertoast.showToast(msg: "$name has been added");
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: "Error. Please try again, or add a different name");
                  }
                }
              },
              child: Text('Proceed')
            ),
            TextButton(
              onPressed: (){
                Fluttertoast.showToast(msg: "Cancelled");
                Navigator.pop(context);
              },
              child: const Text('Cancel')
            ),
          ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text('Add Player', style: TextStyle(color: Colors.grey[500]),),
      )
    );
  }
}