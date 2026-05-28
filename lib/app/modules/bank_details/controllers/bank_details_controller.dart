import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/sounds/ui_sounds.dart';
import '../../../services/local_storage_services/local_storage_services.dart';

enum BankDetailsPhase { form, verifying, success, manage }

class BankDetailsController extends GetxController {
  final phase = BankDetailsPhase.form.obs;

  final holderController = TextEditingController();
  final bankNameController = TextEditingController();
  final ibanController = TextEditingController();
  final swiftController = TextEditingController();
  final paypalEmailController = TextEditingController();

  /// `bank` | `paypal`
  final payoutMethod = 'bank'.obs;

  @override
  void onInit() {
    super.onInit();
    final s = LocalStorageService();
    if (s.getPayoutSaved()) {
      holderController.text = s.getPayoutHolder();
      bankNameController.text = s.getPayoutBankName();
      ibanController.text = s.getPayoutIban();
      swiftController.text = s.getPayoutSwift();
      paypalEmailController.text = s.getPayoutPaypalEmail();
      payoutMethod.value = s.getPayoutMethod();
      phase.value = BankDetailsPhase.manage;
    }
  }

  @override
  void onClose() {
    holderController.dispose();
    bankNameController.dispose();
    ibanController.dispose();
    swiftController.dispose();
    paypalEmailController.dispose();
    super.onClose();
  }

  void setPayoutMethod(String m) => payoutMethod.value = m;

  Future<void> savePayoutDetails() async {
    if (phase.value != BankDetailsPhase.form) return;
    final holder = holderController.text.trim();
    final bank = bankNameController.text.trim();
    final iban = ibanController.text.trim();
    if (holder.isEmpty || bank.isEmpty || iban.isEmpty) {
      Get.snackbar('bank_details.validation_title'.tr, 'bank_details.validation_body'.tr);
      return;
    }
    if (payoutMethod.value == 'paypal' && paypalEmailController.text.trim().isEmpty) {
      Get.snackbar('bank_details.validation_title'.tr, 'bank_details.paypal_required'.tr);
      return;
    }

    // Save immediately so leaving the screen during the animation does not lose data.
    final ls = LocalStorageService();
    await ls.setPayoutHolder(holder);
    await ls.setPayoutBankName(bank);
    await ls.setPayoutIban(iban);
    await ls.setPayoutSwift(swiftController.text.trim());
    await ls.setPayoutPaypalEmail(paypalEmailController.text.trim());
    await ls.setPayoutMethod(payoutMethod.value);
    await ls.setPayoutSaved(true);

    phase.value = BankDetailsPhase.verifying;
    await Future<void>.delayed(const Duration(milliseconds: 2600));
    phase.value = BankDetailsPhase.success;
    unawaited(UiSounds.playSuccessChime());
    await Future<void>.delayed(const Duration(milliseconds: 2200));

    phase.value = BankDetailsPhase.manage;
  }

  void goToEditForm() => phase.value = BankDetailsPhase.form;

  String get maskedIban {
    final raw = LocalStorageService().getPayoutIban().replaceAll(' ', '');
    if (raw.length < 4) return '—';
    return '···· ${raw.substring(raw.length - 4)}';
  }
}
