//Lớp Sản phẩm gồm: id, loại sản phẩm, tiêu đề, chi tiết sản phẩm, giá, hình ảnh, ngày cập nhật, ngày tạo.
class ProductModel {
  String? sId;
  String? category;
  String? title;
  String? description;
  int? price;
  List<String>? images;
  String? updatedOn;
  String? createdOn;

  ProductModel(
      {this.sId,
      this.category,
      this.title,
      this.description,
      this.price,
      this.images,
      this.updatedOn,
      this.createdOn});
// khởi tạo dữ liệu từ json
  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }
  //chuyển dữ liệu thành json và trả dữ liệu về
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
