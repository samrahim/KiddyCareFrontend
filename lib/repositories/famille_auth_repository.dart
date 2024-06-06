// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:babysitter/models/famille.model.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class FamilleAuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> regiterWithPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(String, int?) codeSent,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String) codeAutoretivalTimout,
  }) async {
    await auth.verifyPhoneNumber(
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: codeAutoretivalTimout);
  }

  Future<String> registerfamille(FamilleModel familleModel) async {
    final response = await http.post(Uri.parse("$baseUrl/famille/register"),
        body: familleModel.familleEmail == ""
            ? json.encode({
                "familleName": familleModel.familleName,
                "famillePhone": familleModel.famillePhone,
                "famillePassword": familleModel.famillePassword,
                "familleFcmToken": familleModel.familleFcmToken,
              })
            : json.encode({
                "familleName": familleModel.familleName,
                "famillePassword": familleModel.famillePassword,
                "familleFcmToken": familleModel.familleFcmToken,
                "familleEmail": familleModel.familleEmail
              }),
        headers: {'Content-Type': 'application/json'},
        encoding: Encoding.getByName('utf-8'));

    return response.body;
  }

  Future<String> login(String? famillePhone, String? familleemail,
      {required String famillePassword}) async {
    final body = famillePhone!.isEmpty
        ? {
            "familleEmail": familleemail,
            "famillePassword": famillePassword,
          }
        : {
            "famillePhone": famillePhone,
            "famillePassword": famillePassword,
          };
    final response = await http.post(Uri.parse("$baseUrl/famille/login"),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
        encoding: Encoding.getByName('utf-8'));

    return response.body;
  }

  Future<StreamedResponse> uploadFileAndUpdateParentInfo({
    required int parentId,
    required String defaultAddress,
    required String latitude,
    required String longitude,
    required XFile? image,
  }) async {
    if (image != null) {
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$baseUrl/famille/updateinfo/$parentId"));
      request.fields['familleAdress'] = defaultAddress;
      request.fields['familleLatitude'] = latitude.toString();
      request.fields['familleLongitude'] = longitude.toString();
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        image.path,
      ));

      var response = await request.send();

      return response;
    } else {
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$baseUrl/famille/updateinfo/$parentId"));
      request.fields['familleAdress'] = defaultAddress;
      var response = await request.send();

      return response;
    }
  }
}
