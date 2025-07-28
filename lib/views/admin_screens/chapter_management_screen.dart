// import 'package:course_app/models/chapter.dart';
// import 'package:course_app/models/subject.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChapterManagementScreen extends StatefulWidget {
//   final Subject course;

//   const ChapterManagementScreen(
//       {Key? key, required this.course, required Subject subject})
//       : super(key: key);

//   @override
//   State<ChapterManagementScreen> createState() =>
//       _ChapterManagementScreenState();
// }

// class _ChapterManagementScreenState extends State<ChapterManagementScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Chapters - ${widget.course.name}'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => _showAddChapterDialog(),
//           ),
//         ],
//       ),
//       body: ReorderableListView.builder(
//         padding: const EdgeInsets.all(16),
//         // itemCount: widget.course.chapters.length,
//         itemCount: (widget.course.chapters ?? []).length,
//         itemBuilder: (context, index) {
//           final chapter = widget.course.chapters[index];
//           return _buildChapterCard(chapter, index, key: ValueKey(chapter.id));
//         },
//         onReorder: (oldIndex, newIndex) {
//           setState(() {
//             if (newIndex > oldIndex) {
//               newIndex -= 1;
//             }
//             final Chapter item = widget.course.chapters.removeAt(oldIndex);
//             widget.course.chapters.insert(newIndex, item);
//           });
//         },
//       ),
//     );
//   }

