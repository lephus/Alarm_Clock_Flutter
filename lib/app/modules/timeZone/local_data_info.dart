class LocalDataInfo{
  int id;
  String title;
  int codeNumber;
  String note;
  LocalDataInfo(
      {this.id,
        this.title,
        this.codeNumber,
        this.note,
      });
  factory LocalDataInfo.fromMap(Map<String, dynamic> json) => LocalDataInfo(
      id: json["id"],
      title: json["title"],
      codeNumber:json["codeNumber"],
      note: json["note"]
  );
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "codeNumber": codeNumber,
    "note": note
  };
}