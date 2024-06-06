import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<XFile?> compressedimage({required XFile? oldFile}) async {
  if (oldFile != null) {
    final newImage = await FlutterImageCompress.compressAndGetFile(
        oldFile.path, "${oldFile.path}compressed.jpg",
        quality: 30);
    return newImage;
  } else {
    return null;
  }
}
