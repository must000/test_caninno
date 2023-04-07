import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcaninno/dilog.dart';
import 'package:testcaninno/pages/mainpage.dart';
import 'package:testcaninno/pages/registerpage.dart';
import 'package:testcaninno/style/constant_background.dart';
import 'package:testcaninno/style/constant_color.dart';
import 'package:testcaninno/style/constant_textstyle.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool statusRedEys = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> fcLogin() async {
    final SharedPreferences prefs = await _prefs;
    final List<String>? data = prefs.getStringList(userNameController.text);
    if (data != null) {
      if (passwordController.text == data[0]) {
        prefs.setStringList("autologin", data);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                data: data,
              ),
            ),
            (route) => false);
      } else {
        MyDialog().normalDialog(context, "username หรือ password ไม่ถูกต้อง");
      }
    } else {
      MyDialog().normalDialog(context, "username ไม่มีอยู่ในระบบ");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin();
  }

  autoLogin() async {
    final SharedPreferences prefs = await _prefs;
    final List<String>? data = prefs.getStringList("autologin");
    if (data != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              data: data,
            ),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: Container(
              decoration: Constant_Background().background(),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  fielduserNameandpassword(size),
                  buttonLogin(context, size),
                  buttonRegister(context, size)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buttonRegister(BuildContext context, double size) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: size * 0.4, right: size * 0.4),
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ));
          },
          child: Text(
            "Register",
            style: TextStyle(color: Constant_Color().greenLight),
          )),
    );
  }

  Container buttonLogin(BuildContext context, double size) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: size * 0.2, right: size * 0.2),
      child: ElevatedButton(
        onPressed: () {
          if (userNameController.text == "" || passwordController.text == "") {
            MyDialog()
                .normalDialog(context, "กรุณากรอกUsername และ password ให้ครบ");
          } else {
            fcLogin();
          }
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Constant_Color().red),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget fielduserNameandpassword(double size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size * 0.03),
      child: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextFormField(
              controller: userNameController,
              style: Constant_TextStyle().text(),
              decoration: const InputDecoration(
                  labelText: "username",
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextFormField(
              controller: passwordController,
              obscureText: statusRedEys,
              style: Constant_TextStyle().text(),
              decoration: InputDecoration(
                labelText: "password",
                labelStyle: const TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      statusRedEys = !statusRedEys;
                    });
                  },
                  icon: statusRedEys
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
