class NotebookInfo {
  int id;
  String title;
  String description;
  DateTime alarmDateTime;
  int isPending;

  NotebookInfo(
      {this.id,
        this.title,
        this.description,
        this.alarmDateTime,
        this.isPending});

  factory NotebookInfo.fromMap(Map<String, dynamic> json) => NotebookInfo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    alarmDateTime: DateTime.parse(json["alarmDateTime"]),
    isPending: json["isPending"],
  );
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "alarmDateTime": alarmDateTime.toIso8601String(),
    "isPending": isPending,
  };
}