import 'dart:convert';
import 'dart:io';

import 'package:cinemaapp/network/uri_api.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  get http => null;

  Future<void> login() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    try {
      final response = await http.post(
        urlLogin,
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print(responseData);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Đăng nhập không thành công"),
              content: Text("Email hoặc mật khẩu không chính xác."),
              actions: <Widget>[
                TextButton(
                  child: Text("Đóng"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: NetworkImage(
            //     'img',
            //   ),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      'logo',
                      height: 100,
                    ),
                    Text(
                      'Chào mừng!',
                      style: TextStyle(fontSize: 24),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập email';
                        }
                        return null;
                      },
                      onSaved: (value) => email = value!,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Mật khẩu'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                      onSaved: (value) => password = value!,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           ForgotPasswordPage()),
                          // );
                        },
                        child: Text(
                          "Quên mật khẩu?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          login();
                        }
                      },
                      child: Text('Đăng nhập'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
