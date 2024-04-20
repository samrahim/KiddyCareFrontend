// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:babysitter/models/famille.model.dart';
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

  Future<int> uploadFileAndUpdateParentInfo(
      String baseUrl, int parentId, String defaultAddress, XFile? img) async {
    if (img != null) {
      var stream = http.ByteStream(img.openRead());
      stream.cast();
      var length = await img.length();
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$baseUrl/famille/updateinfo/$parentId"));
      request.fields['familleAdress'] = defaultAddress;
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: img.path.split('/').last);
      request.files.add(multipartFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } else {
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$baseUrl/famille/updateinfo/$parentId"));
      request.fields['familleAdress'] = defaultAddress;
      var response = await request.send();
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    }
  }
}
