import 'package:course_app/models/banner.dart';
import 'package:course_app/models/purchase.dart';
import 'package:course_app/services/banner_services.dart';
import 'package:course_app/services/category_services.dart';
import 'package:course_app/services/chapter_services.dart';
import 'package:course_app/services/purchase_services.dart';
import 'package:course_app/services/subject_services.dart';
import 'package:get/get.dart';
import '../models/category.dart';
import '../models/subject.dart';
import '../models/chapter.dart';

class CourseController extends GetxController {

  final CategoryServices categoryServices = CategoryServices();
  final SubjectServices subjectServices = SubjectServices();
  final ChapterService chapterService = ChapterService();
  final PurchaseServices purchaseServices = PurchaseServices();
  final BannerServices bannerServices = BannerServices();

  var categories = <Category>[].obs;
  var subjects = <Subject>[].obs;
  var chapters = <Chapter>[].obs;
  var purchases = <Purchase>[].obs;
  var banners = <Banners>[].obs;

  var selectedCategory = Rxn<Category>();
  var selectedSubject = Rxn<Subject>();
  var selectedChapter = Rxn<Chapter>();

  var isLoading = false.obs;
  final error = RxnString();
  var searchQuery = ''.obs;

  var filteredSubjects = <Subject>[].obs;
  var filteredChapters = <Chapter>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadSubjects();
    loadChapters();
    loadPurchases();
    loadBanners();
    calculatePrice(null);
  }
  RxDouble totalPrice = 0.0.obs;
  RxDouble totalPricePerUser = 0.0.obs;

  void calculatePrice(String? userId){
    double newPrice  = 0.0;
    totalPrice.value = 0.0;
    for(Purchase purchase in purchases){
      if(userId !=null){
        if(purchase.userId == userId){
          newPrice += purchase.price;
        }
      }else{
        newPrice += purchase.price;
      }

    }
    if(userId !=null){
      totalPricePerUser.value = newPrice;
    }else{
      totalPrice.value = newPrice;

    }
  }
  Future<void> loadPurchases()async{
    isLoading.value = true;
    error.value = null;
    try {
      purchases.value = await purchaseServices.getPurchaseCourse();
    } catch (e) {
      error.value = 'Failed to load purchases: $e';
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> loadBanners() async{
    isLoading.value = true;
    banners.value = await bannerServices.getAllBanners();
    isLoading.value=false;

  }

  Future<void> addPurchase(Purchase purchase) async {
    isLoading.value = true;
    error.value = null;
    try {
      await purchaseServices.purchaseCourse(purchase);
      await loadPurchases();
    } catch (e) {
      error.value = 'Failed to add purchase: $e';
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> loadCategories() async {
    isLoading.value = true;
    categories.value = await categoryServices.getCategories();
    isLoading.value = false;
  }

  Future<void> loadSubjects() async{
    isLoading.value = true;
    subjects.value = await subjectServices.getAllSubjects();
    filteredSubjects.value = subjects;
    isLoading.value = false;
  }

  Future<void> filterSubjectsByCategory(Category? category) async {
    selectedCategory.value = category;
    if (category == null || category.name.toLowerCase() == 'all') {
      filteredSubjects.value = subjects;
    } else {
      filteredSubjects.value =
          subjects.where((s) => s.category == category.name).toList();
    }
  }

  void cleanCategory(){
    selectedCategory.value = null;
    filteredSubjects.value = subjects;
  }

  void cleanSubject(){
    selectedSubject.value = null;
  }

  Future<void> loadChapters() async {
    isLoading.value = true;
    chapters.value = await chapterService.getChapters();
    isLoading.value = false;
  }

  Future<void> filterPurchasesByUserId(String userId) async {
    // purchases.value = await purchaseServices.getPurchaseCourse();
    purchases.value = purchases.where((p) => p.userId == userId).toList();
  }

  Future<void> filterChaptersBySubject(Subject? subject) async {
    selectedSubject.value = subject;
    if (subject == null || subject.name.toLowerCase() =='all') {
      filteredChapters.value = chapters;
    } else {
      filteredChapters.value =
          chapters.where((c) => c.subject == subject.name).toList();
    }
  }

  Future<void> filterChaptersByCategory(Category? category) async {
    selectedCategory.value = category;
    if (category == null || category.name.toLowerCase() =='all') {
      filteredChapters.value = chapters;
    } else {
      filteredChapters.value =
          chapters.where((c) => c.subject == category.name).toList();
    }
  }


  void searchSubjects(String query) {
    searchQuery.value = query;
    List<Subject> allSubjects = selectedCategory.value == null
        ? subjects
        : subjects
            .where((s) => s.category == selectedCategory.value!.name)
            .toList();
    filteredSubjects.value = allSubjects
        .where((subject) =>
            subject.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
  // void searchChapters(String query) {
  //   searchQuery.value = query;
  //   List<Subject> allCategories = selectedCategory.value == null
  //       ? subjects
  //       : subjects
  //       .where((s) => s.category == selectedCategory.value!.name)
  //       .toList();
  //   filteredSubjects.value = allSubjects
  //       .where((subject) =>
  //       subject.name.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }

  void searchChapters(String query) {
    List<Chapter> allChapters = selectedSubject.value == null
        ? chapters
        : chapters
            .where((c) => c.subject == selectedSubject.value!.name)
            .toList();
    filteredChapters.value = allChapters
        .where((chapter) =>
            chapter.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void selectCategory(Category category) {
    selectedCategory.value = category;
    filterSubjectsByCategory(category);
  }

  void selectSubject(Subject subject) {
    selectedSubject.value = subject;
    filterChaptersBySubject(subject);
  }

  void selectChapter(Chapter chapter) {
    selectedChapter.value = chapter;
  }
}

