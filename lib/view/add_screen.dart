import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_task/controller/add_category_controller.dart';
import 'package:hive_task/model/category_model.dart';
import 'package:hive_task/view/style.dart/style.dart';
import 'package:hive_task/view/widgets/glass_model.dart';
import 'package:hive_task/view/widgets/textfom.dart';

// ignore: must_be_immutable
class AddItems extends StatelessWidget {
  AddItems({Key? key, this.categoriModel, this.itemIdex = 0}) : super(key: key);
  int itemIdex;
  CategoryModel? categoriModel;

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discriptionController = TextEditingController();
  final _fomkey = GlobalKey<FormState>();
  final boxs = BoxSingleTon.getInstance();

  @override
  Widget build(BuildContext context) {
    AddCategoriesController controller = Get.put(AddCategoriesController());
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Items",
          style: headLine,
        ),
        elevation: 0,
        backgroundColor: transparent,
      ),
      body: Center(
        child: GlassModel(
          height: height * .6,
          widget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _fomkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  dropdown(),
                  nameField(),
                  priceField(),
                  discriptionField(),
                  ElevatedButton(
                      child: Text(
                        "Submit",
                        style: subLine,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: white,
                          minimumSize: Size(
                            double.infinity,
                            height * .05,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        String? categoryName = controller.categoryValue;

                        bool isValid = _fomkey.currentState!.validate();

                        if (categoryName == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("please select category!!"),
                            ),
                          );
                          return;
                        }

                        if (isValid) {
                          bool isCategoryAlreadyExist = boxs.values.any(
                              (element) =>
                                  element.categoryNamae ==
                                  controller.categoryValue);
                          if (isCategoryAlreadyExist) {
                            print("Category already exist");
                            int categoryIndex = boxs.values.toList().indexWhere(
                                (element) =>
                                    element.categoryNamae == categoryName);

                            List<ProductModel> productModel =
                                boxs.values.toList()[categoryIndex].category;
                            //ALLREDY EXIST CATEGORY UPDATELIST========================================
                            boxs.putAt(
                              categoryIndex,
                              CategoryModel(
                                category: productModel
                                  ..add(
                                    ProductModel(
                                        category: controller.categoryValue!,
                                        name: _nameController.text,
                                        price: _priceController.text,
                                        disctription:
                                            _discriptionController.text),
                                  ),
                                categoryNamae: categoryName,
                              ),
                            );

                            Get.back();
                          } else {
                            //ADD CATEGOTY=========================================================
                            boxs.add(
                              CategoryModel(
                                category: [
                                  ProductModel(
                                      category: controller.categoryValue!,
                                      name: _nameController.text,
                                      price: _priceController.text,
                                      disctription: _discriptionController.text)
                                ],
                                categoryNamae: categoryName,
                              ),
                            );
                          }
                          Get.back();
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//DISCRIPTION========================
  TextForm discriptionField() {
    return TextForm(
        maxline: 5,
        textinputType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "discription minimum  1 length";
          } else {
            return null;
          }
        },
        controller: _discriptionController,
        icons: Icons.description,
        title: "Add a Discription..");
  }

//PRICE=====================================
  TextForm priceField() {
    return TextForm(
        maxline: 1,
        textinputType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter minimum  ₹1";
          } else if (!RegExp(r'[0-9]').hasMatch(value)) {
            return 'Please enter a valid  price';
          } else {
            return null;
          }
        },
        controller: _priceController,
        icons: Icons.currency_rupee_outlined,
        title: "Enter Price");
  }

//NAME=================================
  TextForm nameField() {
    return TextForm(
        maxline: 1,
        textinputType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "Title minimum  1 length";
          } else if (!RegExp(r'(^[a-z A-Z]+$)').hasMatch(value)) {
            return 'Please enter a valid  Title';
          } else {
            return null;
          }
        },
        controller: _nameController,
        icons: Icons.add,
        title: "Enter Name");
  }

//DROPDOWN================================
  GetBuilder<AddCategoriesController> dropdown() {
    return GetBuilder<AddCategoriesController>(dispose: (state) {
      state.controller!.categoryValue = null;
    }, builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: black),
          borderRadius: BorderRadius.circular(10),
          color: white,
        ),
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            menuMaxHeight: 200,
            value: controller.categoryValue,
            hint: const Text("category"),
            items: List.generate(
              controller.categoryItems.length,
              (index) => DropdownMenuItem(
                value: controller.categoryItems[index],
                child: Text(
                  controller.categoryItems[index],
                ),
              ),
            ),
            onChanged: (String? newValue) {
              controller.dropdownChanging(
                newValue!,
              );
            },
          ),
        ),
      );
    });
  }
}
