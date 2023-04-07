import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcaninno/dilog.dart';
import 'package:testcaninno/pages/mainpage.dart';
import 'package:testcaninno/style/constant_color.dart';
import 'package:testcaninno/style/constant_textstyle.dart';

import '../style/constant_background.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneNumberController = TextEditingController();
  bool statusRedEys = true;
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant_Color().green,
        //  elevation: 1,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: Container(
          decoration: Constant_Background().background(),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              buildTextFormField(
                usernameController,
                "username",
              ),
              buildTextFormField(passwordController, "password",
                  password: true),
              buildTextFormField(confirmPasswordController, "confirm password",
                  password: true),
              nameAndLastnameInput(),
              inputBirthDay(context),
              buildTextFormField(emailController, "email",
                  type: TextInputType.emailAddress),
              buildTextFormField(telephoneNumberController, "phone",
                  type: TextInputType.phone),
              buttonRegister(size)
            ],
          ),
        ),
      ),
    );
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _register() async {
    final SharedPreferences prefs = await _prefs;
    List<String> data = [];
    if (prefs.containsKey(usernameController.text)) {
      MyDialog().normalDialog(context, "username ซ้ำ");
    } else {
      data = [
        passwordController.text,
        "${nameController.text} ${lastNameController.text}",
        "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
        emailController.text,
        telephoneNumberController.text
      ];
      prefs.setStringList(usernameController.text, data);
      prefs.setStringList("autologin", data);
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

  Container buttonRegister(double size) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: size * 0.2, right: size * 0.2),
      child: ElevatedButton(
        onPressed: () {
          if (_selectedDate == null ||
              usernameController.text == "" ||
              passwordController.text == "" ||
              confirmPasswordController.text == "" ||
              nameController.text == "" ||
              lastNameController.text == "" ||
              emailController.text == "" ||
              telephoneNumberController.text == "") {
            MyDialog().normalDialog(context, "กรุณากรอกข้อมูลให้ครบ");
          } else if (passwordController.text !=
              confirmPasswordController.text) {
            MyDialog().normalDialog(context, "รหัสผ่านไม่เหมือนกัน");
          } else if (telephoneNumberController.text.length != 10) {
            MyDialog().normalDialog(context, "เบอร์โทรศัพท์ต้องมี 10 หลัก");
          } else {
            //register
            _register();
          }
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Constant_Color().red),
        child: const Center(
          child: Text(
            "Register",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Row inputBirthDay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _selectedDate == null
              ? "XX/XX/XXXX"
              : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
          style: Constant_TextStyle().text(),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () => selectDate(context),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Constant_Color().greenLight),
          child: const Text(
            "เลือกวันเกิด",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate!,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Row nameAndLastnameInput() {
    return Row(
      children: [
        Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: 7, bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 60,
                child: TextFormField(
                  controller: nameController,
                  style: Constant_TextStyle().text(),
                  decoration: const InputDecoration(
                    labelText: "name",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ))),
        Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: 7, bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 55,
                child: TextFormField(
                  controller: lastNameController,
                  style: Constant_TextStyle().text(),
                  decoration: const InputDecoration(
                    labelText: "lastname",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                )))
      ],
    );
  }

  Widget buildTextFormField(TextEditingController controller, String labelText,
      {TextInputType type = TextInputType.text, bool password = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: type == TextInputType.phone ? 75 : 55,
      margin: const EdgeInsets.only(top: 7, bottom: 5),
      child: TextFormField(
        maxLength: type == TextInputType.phone ? 10 : null,
        keyboardType: type,
        controller: controller,
        style: Constant_TextStyle().text(),
        obscureText: password ? statusRedEys : false,
        validator: (value) {
          if (value!.isEmpty) {
            return "Required";
          } else if (type == TextInputType.phone && value.length != 10) {
            return "Langth 10 Required";
          } else if (password == true &&
              passwordController.text != confirmPasswordController.text) {
            return "code mismatch";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.white),
            suffixIcon: password
                ? IconButton(
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
                  )
                : null),
      ),
    );
  }
}
