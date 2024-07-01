// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['userId'] as String,
      json['name'] as String,
      json['email'] as String,
      json['password'] as String?,
      json['role'] as int,
      json['isDeleted'] as bool,
      json['photoUrl'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'userId': instance.userId,
      'password': instance.password,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'photoUrl': instance.photoUrl,
    };

StorytellingModel _$StorytellingModelFromJson(Map<String, dynamic> json) =>
    StorytellingModel(
      json['imageUrl'] as String,
      json['story'] as String,
    );

Map<String, dynamic> _$StorytellingModelToJson(StorytellingModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'story': instance.story,
    };
