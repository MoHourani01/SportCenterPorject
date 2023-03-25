class ProductsModel{
  String? price;
  String? image;
  String? name;
  String? productId;
  String? description;
  bool isFavorite = false;

  ProductsModel({
    this.price,
    this.image,
    this.name,
    this.productId,
    this.description,
    bool isFavorite = false,
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

class ProductInfo{
  static List<ProductsModel> products=[
    ProductsModel(
      name: 'Man United Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0002/6440/5057/products/Home1OG.jpg',
    ),
    ProductsModel(
      name: 'Barcelona Jersey',
      price: '50 JD',
      image: 'https://arenajerseys.com/wp-content/uploads/2022/06/download-4.jpg',
    ),
    ProductsModel(
      name: 'RealMadrid Jersey',
      price: '50 JD',
      image: 'https://cdn.shopify.com/s/files/1/0405/9807/7603/products/HF0291-RMCFMZ0074-02_500x480.jpg?v=1655974763',
    ),
    ProductsModel(
      name: 'Miami Heat Jersey',
      price: '60 JD',
      image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fddec8b1-7aee-4b47-826d-f2ec00ad4e66/miami-heat-association-edition-2022-23-dri-fit-nba-swingman-jersey-gLpkQ8.png',
    ),
  ];
}