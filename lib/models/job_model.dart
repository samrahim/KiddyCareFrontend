class JobModel {
  int? id;
  int? parentId;
  String? descreption;
  int? children;
  DateTime? date;
  String? startTime;
  String? endTime;
  int? minPriceForHoure;
  int? maxPriceForHoure;
  int? sitterId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? familleName;
  String? familleImagePath;

  JobModel(
      {this.id,
      this.familleName,
      this.familleImagePath,
      this.parentId,
      this.descreption,
      this.children,
      this.date,
      this.startTime,
      this.endTime,
      this.minPriceForHoure,
      this.maxPriceForHoure,
      this.sitterId,
      this.createdAt,
      this.updatedAt});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_Id'];
    descreption = json['descreption'];
    children = json['children'];
    date = DateTime.parse(json['date']);
    startTime = json['startTime'];
    endTime = json['endTime'];
    minPriceForHoure = json['minPriceForHoure'];
    maxPriceForHoure = json['maxPriceForHoure'];
    sitterId = json['sitter_Id'];
    familleName = json['Famille']["familleName"];
    familleImagePath = json['Famille']["familleImagePath"];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
  }
}
