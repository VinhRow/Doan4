class CategoryModel {
  String? sId;
  String? title;
  String? description;
  String? updatedOn;
  String? createdOn;
  //Loại sản phẩm gồm id, tiêu đề, chi tiết, ngày sửa đổi, ngày thêm
  CategoryModel(
      {this.sId, this.title, this.description, this.updatedOn, this.createdOn});
  //Khởi tạo dữ liệu từ Json
  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }
  //Chuyển dữ liệu thành json và trả dữ liệu về
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
