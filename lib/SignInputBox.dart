import "dart:async";
import "index.dart";

import "package:flutter/material.dart";

class SignInputBox extends StatelessWidget {
  var labelText;
  var hintText;
  var obscureText = true;
  var controller;
  var formkey;
  FocusNode _focusNode = FocusNode();

  SignInputBox({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.formkey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            focusNode: _focusNode,
            controller: controller,
            validator: (value) {
              print("testing!");
              if (controller.text == "") {
                return "";
              }
              ;
              var userAuth = Account().testToken();

              print(formkey.toString());

              if (userAuth != "User Authenticated" || userAuth == null &&
                  formkey.toString() == 'Username') {
                return "Username or password is invalid!";
              }
              if (userAuth != "User Authenticated" || userAuth == null &&
                  formkey.toString() == 'Password') {
                return "";
              }

              if (userAuth != "User Authenticated" || userAuth == null &&
                  formkey.toString() == 'SignUpUsername') {
                return "";
              }
              if (userAuth != "User Authenticated" || userAuth == null &&
                  formkey.toString() == 'SignUpEmail') {
                return "";
              }
              if (userAuth == "Confirmation password not valid" || userAuth == null &&
                  formkey.toString() == 'SignUpPass') {
                return "";
              }
              if (userAuth == "Confirmation password not valid" || userAuth == null &&
                  formkey.toString() == 'SignUpConPass') {
                return "your confirmation password doesn't match your passowrd";
              }
              if (userAuth == null &&
                  formkey.toString() == 'SignUpConPass') {
                return "your confirmation password doesn't match your passowrd";
              } else
                return null;
            },
            decoration: InputDecoration(
              suffixIcon: formkey.toString().contains("Password") ||
                      formkey.toString().contains("SignUpPass") == true
                  ? IconButton(
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .switchObsecure();
                      },
                      icon: Provider.of<ChatProvider>(context, listen: true)
                                  .obsecure ==
                              true
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off_sharp))
                  : SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              labelText: labelText,
              hintText: hintText,
              labelStyle: TextStyle(
                fontSize: 15,
              ),
            ),
            obscureText: formkey.toString().contains("Password") ||
                    formkey.toString().contains("SignUpConPass") ||
                    formkey.toString().contains("SignUpPass") == true
                ? Provider.of<ChatProvider>(context, listen: true).obsecure
                : false,
          ),
        ],
      ),
    );
  }
}
