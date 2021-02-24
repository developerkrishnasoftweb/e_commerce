class Banners {
  bool status;
  String message;
  List<Data> data;

  Banners({this.status, this.message, this.data});

  Banners.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    } else {
      data = new List<Data>();
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

class Data {
  int id;
  String title;
  String bannerType;
  String linkType;
  String linkUrl;
  String image;
  String status;

  Data({this.id, this.title, this.bannerType, this.linkType, this.linkUrl, this.image, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bannerType = json['banner_type'];
    linkType = json['link_type'];
    linkUrl = json['link_url'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['banner_type'] = this.bannerType;
    data['link_type'] = this.linkType;
    data['link_url'] = this.linkUrl;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
