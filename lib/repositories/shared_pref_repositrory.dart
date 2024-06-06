import 'package:shared_preferences/shared_preferences.dart';

class SharedRepo {
  Future<SharedPreferences> sharedPre() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    return shared;
  }

  void setIdAndType({required String userType, required int id}) async {
    sharedPre().then((shared) {
      shared.setString("type", userType).then((value) {
        shared.setInt("id", id);
      });
    });
  }

  Future<bool> removeData() async {
    bool bolean = false;
    await sharedPre().then((shared) async {
      final removed = await shared.remove("type").then((value) async {
        await shared.remove("id");
      });
      bolean = removed;
    });
    return bolean;
  }

  Future<Map<String, dynamic>?> getInfo() async {
    final shared = await sharedPre();
    String? type = shared.getString("type");
    int? id = shared.getInt("id");
    if (type != null && id != null) {
      return {"type": type, "id": id};
    } else {
      return null;
    }
  }
}
