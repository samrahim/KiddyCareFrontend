import 'dart:io';
import 'package:babysitter/blocs/parentauthbloc/auth_bloc.dart';
import 'package:babysitter/screens/parent_screens/parent_login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ParentImageAndAdress extends StatefulWidget {
  final int parentId;
  const ParentImageAndAdress({
    super.key,
    required this.parentId,
  });

  @override
  State<ParentImageAndAdress> createState() => _ParentImageAndAdressState();
}

class _ParentImageAndAdressState extends State<ParentImageAndAdress> {
  String defaultAdrees = "Batna";
  XFile? img;
  Future<XFile?> pickimg(ImageSource source) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            DropdownButton(
              value: defaultAdrees,
              onChanged: (newValue) {
                setState(() {
                  defaultAdrees = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(value: "Batna", child: Text("Batna")),
                DropdownMenuItem(value: "alger", child: Text("alger")),
                DropdownMenuItem(value: "const", child: Text("const")),
                DropdownMenuItem(value: "annaba", child: Text("annaba")),
                DropdownMenuItem(value: "oran", child: Text("oran")),
                DropdownMenuItem(value: "setif", child: Text("setif")),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: img == null
                    ? Image.asset("images/download.jpg")
                    : Image.file(File(img!.path)),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Pick from !"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  final f = await pickimg(ImageSource.camera);
                                  setState(() {
                                    img = f;
                                  });
                                },
                                child: const Text("Camera")),
                            TextButton(
                                onPressed: () async {
                                  final f = await pickimg(ImageSource.gallery);
                                  setState(() {
                                    img = f;
                                  });
                                },
                                child: const Text("Callery"))
                          ],
                        );
                      });
                },
                child: const Text("Add Image")),
            ElevatedButton(
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(UpdateParentInfo(
                      parentId: widget.parentId,
                      img: img,
                      adress: defaultAdrees));
                },
                child: const Text("save")),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is UpdatingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox();
                }
              },
              listener: (context, state) {
                if (state is LoginScreenLoaded) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const ParentLogin()));
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
