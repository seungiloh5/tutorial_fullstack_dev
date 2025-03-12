import '../shared/global.dart';

class UserModel {
  late int id;
  late String name;
  int? profile;

  get profileUrl =>
      (profile != null) ? "${Global.baseUrl}/file/$profile" : null;

  UserModel({required this.id, required this.name});

  UserModel.parse(Map<String, dynamic>? m) {
    id = m?['id'] ?? 0;
    name = m?['name'] ?? 'Unknown';
    profile = m?['profile_id'];
  }
}
