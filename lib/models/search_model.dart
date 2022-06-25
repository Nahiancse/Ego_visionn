class SearchModel {
  List<Contents>? contents;

  SearchModel({this.contents});

  SearchModel.fromJson(Map<String, dynamic> json) {
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
  String? productSlNo;
  String? productCode;
  String? productName;
  String? productCategoryID;
  String? productPurchaseRate;
  String? productSellingPrice;
  String? image;
  String? unitName;

  Contents(
      {this.productSlNo,
      this.productCode,
      this.productName,
      this.productCategoryID,
      this.productPurchaseRate,
      this.productSellingPrice,
      this.image,
      this.unitName});

  Contents.fromJson(Map<String, dynamic> json) {
    productSlNo = json['Product_SlNo'];
    productCode = json['Product_Code'];
    productName = json['Product_Name'];
    productCategoryID = json['ProductCategory_ID'];
    productPurchaseRate = json['Product_Purchase_Rate'];
    productSellingPrice = json['Product_SellingPrice'];
    image = json['image'];
    unitName = json['Unit_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product_SlNo'] = this.productSlNo;
    data['Product_Code'] = this.productCode;
    data['Product_Name'] = this.productName;
    data['ProductCategory_ID'] = this.productCategoryID;
    data['Product_Purchase_Rate'] = this.productPurchaseRate;
    data['Product_SellingPrice'] = this.productSellingPrice;
    data['image'] = this.image;
    data['Unit_Name'] = this.unitName;
    return data;
  }
}
