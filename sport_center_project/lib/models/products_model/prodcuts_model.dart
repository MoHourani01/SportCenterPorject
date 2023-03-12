class ProductModel{
  final String productName;
  final String productImage;
  final String productPrice;



  ProductModel( {required this.productName,required this.productImage,required this.productPrice});
}
//=============================================================================
class Data {
  static List<ProductModel> item = [
    ProductModel(
        productName: 'Statue',
        productImage: 'assets/images/Soccer.jpg',
        productPrice:"10"
    ),
    ProductModel(
        productName: 'Tea pot',
        productImage: 'assets/images/basketball.jpg',
        productPrice:"23"
    ),
    ProductModel(
        productName: 'Statue',
        productImage: 'assets/images/Soccer.jpg',
        productPrice:"10"
    ),
    ProductModel(
        productName: 'Tea pot',
        productImage: 'assets/images/basketball.jpg',
        productPrice:"23"
    ),
  ];
}

