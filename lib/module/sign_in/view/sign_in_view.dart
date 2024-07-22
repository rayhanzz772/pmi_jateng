
  import 'package:flutter/material.dart';
  import '../controller/sign_in_controller.dart';
  import 'package:pmi_jateng/core.dart';
  import 'package:get/get.dart';
  
  class SignInView extends StatelessWidget {
    const SignInView({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) {
          controller.view = this;
  
          return Scaffold(
            appBar: AppBar(
              title: const Text("SignIn"),
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
    