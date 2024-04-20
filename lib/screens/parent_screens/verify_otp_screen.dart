import 'package:babysitter/blocs/parentauthbloc/auth_bloc.dart';
import 'package:babysitter/blocs/sitterauthbloc/sitterauthbloc_bloc.dart';
import 'package:babysitter/screens/parent_screens/parent_image_and%20_adress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class ParentVerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String password;
  final String username;

  const ParentVerifyOtpScreen(
      {super.key,
      required this.verificationId,
      required this.phoneNumber,
      required this.password,
      required this.username});

  @override
  State<ParentVerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<ParentVerifyOtpScreen> {
  late String val;
  @override
  Widget build(BuildContext context) {
    final pinPut = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
          color: Colors.pink.shade300,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.transparent)),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "we send code to",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Text(
              widget.phoneNumber,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 64),
            Container(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: pinPut,
                  focusedPinTheme: pinPut.copyWith(
                    decoration: pinPut.decoration!.copyWith(
                      border: Border.all(color: Colors.green),
                    ),
                  ),
                  onCompleted: (value) {
                    setState(() {
                      val = value;
                    });
                  },
                )),
            const SizedBox(height: 64),
            BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade300),
                  onPressed: () {
                    context.read<AuthBloc>().add(VerifyOtp(
                        password: widget.password,
                        phoneNumber: widget.phoneNumber,
                        userName: widget.username,
                        otp: val,
                        email: '',
                        verificationId: widget.verificationId));
                  },
                  child: const Text("Verify Code"));
            }, listener: (context, state) {
              if (state is UpdateScreenLoaded) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParentImageAndAdress(
                              parentId: state.parentid,
                            )));
              } else if (state is PhoneAuthErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.err)));
              } else if (state is SitterUserExist) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("this user has beed registred")));
              }
            })
          ],
        ),
      ),
    );
  }
}
