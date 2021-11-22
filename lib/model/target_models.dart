class TargetModel {
  int? id;
  String? title;
  String? deadline;

  TargetModel({
    this.id,
    this.title,
    this.deadline,
  });

  factory TargetModel.fromDatabaseJson(Map<String, dynamic> data) {
    return TargetModel(
      id: data['id'],
      title: data['title'],
      deadline: data['deadline'],
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'title': title,
      'deadline': deadline,
    };
  }
}

/// {
///   "id": 1,
///   "title": "Flutter",
///   "deadline": "2021-11-20"
/// }
