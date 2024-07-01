part of "objects.dart";

@JsonSerializable()
class StorytellingModel {
  String imageUrl;
  String story;

  StorytellingModel(this.imageUrl, this.story);

  factory StorytellingModel.fromJson(Map<String, dynamic> json) =>
      _$StorytellingModelFromJson(json);

  Map<String, dynamic> toJson() => _$StorytellingModelToJson(this);
}