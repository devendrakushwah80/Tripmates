import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../theme/driver_shell_theme.dart';

/// Dummy wallet — balance & sample transactions (driver earnings).
class DriverWalletView extends StatelessWidget {
  const DriverWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'earnings_detail.wallet_title'.tr, showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: DriverShellTheme.cardWhite,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: DriverShellTheme.cardShadow,
                      border: Border.all(color: DriverShellTheme.textSecondary.withValues(alpha: 0.08)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'earnings_detail.wallet_available_label'.tr,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: DriverShellTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'earnings_detail.wallet_balance_dummy'.tr,
                          style: GoogleFonts.lexend(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: DriverShellTheme.primaryGreen,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'earnings_detail.wallet_pending_hint'.tr,
                          style: GoogleFonts.inter(fontSize: 12, color: DriverShellTheme.textSecondary, height: 1.35),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'earnings_detail.wallet_activity'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: DriverShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _TxTile(
                    icon: Icons.directions_car_outlined,
                    title: 'earnings_detail.tx_ride_1_title'.tr,
                    subtitle: 'earnings_detail.tx_ride_1_sub'.tr,
                    amount: 'earnings_detail.tx_ride_1_amt'.tr,
                    positive: true,
                  ),
                  const SizedBox(height: 8),
                  _TxTile(
                    icon: Icons.publish_outlined,
                    title: 'earnings_detail.tx_fee_title'.tr,
                    subtitle: 'earnings_detail.tx_fee_sub'.tr,
                    amount: 'earnings_detail.tx_fee_amt'.tr,
                    positive: false,
                  ),
                  const SizedBox(height: 8),
                  _TxTile(
                    icon: Icons.account_balance_outlined,
                    title: 'earnings_detail.tx_payout_title'.tr,
                    subtitle: 'earnings_detail.tx_payout_sub'.tr,
                    amount: 'earnings_detail.tx_payout_amt'.tr,
                    positive: false,
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

class _TxTile extends StatelessWidget {
  const _TxTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.positive,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    final amtColor = positive ? DriverShellTheme.primaryGreen : DriverShellTheme.textPrimary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: DriverShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DriverShellTheme.textSecondary.withValues(alpha: 0.1)),
        boxShadow: DriverShellTheme.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: DriverShellTheme.softGreenBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: DriverShellTheme.primaryGreen, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: DriverShellTheme.textSecondary)),
              ],
            ),
          ),
          Text(amount, style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: amtColor)),
        ],
      ),
    );
  }
}

/// Dummy payout transfers list.
class DriverPayoutHistoryView extends StatelessWidget {
  const DriverPayoutHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'earnings_detail.payout_title'.tr, showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: [
                  Text(
                    'earnings_detail.payout_intro'.tr,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.45,
                      color: DriverShellTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PayoutRow(
                    amount: 'earnings_detail.payout_r1_amt'.tr,
                    date: 'earnings_detail.payout_r1_date'.tr,
                    status: 'earnings_detail.payout_status_sent'.tr,
                    done: true,
                  ),
                  const SizedBox(height: 10),
                  _PayoutRow(
                    amount: 'earnings_detail.payout_r2_amt'.tr,
                    date: 'earnings_detail.payout_r2_date'.tr,
                    status: 'earnings_detail.payout_status_sent'.tr,
                    done: true,
                  ),
                  const SizedBox(height: 10),
                  _PayoutRow(
                    amount: 'earnings_detail.payout_r3_amt'.tr,
                    date: 'earnings_detail.payout_r3_date'.tr,
                    status: 'earnings_detail.payout_status_processing'.tr,
                    done: false,
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

class _PayoutRow extends StatelessWidget {
  const _PayoutRow({
    required this.amount,
    required this.date,
    required this.status,
    required this.done,
  });

  final String amount;
  final String date;
  final String status;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DriverShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: DriverShellTheme.cardShadow,
        border: Border.all(color: DriverShellTheme.textSecondary.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Icons.schedule_rounded,
            color: done ? DriverShellTheme.primaryGreen : DriverShellTheme.textSecondary,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(amount, style: GoogleFonts.lexend(fontWeight: FontWeight.w800, fontSize: 17)),
                const SizedBox(height: 4),
                Text(date, style: GoogleFonts.inter(fontSize: 12, color: DriverShellTheme.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: done ? DriverShellTheme.softGreenBg : DriverShellTheme.textSecondary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: done ? DriverShellTheme.primaryGreen : DriverShellTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dummy earnings / tax summary.
class DriverEarningsSummaryView extends StatelessWidget {
  const DriverEarningsSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'earnings_detail.summary_title'.tr, showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: [
                  Text(
                    'earnings_detail.summary_intro'.tr,
                    style: GoogleFonts.inter(fontSize: 14, height: 1.45, color: DriverShellTheme.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  _SummaryCard(
                    child: Column(
                      children: [
                        _SumLine('earnings_detail.summary_gross'.tr, 'earnings_detail.summary_gross_val'.tr, bold: true),
                        const Divider(height: 22),
                        _SumLine('earnings_detail.summary_platform'.tr, 'earnings_detail.summary_platform_val'.tr),
                        const SizedBox(height: 10),
                        _SumLine('earnings_detail.summary_tax_hint'.tr, 'earnings_detail.summary_tax_val'.tr),
                        const Divider(height: 22),
                        _SumLine('earnings_detail.summary_net'.tr, 'earnings_detail.summary_net_val'.tr, bold: true, green: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: DriverShellTheme.softGreenBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: DriverShellTheme.primaryGreen.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline_rounded, color: DriverShellTheme.primaryGreen, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'earnings_detail.summary_disclaimer'.tr,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              height: 1.45,
                              color: DriverShellTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: DriverShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: DriverShellTheme.cardShadow,
        border: Border.all(color: DriverShellTheme.textSecondary.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}

class _SumLine extends StatelessWidget {
  const _SumLine(this.label, this.value, {this.bold = false, this.green = false});

  final String label;
  final String value;
  final bool bold;
  final bool green;

  @override
  Widget build(BuildContext context) {
    final vStyle = GoogleFonts.inter(
      fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
      fontSize: bold ? 16 : 14,
      color: green ? DriverShellTheme.primaryGreen : DriverShellTheme.textPrimary,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Text(value, style: vStyle),
      ],
    );
  }
}
