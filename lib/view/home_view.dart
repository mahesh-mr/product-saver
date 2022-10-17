import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_task/controller/add_category_controller.dart';
import 'package:hive_task/controller/image.dart';
import 'package:hive_task/model/category_model.dart';
import 'package:hive_task/view/add_screen.dart';
import 'package:hive_task/view/style.dart/style.dart';
import 'package:hive_task/view/view_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddCategoriesController addCategoriesController =
        Get.put(AddCategoriesController());

    return Scaffold(
      backgroundColor: bg,
   
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "One Mart",
          style: headLine,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AddItems());
              },
              icon: const Icon(
                Icons.add_box_outlined,
                color: black,
              )),
        ],
      ),
      body: GetBuilder<AddCategoriesController>(builder: (controller) {
        return ValueListenableBuilder<Box<CategoryModel>>(
          valueListenable: BoxSingleTon.getInstance().listenable(),
          builder: (context, value, _) {
            List<CategoryModel> categories = value.values.toList();

            if (categories.isEmpty) {
              return const Center(
                child: Text(
                  'No Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
              ),
              itemBuilder: (context, index) {
                CategoryModel category = categories[index];

                return 
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          ViewList(
                              products: category.category, categorys: category),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardColors[index],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    category.categoryNamae,
                                    style: subLine,
                                  ),
                                  Text(
                                    category.category.length.toString(),
                                    style: subLine,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                 
                );
              },
            );
          },
        );
      }),
    );
  }

}
