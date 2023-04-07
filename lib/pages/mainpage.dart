import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcaninno/pages/loginpage.dart';
import 'package:testcaninno/style/constant_background.dart';
import 'package:testcaninno/style/constant_color.dart';

class MainPage extends StatefulWidget {
  List<String> data;
  MainPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState(data: data);
}

class _MainPageState extends State<MainPage> {
  List<String> data;
  _MainPageState({required this.data});
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Constant_Color().green,
        actions: [
          IconButton(
              onPressed: () async {
                final SharedPreferences prefs = await _prefs;
                prefs.remove('autologin');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Loginpage(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        decoration: Constant_Background().background(),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 140,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 130,
                  backgroundImage: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg",
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text(
              data[1],
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            SizedBox(height: 5,),

            Text(
              data[3],
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            SizedBox(height: 5,),

            Text(
              data[2],
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            SizedBox(height: 5,),

            Text(
              data[4],
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
