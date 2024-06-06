import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:babysitter/repositories/image_comp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class SitterAuthRepository {
  int sitterId = 0;
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
          "sitterName": sitterModel.sitterName,
          "sitterPhone": sitterModel.sitterPhone,
          "sitterPassword": sitterModel.sitterPassword,
          "sitterFcmToken": sitterModel.sitterFcmToken,
          "sitterEmail": sitterModel.sitterEmail
        }),
        headers: {'Content-Type': 'application/json'},
        encoding: Encoding.getByName('utf-8'));
    sitterId = json.decode(response.body)['sitterId'];
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
    print(response.body);
    return response.body;
  }

  Future<StreamedResponse> sendFrontAndBackId(
      {required int customerId,
      required String frontId,
      required String backId}) async {
    var url = Uri.parse('$baseUrl/onboarding/$customerId/ocr');

    var request = http.MultipartRequest('POST', url);

    request.headers.addAll({
      'accept': 'application/json',
    });

    request.fields['type'] = 'idcard';

    request.files.add(await http.MultipartFile.fromPath('fornt_ID', frontId));
    request.files.add(await http.MultipartFile.fromPath('back_ID', backId));

    final response = await request.send();

    return response;
  }

  Future<int> uploadFileAndUpdateSitterInfo({
    required String baseUrl,
    required int sitterId,
    required String defaultAddress,
    required XFile? image,
    required String latitude,
    required String longitude,
  }) async {
    if (image != null) {
      final img = await compressedimage(oldFile: image);
      var stream = http.ByteStream(img!.openRead());
      stream.cast();
      var length = await img.length();
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$baseUrl/sitter/updateinfo/$sitterId"));
      request.fields['sitterAdress'] = defaultAddress;
      request.fields['sitterLatitude'] = latitude.toString();
      request.fields['sitterLongitude'] = longitude.toString();

      var multipartFile = http.MultipartFile('file', stream, length,
          filename: img.path.split('/').last);
      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);

      return response.statusCode;
    } else {
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$baseUrl/sitter/updateinfo/$sitterId"));
      request.fields['sitterAdress'] = defaultAddress;
      var response = await request.send();
      print(response.statusCode);
      return response.statusCode;
    }
  }

  Future<int> updateBioSitter(
      {required int sitterId,
      required String bio,
      required String sitterExperiance}) async {
    print("func start $sitterId $bio  $sitterExperiance");
    final response = await http.post(
        Uri.parse("$baseUrl/sitter/updatebioandexperiance/$sitterId"),
        body: json
            .encode({"sitterBio": bio, 'sitterExperiance': sitterExperiance}),
        encoding: Encoding.getByName('utf-8'));
    print("res========${response.body}");
    return response.statusCode;
  }
}
