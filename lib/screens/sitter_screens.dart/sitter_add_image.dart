import 'dart:io';
import 'package:babysitter/blocs/sitterauthbloc/sitterauthbloc_bloc.dart';
import 'package:babysitter/screens/sitter_screens.dart/update_sitter_bio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class SitterImageAndAdress extends StatefulWidget {
  final int sitterId;
  const SitterImageAndAdress({
    super.key,
    required this.sitterId,
  });

  @override
  State<SitterImageAndAdress> createState() => _SitterImageAndAdressState();
}

class _SitterImageAndAdressState extends State<SitterImageAndAdress> {
  String defaultAdrees = '';
  XFile? img;
  Future<XFile?> pickimg(ImageSource source) async {
    return await ImagePicker().pickImage(source: source);
  }

  String latitude = '';
  String longitude = '';

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  _getLocation() async {
    try {
      await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      List<Placemark> placesMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placesMarks);
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });

      if (placesMarks.isNotEmpty) {
        String address = '';
        for (Placemark placemark in placesMarks) {
          if (placemark.thoroughfare != null &&
              placemark.thoroughfare!.isNotEmpty) {
            setState(() {
              address = placemark.thoroughfare!;
            });
            break;
          }
        }

        setState(() {
          defaultAdrees = address.isNotEmpty ? address : "Address not found";
        });
      } else {
        setState(() {
          defaultAdrees = "Location not found";
        });
      }
    } catch (e) {
      setState(() {
        defaultAdrees = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                  BlocProvider.of<SitterauthblocBloc>(context).add(
                      UpdateSitterImgAndLoc(
                          latitude: latitude,
                          longitude: longitude,
                          sitterId: widget.sitterId,
                          sitterimg: img,
                          sitteradress: defaultAdrees));
                },
                child: const Text("save")),
            BlocListener<SitterauthblocBloc, SitterauthblocState>(
              listener: (context, state) {
                if (state is UpdateSitterBioScreenLoaded) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UpdateBio(
                                sitterId: widget.sitterId,
                              )));
                }
              },
              child: const SizedBox(),
            ),
          ],
        ),
      )),
    );
  }
}
