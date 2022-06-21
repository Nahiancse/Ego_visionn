class BrandModel {
  List<Contents>? contents;

  BrandModel({this.contents});

  BrandModel.fromJson(Map<String, dynamic> json) {
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
  String? brandSiNo;
  String? productCategorySlNo;
  String? brandName;
  String? status;
  String? brandBranchid;

  Contents(
      {this.brandSiNo,
      this.productCategorySlNo,
      this.brandName,
      this.status,
      this.brandBranchid});

  Contents.fromJson(Map<String, dynamic> json) {
    brandSiNo = json['brand_SiNo'];
    productCategorySlNo = json['ProductCategory_SlNo'];
    brandName = json['brand_name'];
    status = json['status'];
    brandBranchid = json['brand_branchid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_SiNo'] = this.brandSiNo;
    data['ProductCategory_SlNo'] = this.productCategorySlNo;
    data['brand_name'] = this.brandName;
    data['status'] = this.status;
    data['brand_branchid'] = this.brandBranchid;
    return data;
  }
}
