import 'dart:io';

import 'package:amazon_self/common/custom_button.dart';
import 'package:amazon_self/common/custom_text_field.dart';
import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/constants/utils.dart';
import 'package:amazon_self/features/admin/services/admin_servicres.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionNameController =
      TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();
  final TextEditingController _priceNameController = TextEditingController();
  final TextEditingController _quantityNameController = TextEditingController();
  final AdminServices adminServicres = AdminServices();
  void sellProduct() {
    if (_addProductFormKey.currentState!.validate()&& images.isNotEmpty) {
      adminServicres.sellProduct(
          context: context,
          name: _productNameController.text,
          description: _descriptionNameController.text,
          price: double.parse(_priceNameController.text),
          quantity: double.parse(_quantityNameController.text),
          category: category,
          images: images);
    }
  }

  List<File> images = [];
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String category = 'Mobiles';
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionNameController.dispose();
    _priceNameController.dispose();
    _quantityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text(
            "This is the add product ",
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            //onnly to pass the gradient
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images
                            .map((i) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ))
                            .toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200))
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select product images',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    hintText: "Product name",
                    controller: _productNameController),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Description ",
                  controller: _descriptionNameController,
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hintText: "Price", controller: _priceNameController),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hintText: "Quantity", controller: _quantityNameController),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                      // dropdown menu as web dev takes 2 things, value, child
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(onTap: sellProduct, text: "Sell")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
