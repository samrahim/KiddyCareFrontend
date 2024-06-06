import 'package:babysitter/blocs/parentauthbloc/auth_bloc.dart';
import 'package:babysitter/repositories/shared_pref_repositrory.dart';
import 'package:babysitter/screens/parent_screens/parent_init_layout.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentLogin extends StatefulWidget {
  const ParentLogin({super.key});

  @override
  State<ParentLogin> createState() => ParentLoginState();
}

class ParentLoginState extends State<ParentLogin> {
  SharedRepo repo = SharedRepo();
  TextEditingController parentPhoneOrEmail = TextEditingController();
  TextEditingController parentPassword = TextEditingController();

  bool secure = true;
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
                    "Parent Register",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: parentPhoneOrEmail,
                      validator: (value) {
                        if (value == null) {
                          return "please validate phone number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.phone_android),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: "phone number or email"),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: parentPassword,
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
                  const SizedBox(height: 48),
                  BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                LoginEventTest(
                                    parentEmail: EmailValidator.validate(
                                            parentPhoneOrEmail.text)
                                        ? parentPhoneOrEmail.text
                                        : "",
                                    parentPhone: !EmailValidator.validate(
                                            parentPhoneOrEmail.text)
                                        ? parentPhoneOrEmail.text
                                        : "",
                                    parentPassword: parentPassword.text));
                          },
                          child: const Text("Login"));
                    },
                    listener: (context, state) {
                      if (state is PhoneAuthScreenLoaded) {
                        repo.setIdAndType(userType: "Parent", id: state.id);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParentInitLayout(
                                      id: state.id,
                                    )));
                      } else if (state is AuthInValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.err.toString())));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
