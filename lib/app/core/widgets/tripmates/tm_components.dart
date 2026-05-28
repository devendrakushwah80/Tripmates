import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/app_colors.dart';

class TmFakeField extends StatelessWidget {
  const TmFakeField({super.key, required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: TripMatesColors.green, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hint,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TmCard extends StatelessWidget {
  const TmCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(TripMatesColors.radiusMd),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.25)),
      ),
      child: child,
    );
  }
}

class TmGlossCard extends StatelessWidget {
  const TmGlossCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final r = BorderRadius.circular(TripMatesColors.radiusMd);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: r,
        border: Border.all(
          color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.65),
        ),
        color: scheme.surface,
        boxShadow: TripMatesColors.glossyCardShadow,
      ),
      child: ClipRRect(
        borderRadius: r,
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: isDark ? 0.1 : 0.42),
                        Colors.white.withValues(alpha: isDark ? 0.04 : 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -20,
              top: -30,
              child: IgnorePointer(
                child: Container(
                  width: 140,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: isDark ? 0.08 : 0.35),
                        Colors.white.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}

class TmTile extends StatelessWidget {
  const TmTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: TripMatesColors.green),
      title: Text(
        title,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: scheme.onSurface.withValues(alpha: 0.45),
      ),
    );
  }
}

class TmRowToggle extends StatelessWidget {
  const TmRowToggle({super.key, required this.label, required this.on});

  final String label;
  final bool on;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ),
            Container(
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: on
                    ? TripMatesColors.green
                    : scheme.outline.withValues(alpha: 0.45),
              ),
              alignment: on ? Alignment.centerRight : Alignment.centerLeft,
              padding: const EdgeInsets.all(4),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TmPrimaryButton extends StatefulWidget {
  const TmPrimaryButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  State<TmPrimaryButton> createState() => _TmPrimaryButtonState();
}

class _TmPrimaryButtonState extends State<TmPrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shine;

  @override
  void initState() {
    super.initState();
    _shine = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(TripMatesColors.radiusSm);
    return Material(
      color: Colors.transparent,
      borderRadius: r,
      elevation: 0,
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: r,
        child: AnimatedBuilder(
          animation: _shine,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: r,
                boxShadow: TripMatesColors.primaryButtonShadow,
                gradient: LinearGradient(
                  begin: Alignment(-1.2 + _shine.value * 2.6, -0.5),
                  end: Alignment(0.2 + _shine.value * 2.6, 0.8),
                  colors: [
                    TripMatesColors.green,
                    Color.lerp(
                      TripMatesColors.green,
                      TripMatesColors.greenLight,
                      0.35,
                    )!,
                    TripMatesColors.green,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
                border: Border.all(
                  color: Color.lerp(
                    Colors.white.withValues(alpha: 0.14),
                    Colors.white.withValues(alpha: 0.45),
                    (math.sin(_shine.value * math.pi * 2) + 1) / 2,
                  )!,
                  width: 1.2,
                ),
              ),
              alignment: Alignment.center,
              child: child,
            );
          },
          child: Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: TripMatesColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class TmGlossyButton extends StatelessWidget {
  const TmGlossyButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Material(
        color: TripMatesColors.green,
        borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
        elevation: 0,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
              boxShadow: TripMatesColors.glossyButtonShadow,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: isDark
                          ? TripMatesColors.glossyGradientDark
                          : TripMatesColors.glossyGradientLight,
                      borderRadius: BorderRadius.circular(
                        TripMatesColors.radiusSm,
                      ),
                    ),
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: TripMatesColors.white,
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

class TmStepButton extends StatelessWidget {
  const TmStepButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? scheme.surfaceContainerHighest : TripMatesColors.off,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: isDark ? scheme.onSurface : TripMatesColors.blue,
        ),
      ),
    );
  }
}
