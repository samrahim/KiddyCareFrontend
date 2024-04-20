class FamilleModel {
  int? id;
  final String familleName;
  dynamic famillePhone;
  final String famillePassword;
  dynamic familleEmail;
  final String familleFcmToken;
  final String familleAdress;
  dynamic familleImagePath;

  FamilleModel({
    this.id,
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
        id: map['id'],
        famillePassword: map['famillePassword'],
        familleName: map['familleName'],
        famillePhone: map['famillePhone'],
        familleFcmToken: map['familleFcmToken'],
        familleEmail: map['familleEmail'],
        familleImagePath: map['familleImagePath'],
        familleAdress: map['familleAdress']);
  }
}
