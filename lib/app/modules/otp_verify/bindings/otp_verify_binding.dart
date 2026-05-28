import 'package:get/get.dart';

import '../../../services/signup_flow_service/signup_flow_service.dart';
import '../controllers/otp_verify_controller.dart';

class OtpVerifyBinding extends Bindings {
  @override
  void dependencies() {
    SignupFlowService.ensureRegistered();
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController());
  }
}
