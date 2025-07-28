import 'package:course_app/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/course_controller.dart';
import '../widgets/course_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CourseController courseController = Get.find();

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(100), // Increased height for a modern look
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.18),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        child:
                            Icon(Icons.school, color: Colors.white, size: 28),
                      ),
                      SizedBox(width: 14),
                      Text(
                        'CourseHub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  // Profile or menu icon
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ProfileScreen());
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withOpacity(0.18),
                      child: Icon(Icons.person,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (courseController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Color(0xFF2563EB), width: 1.5),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: courseController.searchSubjects,
                  decoration: InputDecoration(
                    hintText: 'Search courses...',
                    prefixIcon: Icon(Icons.search, color: Color(0xFF2563EB)),
                    suffixIcon:
                        Obx(() => courseController.searchQuery.value.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, color: Color(0xFF2563EB)),
                                onPressed: () {
                                  searchController
                                      .clear(); // Clear the text field
                                  courseController.searchQuery.value =
                                      ''; // Clear the search query
                                  courseController
                                      .searchSubjects(''); // Reset search results
                                },
                              )
                            : SizedBox.shrink()),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Hero Slider
              Container(
                height: 200,
                child: CarouselSlider(

                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                  ),
                  items: courseController.banners.map((banner) {
                    return Image(image: NetworkImage(banner.imageUrl));
                  }).toList()

                ),
              ),
              // ...existing code...
              SizedBox(height: 30),

              Obx(() {
                if (courseController.searchQuery.value.isNotEmpty) {
                  final results = courseController.filteredSubjects;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Search Results for "${courseController.searchQuery.value}"',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      if (results.isEmpty)
                        Text(
                          'No results found.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        )
                      else
                        ...results
                            .map((course) => Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: CourseCard(
                                    subject: course,
                                    borderRadius: BorderRadius.circular(2),
                                    backgroundColor: Colors.white,
                                  ),
                                ))
                            .toList(),
                    ],
                  );
                }
                return SizedBox.shrink();
              }),

              SizedBox(height: 16),

              // Featured Courses
              Text(
                'Featured Courses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              Obx(() {
                if (courseController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: courseController.subjects
                      .take(3)
                      .map((subject) => Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: CourseCard(
                              subject: subject,
                              borderRadius: BorderRadius.circular(2),
                              backgroundColor: Colors.white,
                            ),
                          ))
                      .toList(),
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSliderItem(String title, String subtitle, Color color) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
