import 'dart:io';

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/image_picker_controller.dart';
import 'package:course_app/models/banner.dart';
import 'package:course_app/services/banner_services.dart';
import 'package:course_app/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final ImagePickerController imagePickerController = ImagePickerController();
  final StorageServices storageServices = StorageServices();
  final BannerServices bannerServices = BannerServices();
  final CourseController courseController = Get.put(CourseController());
  bool isLoadingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner Screen'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(
              onTap: () {
                _showAddCategoryDialog();
              },
              child: Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => ListView.builder(
                itemCount: courseController.banners.length,
                itemBuilder: (context, index) {
                  final banner = courseController.banners[index];
                  return Stack(children: [
                    Image.network(
                      banner.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    GestureDetector(
                        onTap: () async {
                          _showDeleteCategoryDialog(banner, index);
                        },
                        child: Icon(Icons.delete)),
                  ]);
                }),
          )),
    );
  }

  void _showAddCategoryDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Category'),
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
                      child: Obx(() => Center(
                            child: imagePickerController.imagePath.value.isEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      imagePickerController.getImage();
                                    },
                                    child: const Text('Select Image'),
                                  )
                                : Image.file(
                                    File(imagePickerController.imagePath.value),
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                          ))),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      imagePickerController.imagePath.value = "";
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                isLoadingIn == true
                    ? Container(
                        width: 30,
                        height: 30,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ))
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoadingIn = true;
                          });
                          var uuid = Uuid();
                          String id = uuid.v4();

                          File file =
                              File(imagePickerController.imagePath.value);
                          String url = await storageServices.uploadImage(file);
                          final newBanner = Banners(
                            id: id,
                            imageUrl: imagePickerController
                                    .imagePath.value.isEmpty
                                ? 'https://as1.ftcdn.net/v2/jpg/05/58/73/12/1000_F_558731213_ilx4NZvbojGEMQDAfw5W2mcJjinZqf6V.jpg'
                                : url,
                          );
                          await bannerServices.addBanner(newBanner);
                          setState(() {
                            isLoadingIn = false;
                            imagePickerController.imagePath.value = "";
                          });

                          Navigator.pop(context);

                          await courseController.loadBanners();
                          Get.snackbar(
                            'Success',
                            'Banner added successfully',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                        child: const Text('Add'),
                      ),
              ],
            );
          });
        });
  }

  void _showDeleteCategoryDialog(Banners banner, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Banner'),
        content: Text('Are you sure you want to delete?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await bannerServices.deleteBanner(banner.id!);
              await courseController.loadBanners();
              Navigator.pop(context);
              Get.snackbar(
                'Success',
                'Category deleted successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
