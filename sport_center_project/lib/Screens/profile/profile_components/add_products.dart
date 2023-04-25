import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_center_project/Screens/product_component/product_service/product_service.dart';
import 'package:sport_center_project/Screens/profile/profile_services/profile_services.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:uuid/uuid.dart';

class AddProductBottomSheet extends StatefulWidget {
  const AddProductBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  bool selectImageColor = false;
  String selectedImageUrl = '';
  bool selectFileColor = false;

  final ProfileService _filesUploadService = ProfileService();

  File? imageFile;

  ImagePicker picker = ImagePicker();

  final ProductService postService = ProductService();
  TextEditingController productNameController = TextEditingController();

  TextEditingController productPriceController = TextEditingController();

  TextEditingController productDescriptionController = TextEditingController();
  Future<void> add_Products(ProductsModel model) async {
    await postService.addProduct(model);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: -15,
              child: Container(
                width: 55,
                height: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                defaultLoginFormField(
                  controller: productNameController,
                  type: TextInputType.text,
                  hintText: 'Product Name',
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Product Name';
                    }
                  },
                  prefix: Icons.inbox,
                  // backgroundHintColor: Colors.white,
                  prefixIconColor: Colors.blueGrey,
                  // hintStyleColor: Colors.black26,
                  labelText: 'Product Name',
                  labilStyleColor: Colors.blueGrey,
                ),
                SizedBox(
                  height: 10,
                ),
                defaultLoginFormField(
                  controller: productPriceController,
                  type: TextInputType.text,
                  hintText: 'Product Price',
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Product Price';
                    }
                  },
                  prefix: Icons.price_change_outlined,
                  // backgroundHintColor: Colors.white,
                  prefixIconColor: Colors.blueGrey,
                  // hintStyleColor: Colors.black26,
                  labelText: 'Product Name',
                  labilStyleColor: Colors.blueGrey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          // await chooseSubjectImage(ImageSource.camera);
                          // if (imageFile != null) {
                          //   subjectImageUrl = await _filesUploadService
                          //       .fileUpload(imageFile!, 'UsersImage')
                          //       .whenComplete(() {
                          //     setState(() {
                          //       selectImageColor = !selectImageColor;
                          //     });
                          //   });
                          // }
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
                      width: 200,
                    ),
                    Icon(
                      selectImageColor == false
                          ? Icons.check_circle_outline
                          : Icons.check_circle,
                      color: Colors.blueGrey.shade900.withOpacity(1),
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // DescriptionTextField(
                //   labeltext: 'Description',
                //   hint: 'Description',
                //   controller: productDescriptionController,
                // ),
                SizedBox(
                  height: 10,
                ),
                defaultLoginButton(
                    backround: Colors.blueGrey.shade900.withOpacity(1),
                    function: () async {
                      var id = Uuid().v4();
                      var model = ProductsModel(
                          productId: id,
                          name: productNameController.text,
                          price: productPriceController.text,
                          description: productDescriptionController.text,
                          // time: Timestamp.now(),
                          image: selectedImageUrl);
                      if (productDescriptionController.text == '') {
                        Fluttertoast.showToast(msg: 'Fill the description');
                      } else {
                        await
                            add_Products(model)
                            .whenComplete(() {
                          // mUtils.navigator(context, MainNavigationBar());
                        });
                      }
                    },
                    text: "done")
              ],
            ),
          ),
        ]);
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

//need review
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
