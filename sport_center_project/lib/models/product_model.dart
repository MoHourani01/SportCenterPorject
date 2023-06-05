import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

class ProductsModel{
  String? price;
  String? image;
  String? name;
  String? productId;
  String? description;
  int? quantity=0;
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
      description: 'This is the newest Manchester United jersey season 2023',
    ),
    ProductsModel(
      name: 'Barcelona Jersey',
      price: '50 JD',
      image: 'https://cdn.shoplightspeed.com/shops/611228/files/47811308/1652x1652x1/nike-fc-barcelona-22-23-home-jersey-blue-red.jpg',
      isFavorite: false,
      description: 'This is the newest Barcelona jersey season 2023',
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
      description: 'This is the newest Miami Heat jersey season 2023',
    ),
    ProductsModel(
      name: 'Lakers jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0259/7455/products/WhiteLakersJerseyFrontJames_65028160-284f-4bac-ac73-f76021cdc4d2_1800x1800.png',
      isFavorite: false,
      description: 'This is the newest Lakers jersey season 2023',
    ),
  ];

  static List<ProductsModel> basket_products=[
    ProductsModel(
      name: 'Miami Heat Jersey',
      price: '60 JD',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fddec8b1-7aee-4b47-826d-f2ec00ad4e66/miami-heat-association-edition-2022-23-dri-fit-nba-swingman-jersey-gLpkQ8.png',
      isFavorite: false,
      description: 'This is the newest Miami Heat jersey season 2023',
    ),
    ProductsModel(
      name: 'Lakers jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0259/7455/products/WhiteLakersJerseyFrontJames_65028160-284f-4bac-ac73-f76021cdc4d2_1800x1800.png',
      isFavorite: false,
      description: 'This is the newest Lakers jersey season 2023',
    ),
  ];

  static List<ProductsModel> soccer_products=[
    ProductsModel(
      name: 'Man United Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0002/6440/5057/products/Home1OG.jpg',
      isFavorite: false,
      description: 'This is the newest Manchester United jersey season 2023',
    ),
    ProductsModel(
      name: 'Barcelona Jersey',
      price: '50 JD',
      image: 'https://cdn.shoplightspeed.com/shops/611228/files/47811308/1652x1652x1/nike-fc-barcelona-22-23-home-jersey-blue-red.jpg',
      isFavorite: false,
      description: 'This is the newest Barcelona jersey season 2023',
    ),
    ProductsModel(
      name: 'RealMadrid Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0405/9807/7603/products/HF0291-RMCFMZ0074-02_500x480.jpg?v=1655974763',
      isFavorite: false,
    ),
  ];

  // void addProductIds(List<ProductsModel> products) {
  //   for (var product in products) {
  //     product.productId = Uuid().v4();
  //   }
  // }

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['isFavorite'] = isFavorite;
    data['description'] = description;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;

    return data;
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
// factory ProductsModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   Map<String, dynamic>? data = doc.data();
  //   return ProductsModel(
  //     price: data?['price'] != null ? int.tryParse(data?['price'] ?? '') : null,
  //     image: data?['image'] as String?,
  //     name: data?['name'] as String?,
  //     productId: data?['productId'] as String?,
  //     description: data?['description'] as String?,
  //     quantity: data?['quantity'] != null ? int.tryParse(data?['quantity'] ?? '') : null,
  //     isFavorite: data?['isFavorite'] as bool? ?? false,
  //   );
  // }
  ProductsModel copyWith({bool? isFavorite}) {
    return ProductsModel(
      name: this.name,
      image: this.image,
      price: this.price,
      productId: this.productId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  void addProductFromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Check if the product is already in the list
    final existingProduct = ProductsModel.products.firstWhereOrNull((product) => product.productId == doc.id);
    if (existingProduct != null) {
      // Update the existing product if it's already in the list
      existingProduct
        ..name = data['name']
        ..description = data['description']
        ..image = data['image']
        ..price = data['price']
        ..quantity = data['quantity']
        ..isFavorite = data['isFavorite'] ?? false;
    } else {
      // Add the new product to the list
      final newProduct = ProductsModel(
        name: data['name'],
        description: data['description'],
        image: data['image'],
        price: data['price'],
        quantity: data['quantity'],
        isFavorite: data['isFavorite'] ?? false,
      );
      products.add(newProduct);
    }
  }
}
class ProductsList {
  List<ProductsModel> posts;

  ProductsList({required this.posts});

  factory ProductsList.fromJson(List<dynamic> data) {
    List<ProductsModel> dataList = [];
    dataList = data.map((e) {
      return ProductsModel.fromJson(Map<String, dynamic>.from(e));
    }).toList();
    return ProductsList(posts: dataList);
  }
}