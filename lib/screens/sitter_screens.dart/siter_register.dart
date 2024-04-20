import 'package:babysitter/blocs/sitterauthbloc/sitterauthbloc_bloc.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_login.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_verify_otp_screen.dart';
import 'package:babysitter/widgets/container_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SiterRegister extends StatefulWidget {
  const SiterRegister({super.key});

  @override
  State<SiterRegister> createState() => _SiterRegisterState();
}

class _SiterRegisterState extends State<SiterRegister> {
  TextEditingController sitterpassword = TextEditingController();
  TextEditingController sitterpasswordTwo = TextEditingController();
  TextEditingController sitterName = TextEditingController();
  TextEditingController sitterphoneNumberOrEmail = TextEditingController();
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                          "Sitter Register",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        UserInput(
                          controller: sitterName,
                          isPassword: false,
                          hintText: "sitter name",
                          icon: Icons.person,
                          validator: (p0) {
                            if (p0 == null || p0.length < 4) {
                              return "please the value should be more than 4 char";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        UserInput(
                          controller: sitterphoneNumberOrEmail,
                          isPassword: false,
                          hintText: "email or phone number",
                          icon: Icons.email,
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
                            controller: sitterpassword,
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
                          controller: sitterpasswordTwo,
                          isPassword: true,
                          hintText: "verify password",
                          icon: Icons.password,
                          validator: (p0) {
                            if (p0 != sitterpassword.text) {
                              return "check password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(children: [
                          const Text("Already have account"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SitterLogin()));
                              },
                              child: const Text("Login"))
                        ]),
                        BlocConsumer<SitterauthblocBloc, SitterauthblocState>(
                          builder: (context, state) {
                            if (state is SitterPhoneAuthLoadingState) {
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
                                    color: Colors.indigo.shade300,
                                    borderRadius: BorderRadius.circular(12)),
                                child: InkWell(
                                  onTap: () async {
                                    if (form.currentState!.validate() &&
                                        !EmailValidator.validate(
                                            sitterphoneNumberOrEmail.text)) {
                                      BlocProvider.of<SitterauthblocBloc>(
                                              context)
                                          .add(SitterSendOtpToPhoneNumber(
                                              password: sitterpassword.text,
                                              userName: sitterName.text,
                                              email: "",
                                              phoneNumber:
                                                  '+213${sitterphoneNumberOrEmail.text}'));
                                    } else if (form.currentState!.validate() &&
                                        EmailValidator.validate(
                                            sitterphoneNumberOrEmail.text)) {
                                      BlocProvider.of<SitterauthblocBloc>(
                                              context)
                                          .add(OnPhoneAuhtSuccess(
                                              credential: const AuthCredential(
                                                  providerId: "",
                                                  signInMethod: ""),
                                              email:
                                                  sitterphoneNumberOrEmail.text,
                                              password: sitterpassword.text,
                                              phone: "",
                                              userName: sitterName.text));
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      "register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          listener: (context, state) {
                            if (state is SitterPhoneAuthErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.err)));
                            } else if (state is SitterPhoneAuthCodeSent) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: BlocProvider.of<SitterauthblocBloc>(
                                        context),
                                    child: SitterVerifyOtpScreen(
                                      password: sitterpassword.text,
                                      username: sitterName.text,
                                      phoneNumber:
                                          sitterphoneNumberOrEmail.text,
                                      verificationId: state.verificationId,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ]),
                ),
              ),
            )),
      ),
    ));
  }
}