//   Widget _buildChapterCard(Chapter chapter, int index, {required Key key}) {
//     return Card(
//       key: key,
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.drag_handle, color: Colors.grey[400]),
//             const SizedBox(width: 8),
//             CircleAvatar(
//               backgroundColor: Colors.indigo,
//               child: Text(
//                 '${index + 1}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//         title: Text(chapter.name),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(chapter.description),
//             const SizedBox(height: 4),
//             Text(
//               'Duration: ${chapter.duration}',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         trailing: PopupMenuButton(
//           itemBuilder: (context) => [
//             const PopupMenuItem(
//               value: 'edit',
//               child: Row(
//                 children: [
//                   Icon(Icons.edit),
//                   SizedBox(width: 8),
//                   Text('Edit'),
//                 ],
//               ),
//             ),
//             const PopupMenuItem(
//               value: 'delete',
//               child: Row(
//                 children: [
//                   Icon(Icons.delete, color: Colors.red),
//                   SizedBox(width: 8),
//                   Text('Delete', style: TextStyle(color: Colors.red)),
//                 ],
//               ),
//             ),
//           ],
//           onSelected: (value) {
//             if (value == 'edit') {
//               _showEditChapterDialog(chapter, index);
//             } else if (value == 'delete') {
//               _showDeleteChapterDialog(chapter, index);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   void _showAddChapterDialog() {
//     final titleController = TextEditingController();
//     final descriptionController = TextEditingController();
//     final durationController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add New Chapter'),
//         content: SingleChildScrollView(
//           // <-- Prevent bottom overflow
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(
//                   labelText: 'Chapter Title',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(
//                   labelText: 'Description',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: durationController,
//                 decoration: const InputDecoration(
//                   labelText: 'Duration (e.g., 15 min)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           // ...existing code...
//           ElevatedButton(
//             onPressed: () {
//               if (titleController.text.isNotEmpty &&
//                   descriptionController.text.isNotEmpty &&
//                   durationController.text.isNotEmpty) {
//                 final newChapter = Chapter(
//                   id: DateTime.now().millisecondsSinceEpoch.toString(),
//                   name: titleController.text,
//                   description: descriptionController.text,
//                   duration: durationController.text,
//                   category: widget.course.category,
//                   subject: widget.course.name,
//                   price: 0.0, // Default price
//                   pdf: '', // Default PDF link
//                   rating: 0.0, // Default rating
//                   timestamp: DateTime.now(),
//                 );
//                 setState(() {
//                   widget.course.chapters.add(newChapter);
//                 });
//                 Navigator.pop(context);
//                 Get.snackbar(
//                   'Success',
//                   'Chapter added successfully',
//                   backgroundColor: Colors.green,
//                   colorText: Colors.white,
//                 );
//               }
//             },
//             child: const Text('Add'),
//           ),
// // ...existing code...
//         ],
//       ),
//     );
//   }

//   void _showEditChapterDialog(Chapter chapter, int index) {
//     final titleController = TextEditingController(text: chapter.name);
//     final descriptionController =
//         TextEditingController(text: chapter.description);
//     final durationController = TextEditingController(text: chapter.duration);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Edit Chapter'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Chapter Title',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: durationController,
//               decoration: const InputDecoration(
//                 labelText: 'Duration (e.g., 15 min)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           // ...existing code...
//           ElevatedButton(
//             onPressed: () {
//               if (titleController.text.isNotEmpty &&
//                   descriptionController.text.isNotEmpty &&
//                   durationController.text.isNotEmpty) {
//                 setState(() {
//                   widget.course.chapters[index] = Chapter(
//                     id: chapter.id,
//                     name: titleController.text,
//                     description: descriptionController.text,
//                     duration: durationController.text,
//                     category: widget.course.category,
//                     subject: widget.course.name,
//                     price: chapter.price,
//                     pdf: chapter.pdf,
//                     rating: chapter.rating,
//                     timestamp: chapter.timestamp,
//                   );
//                 });
//                 Navigator.pop(context);
//                 Get.snackbar(
//                   'Success',
//                   'Chapter updated successfully',
//                   backgroundColor: Colors.green,
//                   colorText: Colors.white,
//                 );
//               }
//             },
//             child: const Text('Update'),
//           ),
// // ...existing code...
//         ],
//       ),
//     );
//   }

//   void _showDeleteChapterDialog(Chapter chapter, int index) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Chapter'),
//         content: Text('Are you sure you want to delete "${chapter.name}"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 widget.course.chapters.removeAt(index);
//               });
//               Navigator.pop(context);
//               Get.snackbar(
//                 'Success',
//                 'Chapter deleted successfully',
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

import 'package:course_app/services/chapter_services.dart';
import 'package:course_app/widgets/pdf_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:course_app/models/chapter.dart';
import 'package:course_app/models/subject.dart';
import 'package:course_app/controllers/course_controller.dart';

class ChapterManagementScreen extends StatefulWidget {
  final Subject subject;

  const ChapterManagementScreen({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  State<ChapterManagementScreen> createState() =>
      _ChapterManagementScreenState();
}

class _ChapterManagementScreenState extends State<ChapterManagementScreen>
    with SingleTickerProviderStateMixin {
  final CourseController _courseController = Get.find<CourseController>();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  final RxBool _isLoading = false.obs;
  final RxList<Chapter> _subjectChapters = <Chapter>[].obs;

  final ChapterService chapterService = ChapterService();


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    // Load chapters immediately when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChapters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadChapters() {
    _isLoading.value = true;
    try {
      // Filter chapters for this subject from the controller
      _subjectChapters.value = _courseController.chapters
          .where((chapter) => chapter.subject == widget.subject.name)
          .toList();
    } finally {
      _isLoading.value = false;
    }
  }

  void _filterChapters(String query) {
    if (query.isEmpty) {
      _loadChapters();
    } else {
      _subjectChapters.value = _courseController.chapters
          .where((chapter) =>
              chapter.subject == widget.subject.name &&
              chapter.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  // void _addChapter(Chapter chapter) {
  //   chapterService.addChapter(chapter);
  //
  //   // Animate only the new chapter
  //   _animationController.reset();
  //   _animationController.forward();
  // }

  void _updateChapter(Chapter updatedChapter, int index) {
    final globalIndex = _courseController.chapters
        .indexWhere((chapter) => chapter.id == updatedChapter.id);

    if (globalIndex != -1) {
      _courseController.chapters[globalIndex] = updatedChapter;
      _subjectChapters[index] = updatedChapter;
    }
  }

  void _deleteChapter(String chapterId) {
    final globalIndex = _courseController.chapters
        .indexWhere((chapter) => chapter.id == chapterId);

    if (globalIndex != -1) {
      _courseController.chapters.removeAt(globalIndex);
      _loadChapters();
    }
  }

  void _reorderChapters(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final Chapter item = _subjectChapters.removeAt(oldIndex);
    _subjectChapters.insert(newIndex, item);

    // Update the order in the global chapters list
    // This is a simplified approach - in a real app you might want to store
    // a position/order field in each chapter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Chapters - ${widget.subject.name}'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddChapterDialog(),
            tooltip: 'Add New Chapter',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              if (_isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                  ),
                );
              }

              return _subjectChapters.isEmpty
                  ? _buildEmptyState()
                  : _buildChaptersList();
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddChapterDialog(),
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search chapters...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _filterChapters('');
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: _filterChapters,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No chapters found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first chapter to get started',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddChapterDialog(),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text('Add Chapter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChaptersList() {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _subjectChapters.length,
      onReorder: _reorderChapters,
      itemBuilder: (context, index) {
        final chapter = _subjectChapters[index];
        return FadeTransition(
          key: ValueKey(chapter.id),
          opacity: _animation,
          child: _buildChapterCard(chapter, index),
        );
      },
    );
  }

  Widget _buildChapterCard(Chapter chapter, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                chapter.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                chapter.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showEditChapterDialog(chapter, index),
                    tooltip: 'Edit Chapter',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteChapterDialog(chapter, index),
                    tooltip: 'Delete Chapter',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Duration: ${chapter.duration}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (chapter.rating > 0)
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          'Rating: ${chapter.rating.toStringAsFixed(1)}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (chapter.pdf.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf,
                        size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => PDFViewerScreen(
                            pdfUrl: chapter.pdf,
                            // or pdfPath: course.pdfPath if local
                            title: chapter.name,
                          ));
                        },
                        child: Text(
                          'PDF: ${chapter.pdf}',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddChapterDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final durationController = TextEditingController();
    final pdfController = TextEditingController();
    final priceController = TextEditingController(text: '0.0');

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Chapter'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Chapter Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (e.g., 15 min)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price (optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: pdfController,
                  decoration: const InputDecoration(
                    labelText: 'PDF URL (optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.picture_as_pdf),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final newChapter = Chapter(
                  name: titleController.text,
                  description: descriptionController.text,
                  duration: int.parse(durationController.text),
                  category: widget.subject.category,
                  subject: widget.subject.name,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  pdf: pdfController.text,
                  rating: 0.0,
                  timestamp: DateTime.now(),
                );

                await chapterService.addChapter(newChapter);
                Navigator.pop(context);

                Get.snackbar(
                  'Success',
                  'Chapter added successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 3),
                );
                  _courseController.loadChapters();

              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditChapterDialog(Chapter chapter, int index) {
    final titleController = TextEditingController(text: chapter.name);
    final descriptionController =
        TextEditingController(text: chapter.description);
    final durationController = TextEditingController(text: chapter.duration.toString());
    final pdfController = TextEditingController(text: chapter.pdf);
    final priceController =
        TextEditingController(text: chapter.price.toString());

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Chapter'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Chapter Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (e.g., 15 min)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: pdfController,
                  decoration: const InputDecoration(
                    labelText: 'PDF URL',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.picture_as_pdf),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final updatedChapter = Chapter(
                  id: chapter.id,
                  name: titleController.text,
                  description: descriptionController.text,
                  duration: int.parse(durationController.text),
                  category: chapter.category,
                  subject: chapter.subject,
                  price: double.tryParse(priceController.text) ?? chapter.price,
                  pdf: pdfController.text,
                  rating: chapter.rating,
                  timestamp: chapter.timestamp,
                );

                chapterService.updateChapter(chapter.id!, updatedChapter);
                Navigator.pop(context);

                Get.snackbar(
                  'Success',
                  'Chapter updated successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(16),
                );
                _courseController.loadChapters();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteChapterDialog(Chapter chapter, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Chapter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.amber,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to delete "${chapter.name}"?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'This action cannot be undone.',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: ()  async{
              await chapterService.deleteChapter(chapter.id!);
              Get.back();
              Get.snackbar(
                'Success',
                'Chapter deleted successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
              );
              _courseController.loadChapters();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
