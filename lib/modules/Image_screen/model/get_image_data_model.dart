class GetImageData {
  String? status;
  List<Images>? images;

  GetImageData({this.status, this.images});

  GetImageData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? xtImage;
  String? id;

  Images({this.xtImage, this.id});

  Images.fromJson(Map<String, dynamic> json) {
    xtImage = json['xt_image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xt_image'] = xtImage;
    data['id'] = id;
    return data;
  }
}
