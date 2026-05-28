import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/money/app_money.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../services/local_storage_services/local_storage_services.dart';

class PaymentsWalletView extends StatelessWidget {
  const PaymentsWalletView({super.key});

  bool get _swishEligible => LocalStorageService().getBillingCountryCode() == 'SE';

  @override
  Widget build(BuildContext context) {
    final paid = LocalStorageService().getAppUnlockPaid();
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Payments', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Text(
                    'TripMates business model',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'One-time app access and per-announcement driver fees. Methods shown match your billing country.',
                    style: GoogleFonts.nunito(
                      color: scheme.onSurface.withValues(alpha: 0.72),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _PriceWalletTile(
                    title: 'App download (one-time)',
                    amountLabel: AppMoney.formatSek(99),
                    done: paid,
                    onPay: () async {
                      await LocalStorageService().setAppUnlockPaid(true);
                      Get.snackbar('Demo', 'App access marked as paid on this device.');
                      Get.back<void>();
                    },
                  ),
                  const SizedBox(height: 12),
                  _PriceWalletTile(
                    title: 'Driver trip announcement',
                    amountLabel: AppMoney.formatSek(15),
                    subtitle: 'Charged when you publish a ride',
                    done: false,
                    onPay: () => Get.snackbar('Demo', 'Would charge 15 SEK via selected method.'),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Payment methods',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  _method(Icons.credit_card, 'Credit card'),
                  _method(Icons.payment, 'Debit card'),
                  _method(Icons.account_balance_wallet_outlined, 'PayPal'),
                  if (_swishEligible) _method(Icons.flash_on_rounded, 'Swish (Sweden)'),
                  if (!_swishEligible)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Swish is hidden outside Sweden for a cleaner checkout.',
                        style: GoogleFonts.nunito(
                          fontSize: 13,
                          color: scheme.onSurface.withValues(alpha: 0.55),
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

class _PriceWalletTile extends StatelessWidget {
  const _PriceWalletTile({
    required this.title,
    required this.amountLabel,
    required this.onPay,
    this.subtitle,
    this.done = false,
  });

  final String title;
  final String amountLabel;
  final String? subtitle;
  final bool done;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: scheme.onSurface)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: GoogleFonts.nunito(fontSize: 13, color: scheme.onSurface.withValues(alpha: 0.55))),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                amountLabel,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: TripMatesColors.green,
                ),
              ),
              const Spacer(),
              if (done)
                Chip(
                  label: const Text('Paid'),
                  avatar: const Icon(Icons.check, size: 18),
                  backgroundColor: TripMatesColors.chipSuccess,
                )
              else
                FilledButton(onPressed: onPay, child: const Text('Pay (demo)')),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _method(IconData icon, String label) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: TripMatesColors.sky,
      child: Icon(icon, color: TripMatesColors.accent),
    ),
    title: Text(label, style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => Get.snackbar('Demo', '$label checkout would open here.'),
  );
}
