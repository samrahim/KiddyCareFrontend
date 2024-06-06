class ImagesPaths {
  String? frontIdPath;
  String? backIdPath;
  ImagesPaths({required this.frontIdPath, required this.backIdPath});
  setfrontId({required String frontIdPath}) {
    this.frontIdPath = frontIdPath;
  }

  setBackId({required String backIdPath}) {
    this.backIdPath = backIdPath;
  }

  getImagesPaths() {
    return ImagesPaths(frontIdPath: frontIdPath, backIdPath: backIdPath);
  }
}
