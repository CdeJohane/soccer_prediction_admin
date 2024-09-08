import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              onPressed: (){
                String name = nameController.text;
                Fluttertoast.showToast(msg: "$name");
                Navigator.pop(context);
              },
              child: Text('Proceed')
            ),
            TextButton(
              onPressed: (){
                Fluttertoast.showToast(msg: "Cancelled");
                Navigator.pop(context);
              },
              child: Text('Cancel')
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