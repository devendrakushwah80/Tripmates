import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../driver_shell/theme/driver_shell_theme.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../controllers/bank_details_controller.dart';

class BankDetailsView extends GetView<BankDetailsController> {
  const BankDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverShellTheme.screenBg,
      body: SafeArea(
        child: Obx(() {
          switch (controller.phase.value) {
            case BankDetailsPhase.form:
              return _BankFormBody(controller: controller);
            case BankDetailsPhase.verifying:
              return Stack(
                children: [
                  _BankFormBody(controller: controller, dimmed: true),
                  const _VerifyingOverlay(),
                ],
              );
            case BankDetailsPhase.success:
              return _SuccessInterstitial(controller: controller);
            case BankDetailsPhase.manage:
              return _ManageBody(controller: controller);
          }
        }),
      ),
    );
  }
}

class _BankFormBody extends StatelessWidget {
  const _BankFormBody({required this.controller, this.dimmed = false});

  final BankDetailsController controller;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: dimmed,
      child: Opacity(
        opacity: dimmed ? 0.35 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'bank_details.title'.tr, showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: [
                  _SecureBanner(),
                  const SizedBox(height: 18),
                  Text(
                    'bank_details.section_account'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: DriverShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _Field(controller: controller.holderController, label: 'bank_details.holder'.tr),
                  const SizedBox(height: 10),
                  _Field(controller: controller.bankNameController, label: 'bank_details.bank_name'.tr),
                  const SizedBox(height: 10),
                  _Field(controller: controller.ibanController, label: 'bank_details.iban'.tr),
                  const SizedBox(height: 10),
                  _Field(controller: controller.swiftController, label: 'bank_details.swift'.tr, optional: true),
                  const SizedBox(height: 18),
                  Text(
                    'bank_details.section_method'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: DriverShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final m = controller.payoutMethod.value;
                    return Row(
                      children: [
                        Expanded(
                          child: _MethodCard(
                            title: 'bank_details.method_bank'.tr,
                            selected: m == 'bank',
                            onTap: () => controller.setPayoutMethod('bank'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MethodCard(
                            title: 'bank_details.method_paypal'.tr,
                            selected: m == 'paypal',
                            onTap: () => controller.setPayoutMethod('paypal'),
                          ),
                        ),
                      ],
                    );
                  }),
                  Obx(() {
                    if (controller.payoutMethod.value != 'paypal') return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: _Field(
                        controller: controller.paypalEmailController,
                        label: 'bank_details.paypal_email'.tr,
                      ),
                    );
                  }),
                  const SizedBox(height: 28),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: DriverShellTheme.primaryGreen.withValues(alpha: 0.28),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: FilledButton(
                      onPressed: () => controller.savePayoutDetails(),
                      style: FilledButton.styleFrom(
                        backgroundColor: DriverShellTheme.primaryGreen,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        'bank_details.save_cta'.tr,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white),
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
}

class _SecureBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: DriverShellTheme.softGreenBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DriverShellTheme.primaryGreen.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user_outlined, color: DriverShellTheme.primaryGreen, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'bank_details.secure_banner'.tr,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: DriverShellTheme.textPrimary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    this.optional = false,
  });

  final TextEditingController controller;
  final String label;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: optional ? '$label (${'bank_details.optional'.tr})' : label,
        filled: true,
        fillColor: DriverShellTheme.cardWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.25)),
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DriverShellTheme.cardWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected ? DriverShellTheme.primaryGreen : const Color(0xFFE2E8F0),
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? DriverShellTheme.primaryGreen : DriverShellTheme.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: DriverShellTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerifyingOverlay extends StatelessWidget {
  const _VerifyingOverlay();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.42),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
            decoration: BoxDecoration(
              color: DriverShellTheme.cardWhite,
              borderRadius: BorderRadius.circular(20),
              boxShadow: DriverShellTheme.cardShadow,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 72,
                  width: 72,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: DriverShellTheme.primaryGreen.withValues(alpha: 0.35),
                        ),
                      ),
                      Icon(Icons.lock_rounded, color: DriverShellTheme.primaryGreen, size: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'bank_details.processing_title'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: DriverShellTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'bank_details.processing_sub'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.4,
                    color: DriverShellTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 18),
                _CheckLine(text: 'bank_details.step_validate'.tr),
                const SizedBox(height: 8),
                _CheckLine(text: 'bank_details.step_encrypt'.tr),
                const SizedBox(height: 8),
                _CheckLine(text: 'bank_details.step_method'.tr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckLine extends StatelessWidget {
  const _CheckLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_rounded, size: 18, color: DriverShellTheme.primaryGreen),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: DriverShellTheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessInterstitial extends StatelessWidget {
  const _SuccessInterstitial({required this.controller});

  final BankDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        children: [
          TmMintAppBar(title: 'bank_details.title'.tr, showBack: false),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                  child: Lottie.asset(
                    'assets/lottie/Success.json',
                    repeat: false,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'bank_details.success_title'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: DriverShellTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'bank_details.success_sub'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.45,
                    color: DriverShellTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ManageBody extends StatelessWidget {
  const _ManageBody({required this.controller});

  final BankDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final ls = LocalStorageService();
    final method = ls.getPayoutMethod() == 'paypal' ? 'bank_details.method_paypal'.tr : 'bank_details.method_bank'.tr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TmMintAppBar(title: 'bank_details.title'.tr, showBack: true),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
            children: [
              Text(
                'bank_details.manage_heading'.tr,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: DriverShellTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DriverShellTheme.cardWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: DriverShellTheme.cardShadow,
                  border: Border.all(color: DriverShellTheme.textSecondary.withValues(alpha: 0.12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'bank_details.current_method'.tr,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: DriverShellTheme.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: DriverShellTheme.softGreenBg,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            'bank_details.active_badge'.tr,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: DriverShellTheme.primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(method, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 6),
                    if (ls.getPayoutMethod() == 'paypal')
                      Text(
                        ls.getPayoutPaypalEmail(),
                        style: GoogleFonts.inter(color: DriverShellTheme.textSecondary, fontSize: 14),
                      )
                    else ...[
                      Text(
                        controller.maskedIban,
                        style: GoogleFonts.inter(color: DriverShellTheme.textSecondary, fontSize: 14),
                      ),
                      Text(
                        ls.getPayoutBankName(),
                        style: GoogleFonts.inter(color: DriverShellTheme.textSecondary, fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _ManageInfoRow('bank_details.currency'.tr, 'SEK'),
              _ManageInfoRow('bank_details.min_payout'.tr, '100 SEK'),
              _ManageInfoRow('bank_details.schedule'.tr, 'bank_details.schedule_value'.tr),
              _ManageInfoRow('bank_details.arrival'.tr, 'bank_details.arrival_value'.tr),
              const SizedBox(height: 14),
              _ManageTile(
                title: 'bank_details.edit'.tr,
                onTap: controller.goToEditForm,
              ),
              _ManageTile(
                title: 'bank_details.change_method'.tr,
                onTap: controller.goToEditForm,
              ),
              _ManageTile(
                title: 'bank_details.history'.tr,
                onTap: () => Get.snackbar('bank_details.history'.tr, 'bank_details.history_hint'.tr),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ManageInfoRow extends StatelessWidget {
  const _ManageInfoRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: DriverShellTheme.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: DriverShellTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ManageTile extends StatelessWidget {
  const _ManageTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: DriverShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: DriverShellTheme.textPrimary,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: DriverShellTheme.textSecondary.withValues(alpha: 0.7)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
