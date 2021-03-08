
class Value {
  int id;
  String name;
  bool isSelected;

  Value({this.id, this.name});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}