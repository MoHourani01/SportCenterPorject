import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductsModel{
  String? price;
  String? image;
  String? name;
  String? productId;
  String? description;
  int? quantity;
  bool isFavorite = false;

  ProductsModel({
    this.price,
    this.image,
    this.name,
    this.productId,
    this.description,
    this.quantity,
    bool isFavorite = false,
  }){productId = Uuid().v4();}

  static List<ProductsModel> products=[
    ProductsModel(
      name: 'Man United Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0002/6440/5057/products/Home1OG.jpg',
      isFavorite: false,
    ),
    ProductsModel(
      name: 'Barcelona Jersey',
      price: '50 JD',
      image: 'https://arenajerseys.com/wp-content/uploads/2022/06/download-4.jpg',
      isFavorite: false,
    ),
    ProductsModel(
      name: 'RealMadrid Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0405/9807/7603/products/HF0291-RMCFMZ0074-02_500x480.jpg?v=1655974763',
      isFavorite: false,
    ),
    ProductsModel(
      name: 'Miami Heat Jersey',
      price: '60 JD',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fddec8b1-7aee-4b47-826d-f2ec00ad4e66/miami-heat-association-edition-2022-23-dri-fit-nba-swingman-jersey-gLpkQ8.png',
      isFavorite: false,
    ),
  ];

  void addProductIds(List<ProductsModel> products) {
    for (var product in products) {
      product.productId = Uuid().v4();
    }
  }

  ProductsModel.fromJson(Map<String, dynamic> json){
    price=json['price'];
    image=json['image'];
    name=json['name'];
    productId=json['productId'];
    description=json['description'];
    isFavorite= json['isFavorite'] ?? false;
    quantity=json['quantity'];
  }

  Map<String, dynamic> toProductMap(){
    return {
      'productId':productId,
      'price':price,
      'name':name,
      'image':image,
      'description':description,
      'isFavorite': isFavorite,
      'quantity': quantity,
    };
  }

  factory ProductsModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ProductsModel(
      name: data['name'],
      description: data['description'],
      image: data['image'],
      price: data['price'],
      isFavorite: data['isFavorite'] ?? false,
      productId: doc.id, // Initialize productId field from document id
      quantity:data['quantity'],
    );
  }

  ProductsModel copyWith({bool? isFavorite}) {
    return ProductsModel(
      name: this.name,
      image: this.image,
      price: this.price,
      productId: this.productId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// class ProductInfo{
//   static List<ProductsModel> products=[
//     ProductsModel(
//       name: 'Man United Jersey',
//       price: '50 JD',
//       image: 'https://cdn.shopify.com/s/files/1/0002/6440/5057/products/Home1OG.jpg',
//       isFavorite: false,
//     ),
//     ProductsModel(
//       name: 'Barcelona Jersey',
//       price: '50 JD',
//       image: 'https://arenajerseys.com/wp-content/uploads/2022/06/download-4.jpg',
//       isFavorite: false,
//     ),
//     ProductsModel(
//       name: 'RealMadrid Jersey',
//       price: '50 JD',
//       image: 'https://cdn.shopify.com/s/files/1/0405/9807/7603/products/HF0291-RMCFMZ0074-02_500x480.jpg?v=1655974763',
//       isFavorite: false,
//     ),
//     ProductsModel(
//       name: 'Miami Heat Jersey',
//       price: '60 JD',
//       image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fddec8b1-7aee-4b47-826d-f2ec00ad4e66/miami-heat-association-edition-2022-23-dri-fit-nba-swingman-jersey-gLpkQ8.png',
//       isFavorite: false,
//     ),
//   ];
//
// }