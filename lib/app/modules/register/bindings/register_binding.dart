import 'package:get/get.dart';

import '../../../services/signup_flow_service/signup_flow_service.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    SignupFlowService.ensureRegistered();
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
