import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/product_component/product_service/product_service.dart';
import 'package:sport_center_project/Screens/profile/profile_services/profile_services.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:uuid/uuid.dart';

class AddProductsScreen extends StatefulWidget {
  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  // const AddProductsScreen({Key? key}) : super(key: key);
  TextEditingController productName = TextEditingController();

  TextEditingController productPrice = TextEditingController();

  TextEditingController productDescription = TextEditingController();

  File? imageFile;

  ImagePicker picker = ImagePicker();

  final ProductService postService = ProductService();

  bool selectImageColor = false;
  String selectedImageUrl = '';
  bool selectFileColor = false;

  final ProfileService _filesUploadService = ProfileService();
  Future<void> add_Products(ProductsModel model) async {
    await postService.addProduct(model);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add Products',
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF030A59),
                  Color(0xFF121879),
                  Color(0xFF2931A8),
                ],
                begin: AlignmentDirectional.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  defaultLoginFormField(controller: productName,
                      type: TextInputType.text,
                      labelText: 'Product Name',
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter email address!';
                        }
                        return null;
                      },
                      prefix: Icons.inbox),
                  SizedBox(
                    height: 10,
                  ),
                  defaultLoginFormField(
                      controller: productPrice,
                      type: TextInputType.text,
                      labelText: 'Product Price',
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter email address!';
                        }
                        return null;
                      },
                      prefix: Icons.price_change),
                  SizedBox(
                    height: 10,
                  ),
                  defaultLoginFormField(
                      controller: productDescription,
                      type: TextInputType.text,
                      labelText: 'Product Description',
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter email address!';
                        }
                        return null;
                      },
                      prefix: Icons.description),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await chooseSubjectImage(ImageSource.camera);
                            if (imageFile != null) {
                              selectedImageUrl = await _filesUploadService
                                  .fileUpload(imageFile!, 'UsersImage')
                                  .whenComplete(() {
                                setState(() {
                                  selectImageColor = !selectImageColor;
                                });
                              });
                            }
                          },
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.blueGrey.shade900.withOpacity(1),
                          )),
                      TextButton(
                        onPressed: () async {
                          await chooseSubjectImage(ImageSource.gallery);
                          if (imageFile != null) {
                            selectedImageUrl = await _filesUploadService
                                .fileUpload(imageFile!, 'UsersImage')
                                .whenComplete(() {
                              setState(() {
                                selectImageColor = !selectImageColor;
                              });
                            });
                          }
                        },
                        child: Text(
                          "Select Image",
                          style: TextStyle(
                              color: Colors.blueGrey.shade700.withOpacity(1)),
                        ),
                      ),
                      SizedBox(
                        width: 190,
                      ),
                      Icon(
                        selectImageColor == false
                            ? Icons.check_circle_outline
                            : Icons.check_circle,
                        color: Colors.blueGrey.shade900.withOpacity(1),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  defaultLoginButton(
                    radius: 8.0,
                      fontSize: 18,
                      backround: Color(0xFD040842),
                      function: () async {
                        var id = Uuid().v4();
                        var model = ProductsModel(
                            productId: id,
                            name: productName.text,
                            price: productPrice.text,
                            description: productDescription.text,
                            // time: Timestamp.now(),
                            image: selectedImageUrl);
                        if (productDescription.text == '') {
                          Fluttertoast.showToast(msg: 'Fill the description');
                        } else {
                          await add_Products(model)
                              .whenComplete(() {
                            navigators.navigatorWithBack(context, MainNavigationBar());
                          });
                          showToast(text: 'Product Added Successfully', state: ToastStates.Success);
                        }
                      },
                      text: "Add product")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseSubjectImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile!.path.isEmpty) {
      retrieveLostData();
    } else {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.file != null) {
      setState(() {
        imageFile = File(response.file!.path);
      });
    } else {
      // log('response.file : ${response.file}');
    }
  }
}
