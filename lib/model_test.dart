
import 'dart:convert';

List<ModelTest> modelTestFromMap(String str) => List<ModelTest>.from(json.decode(str).map((x) => ModelTest.fromMap(x)));

String modelTestToMap(List<ModelTest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));


class ModelTest {
  ModelTest({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory ModelTest.fromMap(Map<String, dynamic> json) => ModelTest(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
