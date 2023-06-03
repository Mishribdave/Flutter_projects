class UserModel {
  int? id;
  String? name;
  String? contact;

  UserModelMap() {
    var mapping = Map<String, dynamic>();

    mapping["id"] = id;
    mapping["name"] = name;
    mapping["contact"] = contact;
    return mapping;
  }
}
