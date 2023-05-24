import 'package:flutter/material.dart';
import 'package:sport_center_project/models/product_model.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final List<ProductsModel> items = ProductsModel.soccer_products;
//   List<ProductsModel> filteredItems = [];
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     filteredItems.addAll(items);
//   }
//
//   void filterSearchResults(String query) {
//     if (query.isNotEmpty) {
//       List<ProductsModel> dummyListData = <ProductsModel>[];
//       items.forEach((item) {
//         if (item.name!.toLowerCase().contains(query.toLowerCase())) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         filteredItems.clear();
//         filteredItems.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         filteredItems.clear();
//         filteredItems.addAll(items);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Search Bar Demo"),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 filterSearchResults(value);
//               },
//               controller: searchController,
//               decoration: InputDecoration(
//                   labelText: "Search",
//                   hintText: "Search",
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredItems.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(filteredItems[index].name as String),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


class SearchUtils {
  static List<ProductsModel> filterSearchResults(String query, List<ProductsModel> products) {
    List<ProductsModel> filteredItems = [];
    if (query.isNotEmpty) {
      List<ProductsModel> dummyListData = <ProductsModel>[];
      products.forEach((item) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      filteredItems.addAll(dummyListData);
    } else {
      filteredItems.addAll(products);
    }
    return filteredItems;
  }
}