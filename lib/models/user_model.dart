part of "objects.dart";

@JsonSerializable()
class UserModel {
  String name;
  String email;
  String userId;
  String? password;
  int role;
  bool isDeleted;
  String photoUrl;


  UserModel(this.userId, this.name, this.email, this.password, this.role, this.isDeleted, this.photoUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}