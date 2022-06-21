class CatwiseProdModel {
  List<Contents>? contents;

  CatwiseProdModel({this.contents});

  CatwiseProdModel.fromJson(Map<String, dynamic> json) {
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
  String? ton;
  String? productCategoryID;
  String? typeId;
  String? color;
  String? brand;
  String? size;
  String? vat;
  String? productReOrederLevel;
  String? productPurchaseRate;
  String? productSellingPrice;
  String? productMinimumSellingPrice;
  String? productWholesaleRate;
  String? oneCartunEqual;
  String? isService;
  String? unitID;
  String? image;
  String? isFuture;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? productBranchid;
  String? productCategoryName;
  String? brandName;
  String? name;

  Contents(
      {this.productSlNo,
      this.productCode,
      this.productName,
      this.ton,
      this.productCategoryID,
      this.typeId,
      this.color,
      this.brand,
      this.size,
      this.vat,
      this.productReOrederLevel,
      this.productPurchaseRate,
      this.productSellingPrice,
      this.productMinimumSellingPrice,
      this.productWholesaleRate,
      this.oneCartunEqual,
      this.isService,
      this.unitID,
      this.image,
      this.isFuture,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.productBranchid,
      this.productCategoryName,
      this.brandName,
      this.name});

  Contents.fromJson(Map<String, dynamic> json) {
    productSlNo = json['Product_SlNo'];
    productCode = json['Product_Code'];
    productName = json['Product_Name'];
    ton = json['ton'];
    productCategoryID = json['ProductCategory_ID'];
    typeId = json['type_id'];
    color = json['color'];
    brand = json['brand'];
    size = json['size'];
    vat = json['vat'];
    productReOrederLevel = json['Product_ReOrederLevel'];
    productPurchaseRate = json['Product_Purchase_Rate'];
    productSellingPrice = json['Product_SellingPrice'];
    productMinimumSellingPrice = json['Product_MinimumSellingPrice'];
    productWholesaleRate = json['Product_WholesaleRate'];
    oneCartunEqual = json['one_cartun_equal'];
    isService = json['is_service'];
    unitID = json['Unit_ID'];
    image = json['image'];
    isFuture = json['is_future'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    productBranchid = json['Product_branchid'];
    productCategoryName = json['ProductCategory_Name'];
    brandName = json['brand_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product_SlNo'] = this.productSlNo;
    data['Product_Code'] = this.productCode;
    data['Product_Name'] = this.productName;
    data['ton'] = this.ton;
    data['ProductCategory_ID'] = this.productCategoryID;
    data['type_id'] = this.typeId;
    data['color'] = this.color;
    data['brand'] = this.brand;
    data['size'] = this.size;
    data['vat'] = this.vat;
    data['Product_ReOrederLevel'] = this.productReOrederLevel;
    data['Product_Purchase_Rate'] = this.productPurchaseRate;
    data['Product_SellingPrice'] = this.productSellingPrice;
    data['Product_MinimumSellingPrice'] = this.productMinimumSellingPrice;
    data['Product_WholesaleRate'] = this.productWholesaleRate;
    data['one_cartun_equal'] = this.oneCartunEqual;
    data['is_service'] = this.isService;
    data['Unit_ID'] = this.unitID;
    data['image'] = this.image;
    data['is_future'] = this.isFuture;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Product_branchid'] = this.productBranchid;
    data['ProductCategory_Name'] = this.productCategoryName;
    data['brand_name'] = this.brandName;
    data['name'] = this.name;
    return data;
  }
}
