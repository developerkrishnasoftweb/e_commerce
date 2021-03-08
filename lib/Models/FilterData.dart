class FiltersData {

  bool status;
  String message;
  List<SubData> data;

  FiltersData({this.status, this.message, this.data});

  FiltersData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<SubData>();
      json['data'].forEach((v) { data.add(new SubData.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubData {
  List<String> option;
 // List<bool> optionSelected;
  List<dynamic> value;

  SubData({this.option, this.value});

  SubData.fromJson(Map<String, dynamic> json) {
    option = json['option'].cast<String>();
   // optionSelected = List();
    if (json['value'] != null) {
      value = new List<dynamic>();
      json['value'].forEach((index, v) {
        if(option[index] == "CATEGORY"){
          value.add(new Value.fromJson(v));
        }else{
          value.add(v);
        }
       // optionSelected.add(false);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option'] = this.option;
    if (this.value != null) {
      data['value'] = this.value.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  int id;
  String name;

  Value({this.id, this.name});

  Value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}