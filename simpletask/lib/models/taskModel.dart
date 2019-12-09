class Task {
  String id;
  String name;
  String task;

  Task({this.id, this.name, this.task});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['task'] = this.task;
    return data;
  }
}
