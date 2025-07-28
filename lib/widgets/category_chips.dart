import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import '../models/subject.dart';

class CategoryChips extends StatelessWidget {
  final CourseController courseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Obx(() {
        final categories = courseController.categories;
        final selectedCategory = courseController.selectedCategory.value;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + 1, // +1 for "All"
          itemBuilder: (context, index) {
            if (index == 0) {
              // "All" chip
              final isSelected = selectedCategory == null;
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: FilterChip(
                  label: Text(
                    'All',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) =>
                      courseController.filterSubjectsByCategory(null),
                  backgroundColor: Colors.grey[200],
                  selectedColor: Get.theme.primaryColor,
                  checkmarkColor: Colors.white,
                  elevation: isSelected ? 4 : 1,
                  pressElevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            } else {
              final category = categories[index - 1];
              final isSelected = selectedCategory?.id == category.id;
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: FilterChip(
                  label: Text(
                    category.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) =>
                      courseController.filterSubjectsByCategory(category),
                  backgroundColor: Colors.grey[200],
                  selectedColor: Get.theme.primaryColor,
                  checkmarkColor: Colors.white,
                  elevation: isSelected ? 4 : 1,
                  pressElevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
}
