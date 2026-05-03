// class NoteModel {
//   final String title;
//   final String body;
//   final DateTime dateTime;

//   NoteModel({required this.title, required this.body, required this.dateTime});

//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "body": body,
//     "dateTime": dateTime.toIso8601String(),
//   };

//   factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
//     title: json["title"] as String,
//     body: json["body"] as String,
//     dateTime: DateTime.parse(json["dateTime"] as String),
//   );
// }
