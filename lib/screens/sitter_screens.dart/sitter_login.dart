import 'package:babysitter/blocs/sitterauthbloc/sitterauthbloc_bloc.dart';
import 'package:babysitter/repositories/shared_pref_repositrory.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_init_layout.dart';
import 'package:babysitter/widgets/container_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SitterLogin extends StatefulWidget {
  const SitterLogin({super.key});

  @override
  State<SitterLogin> createState() => ParentLoginState();
}

class ParentLoginState extends State<SitterLogin> {
  SharedRepo repo = SharedRepo();
  TextEditingController sitterPhoneOrEmail = TextEditingController();
  TextEditingController sitterPassword = TextEditingController();
  bool secure = true;
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 237, 147, 177),
                Color.fromARGB(255, 248, 116, 160),
                Colors.pink
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                ClipRect(
                  child: Image.asset(
                    "images/Photo.png",
                    height: 100,
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                ),
                const Text(
                  "Sitter Register",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12)),
                //   child: TextFormField(
                //     controller: sitterPhoneOrEmail,
                //     validator: (value) {
                //       if (value == null) {
                //         return "please validate phone number";
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //         suffixIcon: const Icon(Icons.phone_android),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(12)),
                //         hintText: "phone number or email"),
                //   ),
                // ),
                UserInput(
                  controller: sitterPhoneOrEmail,
                  isPassword: false,
                  hintText: "phone number or email",
                  icon: Icons.phone_android,
                  validator: (value) {
                    if (value == null) {
                      return "please validate phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: sitterPassword,
                    validator: (value) {
                      if (value == null || value.length < 10) {
                        return "Weak password";
                      }
                      return null;
                    },
                    obscureText: secure,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                secure = !secure;
                              });
                            },
                            icon: secure
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: "password"),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: remember,
                      onChanged: (newVal) {
                        setState(() {
                          remember = newVal!;
                        });
                      },
                    ),
                    const Text(
                      "remember me",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                BlocConsumer<SitterauthblocBloc, SitterauthblocState>(
                    builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<SitterauthblocBloc>(context).add(
                            SitterLoginEventTest(
                                sitterEmail: EmailValidator.validate(
                                        sitterPhoneOrEmail.text)
                                    ? sitterPhoneOrEmail.text
                                    : "",
                                sitterPhone: !EmailValidator.validate(
                                        sitterPhoneOrEmail.text)
                                    ? sitterPhoneOrEmail.text
                                    : "",
                                sitterPassword: sitterPassword.text));
                      },
                      child: const Text("Login"));
                }, listener: (context, state) {
                  if (state is SitterPhoneAuthScreenLoaded) {
                    remember
                        ? repo.setIdAndType(
                            userType: "Sitter", id: state.model.id!)
                        : null;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SitterInitLayout(
                          id: state.model.id!,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid info")));
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
