class SitterModel {
  int? id;
  final String sitterName;
  String? sitterPhone;
  String? sitterPassword;
  final String sitterEmail;
  final String sitterFcmToken;
  String? sitterImagePath;
  SitterModel(
      {this.id,
      required this.sitterName,
      required this.sitterPhone,
      required this.sitterPassword,
      required this.sitterFcmToken,
      required this.sitterEmail,
      required this.sitterImagePath});
  factory SitterModel.fromJson(Map<String, dynamic> map) {
    return SitterModel(
        id: map['id'],
        sitterPassword: map['sitterPassword'],
        sitterName: map['sitterName'],
        sitterPhone: map['sitterPhoneOrPassword'],
        sitterFcmToken: map['sitterFcmToken'],
        sitterEmail: map['sitterEmail'],
        sitterImagePath: map['sitterImagePath']);
  }
}
