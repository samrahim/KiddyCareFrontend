class SitterModel {
  int? sitterId;
  final String sitterName;
  String? sitterPhone;
  String? sitterPassword;
  String? sitterEmail;
  final String sitterFcmToken;
  String? sitterImagePath;
  String? sitterBio;
  bool? sitterStatus;
  double? averageRating;
  String? sitterAddress;
  String? sitterExperiance;
  dynamic sitterLatitude;
  dynamic sitterLongitude;
  SitterModel(
      {this.sitterId,
      this.sitterAddress,
      this.sitterBio,
      this.sitterLatitude,
      this.sitterLongitude,
      this.sitterStatus,
      this.sitterExperiance,
      required this.sitterName,
      required this.sitterPhone,
      required this.sitterPassword,
      required this.sitterFcmToken,
      required this.sitterEmail,
      this.averageRating,
      required this.sitterImagePath});
  factory SitterModel.fromJson(Map<String, dynamic> map) {
    return SitterModel(
        sitterId: map['sitterId'],
        sitterAddress: map['sitterAdress'],
        sitterBio: map["sitterBio"],
        sitterStatus: map['sitterStatus'],
        sitterPassword: map['sitterPassword'],
        sitterName: map['sitterName'],
        averageRating: (map['averageRating'] + 0.0 ?? 0.0),
        sitterPhone: map['sitterPhoneOrPassword'],
        sitterFcmToken: map['sitterFcmToken'],
        sitterExperiance: map['sitterExperiance'],
        sitterEmail: map['sitterEmail'],
        sitterImagePath: map['sitterImagePath']);
  }
}
