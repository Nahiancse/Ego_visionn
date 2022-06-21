class ColorModel {
  List<Contents>? contents;

  ColorModel({this.contents});

  ColorModel.fromJson(Map<String, dynamic> json) {
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(new Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contents != null) {
      data['contents'] = this.contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  String? colorSiNo;
  String? colorName;
  String? status;

  Contents({this.colorSiNo, this.colorName, this.status});

  Contents.fromJson(Map<String, dynamic> json) {
    colorSiNo = json['color_SiNo'];
    colorName = json['color_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_SiNo'] = this.colorSiNo;
    data['color_name'] = this.colorName;
    data['status'] = this.status;
    return data;
  }
}
