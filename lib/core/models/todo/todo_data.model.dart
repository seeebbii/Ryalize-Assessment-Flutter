class TodoData {
  String? sId;
  String? title;
  bool? completed;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TodoData(
      {this.sId,
        this.title,
        this.completed,
        this.createdAt,
        this.updatedAt,
        this.iV});

  TodoData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    completed = json['completed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['completed'] = completed;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
