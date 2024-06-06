class FamilleModel {
  int? familleId;
  final String familleName;
  dynamic famillePhone;
  final String famillePassword;
  dynamic familleEmail;
  final String familleFcmToken;
  final String familleAdress;
  dynamic familleImagePath;
  dynamic familleLatitude;
  dynamic familleLongitude;
  FamilleModel({
    this.familleLatitude,
    this.familleLongitude,
    this.familleId,
    required this.familleName,
    this.famillePhone,
    required this.famillePassword,
    required this.familleFcmToken,
    this.familleEmail,
    this.familleImagePath,
    required this.familleAdress,
  });
  factory FamilleModel.fromJson(Map<String, dynamic> map) {
    return FamilleModel(
        familleLongitude: map['familleLongitude'],
        familleLatitude: map['familleLatitude'],
        familleId: map['familleId'],
        famillePassword: map['famillePassword'],
        familleName: map['familleName'],
        famillePhone: map['famillePhone'],
        familleFcmToken: map['familleFcmToken'],
        familleEmail: map['familleEmail'],
        familleImagePath: map['familleImagePath'],
        familleAdress: map['familleAdress']);
  }
}
