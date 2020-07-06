
class TaskModel {
  String header;
  String content;
  String dateTime;
  String uuid;
  bool isDone;

  TaskModel({this.header, this.content, this.dateTime,this.uuid,this.isDone});

  TaskModel.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    content = json['content'];
    dateTime = json['dateTime'];
    uuid = json['uuid'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['content'] = this.content;
    data['dateTime'] = this.dateTime;
    data['uuid'] = this.uuid;
    data['isDone'] = this.isDone;
    return data;
  }
}
