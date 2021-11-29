class TaskModel {
  int? id;
  int? targetId;
  String? title;
  String? start;
  String? finish;
  bool? isFinished;

  TaskModel({
    this.id,
    this.targetId,
    this.title,
    this.start,
    this.finish,
    this.isFinished,
  });

  factory TaskModel.fromDatabaseJson(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'],
      targetId: data['targetId'],
      title: data['title'],
      start: data['start'],
      finish: data['finish'],
      isFinished: data['isFinished'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'targetId': targetId,
      'title': title,
      'start': start,
      'finish': finish,
      'isFinished': isFinished,
    };
  }
}
