class ProductsModel{
  String? price;
  String? image;
  String? name;
  String? productId;
  String? description;

  ProductsModel({
    this.price,
    this.image,
    this.name,
    this.productId,
    this.description,
  });

  ProductsModel.fromJson(Map<String, dynamic> json){
    price=json['price'];
    image=json['image'];
    name=json['name'];
    productId=json['productId'];
    description=json['description'];
  }

  Map<String, dynamic> toProductMap(){
    return {
      'productId':'',
      'price':price,
      'name':name,
      'image':image,
      'description':description,
    };
  }
}