import 'package:babysitter/blocs/parentauthbloc/auth_bloc.dart';
import 'package:babysitter/screens/parent_screens/parent_image_and%20_adress.dart';
import 'package:babysitter/screens/parent_screens/parent_login_screen.dart';
import 'package:babysitter/screens/parent_screens/verify_otp_screen.dart';
import 'package:babysitter/widgets/container_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentRegister extends StatefulWidget {
  const ParentRegister({super.key});

  @override
  State<ParentRegister> createState() => _ParentRegisterState();
}

class _ParentRegisterState extends State<ParentRegister> {
  TextEditingController parentpassword = TextEditingController();
  TextEditingController parentpasswordTwo = TextEditingController();
  TextEditingController parentName = TextEditingController();
  TextEditingController parentphoneNumberOrEmail = TextEditingController();
  bool secure = true;
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: form,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRect(
                          child: Image.asset(
                            "images/Photo.png",
                            height: 80,
                            width: MediaQuery.of(context).size.width - 20,
                          ),
                        ),
                        const Text(
                          "Parent Register",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        UserInput(
                          controller: parentName,
                          isPassword: false,
                          hintText: "user name",
                          icon: Icons.person,
                          validator: (value) {
                            if (value != null && value.length < 4) {
                              return "please the value should be more than 4 char";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        UserInput(
                          controller: parentphoneNumberOrEmail,
                          isPassword: false,
                          hintText: 'phone number or email',
                          icon: Icons.phone_android,
                          validator: (p0) {
                            if (p0 == null &&
                                (!p0!.startsWith("0") ||
                                    !EmailValidator.validate(p0))) {
                              return "please the entre validate email or phone number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: TextFormField(
                            controller: parentpassword,
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
                        const SizedBox(height: 12),
                        UserInput(
                          controller: parentpasswordTwo,
                          isPassword: true,
                          hintText: "verify password",
                          icon: Icons.password,
                          validator: (p0) {
                            if (p0 == null ||
                                (parentpassword.text !=
                                    parentpasswordTwo.text)) {
                              return "please check yout password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(children: [
                          const Text("Already have account !"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ParentLogin()));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 4, 2, 27)),
                              ))
                        ]),
                        BlocConsumer<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is PhoneAuthLoadingState) {
                              return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(12)),
                                  height: 40,
                                  width: 80,
                                  child: const Center(
                                      child: CircularProgressIndicator()));
                            } else {
                              return Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: InkWell(
                                  onTap: () async {
                                    if (form.currentState!.validate() &&
                                        !EmailValidator.validate(
                                            parentphoneNumberOrEmail.text)) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          SendOtpToPhoneNumber(
                                              password: parentpassword.text,
                                              userName: parentName.text,
                                              email: "",
                                              phoneNumber:
                                                  '+213${parentphoneNumberOrEmail.text}'));
                                    } else if (form.currentState!.validate() &&
                                        EmailValidator.validate(
                                            parentphoneNumberOrEmail.text)) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                        OnPhoneAuhtSuccess(
                                            credential: const AuthCredential(
                                                providerId: "",
                                                signInMethod: ""),
                                            email:
                                                parentphoneNumberOrEmail.text,
                                            password: parentpassword.text,
                                            phone: "",
                                            userName: parentName.text),
                                      );
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      "register",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          listener: (context, state) {
                            if (state is PhoneAuthCodeSent) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: BlocProvider.of<AuthBloc>(context),
                                    child: ParentVerifyOtpScreen(
                                      password: parentpassword.text,
                                      username: parentName.text,
                                      phoneNumber:
                                          parentphoneNumberOrEmail.text,
                                      verificationId: state.verificationId,
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is UpdateScreenLoaded) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ParentImageAndAdress(
                                              parentId: state.parentid)));
                            } else if (state is UserExist) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("User exist")));
                            }
                          },
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
