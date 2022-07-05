class orders {
  List<Cart>? cart;
  Sales? sales;

  orders({this.cart, this.sales});

  orders.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    sales = json['sales'] != null ? new Sales.fromJson(json['sales']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    if (this.sales != null) {
      data['sales'] = this.sales!.toJson();
    }
    return data;
  }
}

class Cart {
  String? productId;
  String? saleRate;
  String? purchaseRate;
  String? quantity;
  String? total;
  String? status;

  Cart(
      {this.productId,
      this.saleRate,
      this.purchaseRate,
      this.quantity,
      this.total,
      this.status});

  Cart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    saleRate = json['sale_rate'];
    purchaseRate = json['purchase_rate'];
    quantity = json['quantity'];
    total = json['total'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['sale_rate'] = this.saleRate;
    data['purchase_rate'] = this.purchaseRate;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['status'] = this.status;
    return data;
  }
}

class Sales {
  String? customerId;
  String? orderDate;
  String? status;
  String? note;
  String? subtotal;
  String? branchId;

  Sales(
      {this.customerId,
      this.orderDate,
      this.status,
      this.note,
      this.subtotal,
      this.branchId});

  Sales.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    orderDate = json['order_date'];
    status = json['status'];
    note = json['note'];
    subtotal = json['subtotal'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['order_date'] = this.orderDate;
    data['status'] = this.status;
    data['note'] = this.note;
    data['subtotal'] = this.subtotal;
    data['branch_id'] = this.branchId;
    return data;
  }
}
