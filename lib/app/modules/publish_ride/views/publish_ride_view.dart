import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/driver_aware_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../controllers/publish_ride_controller.dart';
import '../widgets/publish_ride_steps.dart';

class PublishRideView extends GetView<PublishRideController> {
  const PublishRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await controller.handleAppBarBack();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: const DriverAwareBottomNav(highlightPublishInFlow: true),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TmMintAppBar(
                title: 'publish_ride.title'.tr,
                onBack: () => controller.handleAppBarBack(),
              ),
              Obx(() => PublishFlowStepper(stepIndex: controller.stepIndex.value)),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: controller.onPageChanged,
                  children: [
                    PublishRouteStep(),
                    PublishDateStep(),
                    PublishDetailsStep(),
                    PublishReviewStep(),
                    PublishPaymentStep(),
                    PublishSuccessStep(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
