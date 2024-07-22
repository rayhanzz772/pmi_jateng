
  import 'package:flutter/material.dart';
  import '../controller/sign_up_controller.dart';
  import 'package:pmi_jateng/core.dart';
  import 'package:get/get.dart';
  
  class SignUpView extends StatelessWidget {
    const SignUpView({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          controller.view = this;
  
          return Scaffold(
            appBar: AppBar(
              title: const Text("SignUp"),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: const [],
                ),
              ),
            ),
          );
        },
      );
    }
  }
    