import 'package:get/get.dart';
import '../../../data/in_memory_user_profile_repository.dart';
import '../../../domain/user_profile_repository.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileRepository>(() => InMemoryUserProfileRepository());
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}
