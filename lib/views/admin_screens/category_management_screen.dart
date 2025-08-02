// import 'package:course_app/controllers/course_controller.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:course_app/views/admin_screens/course_management_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CategoryManagementScreen extends StatefulWidget {
//   const CategoryManagementScreen({Key? key}) : super(key: key);

//   @override
//   State<CategoryManagementScreen> createState() =>
//       _CategoryManagementScreenState();
// }

// class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
//   final CourseController courseController = Get.find<CourseController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manage Categories'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: _showAddCategoryDialog,
//           ),
//         ],
//       ),
//       body: Obx(() => Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Course Categories',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: courseController.categories.length,
//                     itemBuilder: (context, index) {
//                       final category = courseController.categories[index];
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         child: ListTile(
//                           leading: const Icon(Icons.category),
//                           title: Text(category.name),
//                           subtitle: Text('${category.courses.length} courses'),
//                           onTap: () {
//                             // Open CourseManagementScreen filtered by this category
//                             Get.to(() => CourseManagementScreen(
//                                 initialCategory: catego
//                           },
//                           trailing: PopupMenuButton(
//                             itemBuilder: (context) => [
//                               const PopupMenuItem(
//                                 value: 'edit',
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.edit),
//                                     SizedBox(width: 8),
//                                     Text('Edit'),
//                                   ],
//                                 ),
//                               ),
//                               const PopupMenuItem(
//                                 value: 'delete',
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.delete, color: Colors.red),
//                                     SizedBox(width: 8),
//                                     Text('Delete',
//                                         style: TextStyle(color: Colors.red)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                             onSelected: (value) {
//                               if (value == 'edit') {
//                                 _showEditCategoryDialog(category, index);
//                               } else if (value == 'delete') {
//                                 _showDeleteCategoryDialog(category, index);
//                               }
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }

//   void _showAddCategoryDialog() {
//     final controller = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add New Category'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             labelText: 'Category Name',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (controller.text.isNotEmpty) {
//                 setState(() {
//                   final newCategory = Category(
//                     id: DateTime.now().millisecondsSinceEpoch,
//                     name: controller.text,
//                     courses: [],
//                   );
//                   courseController.categories.add(newCategory);
//                 });
//                 Navigator.pop(context);
//                 Get.snackbar(
//                   'Success',
//                   'Category added successfully',
//                   backgroundColor: Colors.green,
//                   colorText: Colors.white,
//                 );
//               }
//             },
//             child: const Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showEditCategoryDialog(Category category, int index) {
//     final controller = TextEditingController(text: category.name);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Edit Category'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             labelText: 'Category Name',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (controller.text.isNotEmpty) {
//                 setState(() {
//                   courseController.categories[index] = Category(
//                     id: category.id,
//                     name: controller.text,
//                     courses: category.courses,
//                   );
//                 });
//                 Navigator.pop(context);
//                 Get.snackbar(
//                   'Success',
//                   'Category updated successfully',
//                   backgroundColor: Colors.green,
//                   colorText: Colors.white,
//                 );
//               }
//             },
//             child: const Text('Update'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDeleteCategoryDialog(Category category, int index) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Category'),
//         content: Text('Are you sure you want to delete "${category.name}"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 courseController.categories.removeAt(index);
//               });
//               Navigator.pop(context);
//               Get.snackbar(
//                 'Success',
//                 'Category deleted successfully',
//                 backgroundColor: Colors.green,
//                 colorText: Colors.white,
//               );
//             },
//             child: const Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/image_picker_controller.dart';
import 'package:course_app/models/category.dart';
import 'package:course_app/services/category_services.dart';
import 'package:course_app/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({Key? key}) : super(key: key);

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final CourseController courseController = Get.find<CourseController>();
  final ImagePickerController imageController =
      Get.put(ImagePickerController());
  final CategoryServices categoryServices = CategoryServices();
  final StorageServices storageServices = StorageServices();
  bool isLoadingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Subject Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: courseController.categories.length,
                  itemBuilder: (context, index) {
                    final category = courseController.categories[index];
                    // Count subjects in this category
                    final subjectCount = courseController.subjects
                        .where((s) => s.category == category.name)
                        .length;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(8)),
                            child: Image.network(
                              category.image,
                              fit: BoxFit.cover,
                              height: 80,
                              width: 70,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${category.name}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "$subjectCount subjects",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete',
                                            style: TextStyle(
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditCategoryDialog(
                                        category, index);
                                  } else if (value == 'delete') {
                                    _showDeleteCategoryDialog(
                                        category, index);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showAddCategoryDialog() {
    final controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(

              title: const Text('Add New Category'),
              content:  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(() => Center(
                            child: imageController.imagePath.value.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      imageController.getImage();
                                    },
                                    child: const Text('Select Image'),
                                  )
                                : Image.file(
                                    File(imageController.imagePath.value),
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                          ))),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      imageController.imagePath.value = "";
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                isLoadingIn == true ? Container(width:30,height:30,child: Center(child: CircularProgressIndicator(),)):ElevatedButton(
                  onPressed: () async {
                    if (controller.text.isNotEmpty) {
                      setState(() {
                        isLoadingIn=true;
                        isLoadingIn = true;
                      });

                      // print("isLoading =$isLoadingIn");
                      File file = File(imageController.imagePath.value);
                      String url = await storageServices.uploadImage(file);
                      final newCategory = Category(
                        name: controller.text,
                        image: imageController.imagePath.value.isEmpty
                            ? 'https://as1.ftcdn.net/v2/jpg/05/58/73/12/1000_F_558731213_ilx4NZvbojGEMQDAfw5W2mcJjinZqf6V.jpg'
                            : url,
                      );
                      await categoryServices.addCategory(newCategory);
                      setState(() {
                        isLoadingIn=false;
                        imageController.imagePath.value="";
                      });

                      Navigator.pop(context);
                      await courseController.loadCategories();


                      Get.snackbar(
                        'Success',
                        'Category added successfully',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          });
        });
  }

  void _showEditCategoryDialog(Category category, int index) {
    final controller = TextEditingController(text: category.name);
    final imagePath = category.image;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                if (imageController.imagePath.value.isNotEmpty) {
                  // New image picked
                  return GestureDetector(
                    onTap: () => imageController.getImage(),
                    child: Image.file(
                      File(imageController.imagePath.value),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  );
                } else if (category.image.isNotEmpty) {
                  // Show existing image
                  return GestureDetector(
                    onTap: () => imageController.getImage(),
                    child: Image.network(
                      category.image,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () => imageController.getImage(),
                  child: const Center(child: Text('Change Image')),
                );
              }),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                imageController.imagePath.value = "";
              });
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final newName = controller.text.trim();
                String newImage;
                if (imageController.imagePath.value.isNotEmpty &&
                    imageController.imagePath.value != category.image) {
                  File file = File(imageController.imagePath.value);
                  newImage = await storageServices.uploadImage(file);
                } else {
                  newImage = category.image;
                }
                await categoryServices.updateCategory(
                    category.id!, newName, newImage);
                Navigator.pop(context);
                Get.snackbar(
                  'Success',
                  'Category updated successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );

                await courseController.loadCategories();
              } catch (e) {
                Get.snackbar('Error', 'Failed to update category',
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteCategoryDialog(Category category, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text(
            'Are you sure you want to delete "${category.name}"? All subjects in this category will be uncategorized.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await categoryServices.deleteCategory(category.id!);
              Navigator.pop(context);
              Get.snackbar(
                'Success',
                'Category deleted successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
              setState(() {
                courseController.loadCategories();
              });
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
