import 'package:flutter/material.dart';
import 'package:movora/models/ads_model.dart';
import 'package:movora/services/ad_post_services.dart';

class PostViewModel extends ChangeNotifier {
  final AdPostServices _adPostServices = AdPostServices();

  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  // 🔹 Form Key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  List<PostModel> posts = [];
  Future<void> addNewPost(PostModel post) async {
    try {
      if (!formKey.currentState!.validate()) {
        debugPrint('⚠️ Please fill all fields correctly');
        return;
      }
      isLoading = true;
      notifyListeners();

      await _adPostServices.addPost(post);

      debugPrint('✅ post added successfully');
    } catch (e) {
      debugPrint('❌ post added not success');
    }
    isLoading = false;
    notifyListeners();
  }

  void getAllPost() {
    try {
      isLoading = true;
      notifyListeners();

      _adPostServices.getAllPost().listen((data) {
        posts = data;
        notifyListeners();
      });
      debugPrint('✅ post fetching successfully');
    } catch (e) {
      debugPrint('❌ post added not success');
    }
    isLoading = false;
    notifyListeners();
  }

  void deletePost(String postId) async {
    await _adPostServices.deletePost(postId);
  }
}
