import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/curated_images.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_logo.dart';
import '../controllers/home_controller.dart';

/// Premium home hub — drawer, header, search, sections (TripMates features only).
class HomeHubBody extends StatelessWidget {
  const HomeHubBody({
    super.key,
    this.onOpenDrawer,
    this.onHeroSearchTap,
    this.onWalletTap,
    this.onSearchTap,
    this.onMakeRideTap,
    this.onAccountTap,
    this.onViewTripTap,
    this.onMyGarageTap,
    this.onTripPreferencesTap,
    this.onPassengerModeTap,
    this.onPaymentWalletTap,
    this.onMyRidesTap,
    this.onTripHistoryTap,
    this.isLoading = false,
  });

  final VoidCallback? onOpenDrawer;
  final VoidCallback? onHeroSearchTap;
  final VoidCallback? onWalletTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onMakeRideTap;
  final VoidCallback? onAccountTap;
  final VoidCallback? onViewTripTap;
  final VoidCallback? onMyGarageTap;
  final VoidCallback? onTripPreferencesTap;
  final VoidCallback? onPassengerModeTap;
  final VoidCallback? onPaymentWalletTap;
  final VoidCallback? onMyRidesTap;
  final VoidCallback? onTripHistoryTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        children: const [
          _SkeletonBox(height: 88, radius: 44),
          SizedBox(height: 12),
          _SkeletonBox(height: 30),
          SizedBox(height: 12),
          _SkeletonBox(height: 72),
          SizedBox(height: 12),
          _SkeletonBox(height: 72),
        ],
      );
    }

    final bgSoft = isDark ? AppColors.darkSurface : AppColors.backgroundLight;

    return ColoredBox(
      color: bgSoft,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PremiumHomeHeader(
              onMenu: onOpenDrawer ?? () {},
              onSearch: onHeroSearchTap ?? () {},
              onWallet: onWalletTap ?? () {},
            ),
            const SizedBox(height: 14),
            _PremiumSearchBar(onTap: onHeroSearchTap ?? () {}),
            const SizedBox(height: 20),
            Text(
              'home.quick_actions'.tr,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: scheme.onSurface.withValues(alpha: 0.52),
              ),
            ),
            const SizedBox(height: 10),
            _QuickActionGrid(
              onSearch: onSearchTap,
              onPublish: onMakeRideTap,
              onMyRides: onMyRidesTap,
              onGarage: onMyGarageTap,
            ),
            const SizedBox(height: 22),
            _SectionTitle(title: 'home.trending'.tr, actionLabel: 'home.view_all'.tr, onAction: onSearchTap),
            const SizedBox(height: 10),
            _ChipRow(onSearch: onSearchTap),
            const SizedBox(height: 12),
            SizedBox(
              height: 188,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  _TrendingCard(
                    title: 'home.trend_1_title'.tr,
                    subtitle: 'home.trend_1_sub'.tr,
                    tint: const Color(0xFF1B6FA8),
                    imageUrl: CuratedImages.openRoad,
                    onTap: onSearchTap,
                  ),
                  _TrendingCard(
                    title: 'home.trend_2_title'.tr,
                    subtitle: 'home.trend_2_sub'.tr,
                    tint: TripMatesColors.green,
                    imageUrl: CuratedImages.cabNight,
                    onTap: onSearchTap,
                  ),
                  _TrendingCard(
                    title: 'home.trend_3_title'.tr,
                    subtitle: 'home.trend_3_sub'.tr,
                    tint: const Color(0xFF7C3AED),
                    imageUrl: CuratedImages.forestTrail,
                    onTap: onSearchTap,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _SectionTitle(title: 'home.offers'.tr, actionLabel: 'home.view_all'.tr, onAction: onSearchTap),
            const SizedBox(height: 10),
            SizedBox(
              height: 124,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  _OfferStripCard(
                    title: 'home.offer_1_title'.tr,
                    subtitle: 'home.offer_1_sub'.tr,
                    imageUrl: CuratedImages.highwayMotion,
                    onTap: onSearchTap,
                  ),
                  _OfferStripCard(
                    title: 'home.offer_2_title'.tr,
                    subtitle: 'home.offer_2_sub'.tr,
                    imageUrl: CuratedImages.cityDusk,
                    onTap: onSearchTap,
                  ),
                  _OfferStripCard(
                    title: 'home.offer_3_title'.tr,
                    subtitle: 'home.offer_3_sub'.tr,
                    imageUrl: CuratedImages.carInterior,
                    onTap: onSearchTap,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _SectionTitle(title: 'home.nearby'.tr, actionLabel: 'home.explore'.tr, onAction: onSearchTap),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _GetawayCard(
                    title: 'home.getaway_1_title'.tr,
                    km: 'home.getaway_1_km'.tr,
                    imageUrl: CuratedImages.lakeNature,
                    onTap: onSearchTap,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _GetawayCard(
                    title: 'home.getaway_2_title'.tr,
                    km: 'home.getaway_2_km'.tr,
                    imageUrl: CuratedImages.forestTrail,
                    onTap: onSearchTap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            _SectionTitle(title: 'home.whats_new'.tr, actionLabel: '', onAction: null),
            const SizedBox(height: 10),
            _WhatsNewRow(
              onTripPrefs: onTripPreferencesTap,
              onPassenger: onPassengerModeTap,
              onLive: onViewTripTap,
              onHistory: onTripHistoryTap,
            ),
            const SizedBox(height: 22),
            _SectionTitle(title: 'home.discover'.tr, actionLabel: '', onAction: null),
            const SizedBox(height: 10),
            _DiscoverGrid(
              onTripPrefs: onTripPreferencesTap,
              onPassenger: onPassengerModeTap,
              onHistory: onTripHistoryTap,
            ),
            const SizedBox(height: 22),
            _SectionTitle(title: 'home.refer'.tr, actionLabel: 'home.rewards'.tr, onAction: onPaymentWalletTap),
            const SizedBox(height: 10),
            TmGlossCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: TripMatesColors.chipSuccess,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: PhosphorIcon(
                      PhosphorIconsRegular.shareNetwork,
                      color: TripMatesColors.green,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'home.invite_title'.tr,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'home.invite_body'.tr,
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            height: 1.35,
                            color: scheme.onSurface.withValues(alpha: 0.65),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PhosphorIcon(
                    PhosphorIconsRegular.caretRight,
                    color: scheme.onSurface.withValues(alpha: 0.35),
                    size: 22,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            TmGlossCard(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'home.up_next'.tr,
                    style: GoogleFonts.poppins(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Thu, Apr 9 · 16:26 · Ludvika → Gävle',
                    style: GoogleFonts.nunito(
                      color: scheme.onSurface.withValues(alpha: 0.65),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton(
                      onPressed: onViewTripTap,
                      child: Text('home.view_trip'.tr),
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

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: _HomeDrawer(controller: controller),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: Obx(
                () => HomeHubBody(
                  onOpenDrawer: () => controller.scaffoldKey.currentState?.openDrawer(),
                  onHeroSearchTap: controller.openSearch,
                  onWalletTap: controller.openPaymentsWallet,
                  onSearchTap: controller.openSearch,
                  onMakeRideTap: controller.openMakeRide,
                  onAccountTap: controller.openAccount,
                  onViewTripTap: controller.openRideDetail,
                  onMyGarageTap: controller.openMyGarage,
                  onTripPreferencesTap: controller.openTripPreferences,
                  onPassengerModeTap: controller.openPassengerMode,
                  onPaymentWalletTap: controller.openPaymentsWallet,
                  onMyRidesTap: controller.openMyRides,
                  onTripHistoryTap: controller.openTripHistory,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TmBottomNav(selectedIndex: 0, onTap: controller.onBottomNav),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer({required this.controller});

  final HomeController controller;

  void _go(VoidCallback fn) {
    Get.back<void>();
    fn();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: scheme.surface,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    TripMatesColors.green.withValues(alpha: 0.12),
                    scheme.surface,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    const TmLogo(size: 44),
                    const SizedBox(width: 12),
                    Text(
                      'app.name'.tr,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: PhosphorIcon(PhosphorIconsRegular.carSimple, color: TripMatesColors.green, size: 24),
              title: Text('drawer.my_trips'.tr, style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
              onTap: () => _go(controller.openMyRides),
            ),
            ListTile(
              leading: PhosphorIcon(PhosphorIconsRegular.heart, color: TripMatesColors.accent, size: 24),
              title: Text('drawer.wishlist'.tr, style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
              onTap: () => _go(controller.openWishlist),
            ),
            ListTile(
              leading: PhosphorIcon(PhosphorIconsRegular.gift, color: TripMatesColors.green, size: 24),
              title: Text('drawer.rewards'.tr, style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
              onTap: () => _go(controller.openPaymentsWallet),
            ),
            const Divider(height: 1),
            ListTile(
              leading: PhosphorIcon(
                PhosphorIconsRegular.gearSix,
                color: scheme.onSurface.withValues(alpha: 0.7),
                size: 24,
              ),
              title: Text('drawer.settings'.tr, style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
              onTap: () => _go(controller.openSettings),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumHomeHeader extends StatelessWidget {
  const _PremiumHomeHeader({
    required this.onMenu,
    required this.onSearch,
    required this.onWallet,
  });

  final VoidCallback onMenu;
  final VoidCallback onSearch;
  final VoidCallback onWallet;

  static const double _gap = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            _GlossIconButton(icon: PhosphorIconsRegular.list, onTap: onMenu),
            const SizedBox(width: _gap),
            const TmLogo(size: 52),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            _GlossIconButton(icon: PhosphorIconsRegular.magnifyingGlass, onTap: onSearch),
            const SizedBox(width: _gap),
            _GlossIconButton(icon: PhosphorIconsRegular.wallet, onTap: onWallet),
          ],
        ),
      ],
    );
  }
}

class _GlossIconButton extends StatelessWidget {
  const _GlossIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: scheme.surface,
            border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
          ),
          child: Center(
            child: PhosphorIcon(icon, size: 22, color: scheme.onSurface.withValues(alpha: 0.78)),
          ),
        ),
      ),
    );
  }
}

class _PremiumSearchBar extends StatelessWidget {
  const _PremiumSearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: scheme.surface,
            border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              PhosphorIcon(
                PhosphorIconsRegular.magnifyingGlass,
                color: TripMatesColors.green.withValues(alpha: 0.82),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'home.search_placeholder'.tr,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    color: scheme.onSurface.withValues(alpha: 0.48),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              PhosphorIcon(
                PhosphorIconsRegular.slidersHorizontal,
                color: scheme.onSurface.withValues(alpha: 0.38),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionGrid extends StatelessWidget {
  const _QuickActionGrid({
    required this.onSearch,
    required this.onPublish,
    this.onMyRides,
    this.onGarage,
  });

  final VoidCallback? onSearch;
  final VoidCallback? onPublish;
  final VoidCallback? onMyRides;
  final VoidCallback? onGarage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MiniAction(icon: PhosphorIconsRegular.magnifyingGlass, label: 'home.search_rides'.tr, onTap: onSearch),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MiniAction(icon: PhosphorIconsRegular.roadHorizon, label: 'home.publish_ride'.tr, onTap: onPublish),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MiniAction(icon: PhosphorIconsRegular.carSimple, label: 'home.my_rides'.tr, onTap: onMyRides),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MiniAction(icon: PhosphorIconsRegular.garage, label: 'home.my_garage'.tr, onTap: onGarage),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniAction extends StatelessWidget {
  const _MiniAction({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TmGlossCard(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: scheme.primaryContainer.withValues(alpha: 0.65),
                border: Border.all(color: TripMatesColors.green.withValues(alpha: 0.12)),
              ),
              child: PhosphorIcon(icon, color: TripMatesColors.green, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.actionLabel,
    this.onAction,
  });

  final String title;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
              height: 1.15,
            ),
          ),
        ),
        if (actionLabel.isNotEmpty && onAction != null)
          TextButton.icon(
            onPressed: onAction,
            icon: PhosphorIcon(PhosphorIconsRegular.arrowRight, size: 18, color: TripMatesColors.accent),
            label: Text(
              actionLabel,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: TripMatesColors.accent,
              ),
            ),
          ),
      ],
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({this.onSearch});

  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget chip(String label, {bool primary = false}) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ActionChip(
          label: Text(label, style: GoogleFonts.nunito(fontWeight: FontWeight.w600, fontSize: 12)),
          onPressed: onSearch,
          side: BorderSide(
            color: primary ? TripMatesColors.green : scheme.outline.withValues(alpha: 0.35),
          ),
          backgroundColor: primary ? TripMatesColors.chipSuccess : scheme.surface,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          chip('All', primary: true),
          chip('Eco routes'),
          chip('Airport'),
          chip('Weekend'),
        ],
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.imageUrl,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Color tint;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            width: 208,
            height: 176,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    headers: CuratedImages.imageRequestHeaders,
                    errorBuilder: (context, error, stackTrace) => ColoredBox(
                      color: tint.withValues(alpha: 0.15),
                      child: Center(child: PhosphorIcon(PhosphorIconsRegular.path, size: 40, color: tint)),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.05),
                          Colors.black.withValues(alpha: 0.52),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: PhosphorIcon(PhosphorIconsRegular.path, color: tint, size: 20),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.88),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OfferStripCard extends StatelessWidget {
  const _OfferStripCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            width: 220,
            height: 124,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: scheme.outline.withValues(alpha: 0.16)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    headers: CuratedImages.imageRequestHeaders,
                    errorBuilder: (context, error, stackTrace) =>
                        ColoredBox(color: scheme.surfaceContainerHighest),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withValues(alpha: 0.55),
                          Colors.black.withValues(alpha: 0.12),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GetawayCard extends StatelessWidget {
  const _GetawayCard({
    required this.title,
    required this.km,
    required this.imageUrl,
    this.onTap,
  });

  final String title;
  final String km;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TmGlossCard(
      padding: EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(TripMatesColors.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 88,
                    width: double.infinity,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      headers: CuratedImages.imageRequestHeaders,
                      errorBuilder: (context, error, stackTrace) => ColoredBox(
                        color: TripMatesColors.sky,
                        child: Center(
                          child: PhosphorIcon(
                            PhosphorIconsRegular.tree,
                            size: 36,
                            color: TripMatesColors.accent.withValues(alpha: 0.55),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: scheme.onSurface,
                  ),
                ),
                Text(
                  km,
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: TripMatesColors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WhatsNewRow extends StatelessWidget {
  const _WhatsNewRow({
    this.onTripPrefs,
    this.onPassenger,
    this.onLive,
    this.onHistory,
  });

  final VoidCallback? onTripPrefs;
  final VoidCallback? onPassenger;
  final VoidCallback? onLive;
  final VoidCallback? onHistory;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _WhatsDot(icon: PhosphorIconsRegular.sliders, label: 'home.whats_trip_prefs'.tr, onTap: onTripPrefs),
        _WhatsDot(icon: PhosphorIconsRegular.seat, label: 'home.whats_passenger'.tr, onTap: onPassenger),
        _WhatsDot(icon: PhosphorIconsRegular.mapPin, label: 'home.whats_live'.tr, onTap: onLive),
        _WhatsDot(icon: PhosphorIconsRegular.clockCounterClockwise, label: 'home.whats_history'.tr, onTap: onHistory),
      ],
    );
  }
}

class _WhatsDot extends StatelessWidget {
  const _WhatsDot({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.surface,
                border: Border.all(color: scheme.outline.withValues(alpha: 0.28), width: 1),
              ),
              child: PhosphorIcon(icon, color: TripMatesColors.green, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoverGrid extends StatelessWidget {
  const _DiscoverGrid({
    this.onTripPrefs,
    this.onPassenger,
    this.onHistory,
  });

  final VoidCallback? onTripPrefs;
  final VoidCallback? onPassenger;
  final VoidCallback? onHistory;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DiscoverTile(
            icon: PhosphorIconsRegular.compass,
            title: 'home.discover_trip_prefs'.tr,
            onTap: onTripPrefs,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _DiscoverTile(
            icon: PhosphorIconsRegular.users,
            title: 'home.discover_passenger'.tr,
            onTap: onPassenger,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _DiscoverTile(
            icon: PhosphorIconsRegular.receipt,
            title: 'home.discover_history'.tr,
            onTap: onHistory,
          ),
        ),
      ],
    );
  }
}

class _DiscoverTile extends StatelessWidget {
  const _DiscoverTile({required this.icon, required this.title, this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TmGlossCard(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            PhosphorIcon(icon, color: TripMatesColors.accent, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                height: 1.2,
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height, this.radius = 12});

  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final fill = Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.85);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
