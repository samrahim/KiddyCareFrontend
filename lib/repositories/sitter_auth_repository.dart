import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SitterAuthRepository {
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

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<String> registerSitter(SitterModel sitterModel) async {
    final response = await http.post(Uri.parse("$baseUrl/sitter/register"),
        body: json.encode({
          "sitterName": sitterModel.sitterEmail,
          "sitterPhone": sitterModel.sitterPhone,
          "sitterPassword": sitterModel.sitterPassword,
          "sitterFcmToken": sitterModel.sitterFcmToken,
          "sitterEmail": sitterModel.sitterEmail
        }),
        headers: {'Content-Type': 'application/json'},
        encoding: Encoding.getByName('utf-8'));
    return response.body;
  }

  Future<String> loginSitter(
      {required String? sitterPhone,
      required String? sitterEmail,
      required String sitterPassword}) async {
    final body = sitterPhone!.isEmpty
        ? {
            "sitterEmail": sitterEmail,
            "sitterPassword": sitterPassword,
          }
        : {
            "sitterPhone": sitterPhone,
            "sitterPassword": sitterPassword,
          };

    final response = await http.post(Uri.parse("$baseUrl/sitter/login"),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
        encoding: Encoding.getByName('utf-8'));

    return response.body;
  }

  Future<int> uploadFileAndUpdateSitterInfo({
    required String baseUrl,
    required int sitterId,
    required String defaultAddress,
    required XFile? img,
  }) async {
    if (img != null) {
      var stream = http.ByteStream(img.openRead());
      stream.cast();
      var length = await img.length();
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$baseUrl/sitter/updateinfo/$sitterId"));
      request.fields['sitterAdress'] = defaultAddress;
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
          "PUT", Uri.parse("$baseUrl/sitter/updateinfo/$sitterId"));
      request.fields['sitterAdress'] = defaultAddress;
      var response = await request.send();
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    }
  }
}
