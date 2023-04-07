import 'package:flutter/material.dart';

class MyDialog{
 normalDialog(context,String text)async{
   await  showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: ListTile(
                  title: Text(text,
                      style: TextStyle(color: Colors.black)),
                ),
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  )
                ],
              ),
            );
 }
}