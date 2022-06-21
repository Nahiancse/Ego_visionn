class CategoryModel {
  List<Contents>? contents;

  CategoryModel({this.contents});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? productCategorySlNo;
  String? productCategoryName;

  Contents({this.productCategorySlNo, this.productCategoryName});

  Contents.fromJson(Map<String, dynamic> json) {
    productCategorySlNo = json['ProductCategory_SlNo'];
    productCategoryName = json['ProductCategory_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductCategory_SlNo'] = this.productCategorySlNo;
    data['ProductCategory_Name'] = this.productCategoryName;
    return data;
  }
}
