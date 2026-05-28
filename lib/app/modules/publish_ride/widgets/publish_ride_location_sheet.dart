import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/publish_ride_controller.dart';
import '../../driver_shell/theme/driver_shell_theme.dart';
import '../../../core/maps/geo_place.dart';

class PublishRideLocationSheet extends StatefulWidget {
  const PublishRideLocationSheet({super.key, required this.forOrigin});

  final bool forOrigin;

  @override
  State<PublishRideLocationSheet> createState() => _PublishRideLocationSheetState();
}

class _PublishRideLocationSheetState extends State<PublishRideLocationSheet> {
  final _query = TextEditingController();
  final _focus = FocusNode();
  Timer? _debounce;
  List<GeoPlace> _results = [];
  bool _loading = false;

  PublishRideController get _c => Get.find<PublishRideController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 420), () => _runSearch(q));
  }

  Future<void> _runSearch(String q) async {
    final t = q.trim();
    if (t.length < 2) {
      setState(() {
        _results = [];
        _loading = false;
      });
      return;
    }
    setState(() => _loading = true);
    try {
      final list = await _c.searchPlaces(t);
      if (mounted) setState(() => _results = list);
    } catch (_) {
      if (mounted) setState(() => _results = []);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _pick(GeoPlace p) {
    if (widget.forOrigin) {
      _c.setOrigin(p);
    } else {
      _c.setDestination(p);
    }
    Get.back<void>();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = widget.forOrigin
        ? 'publish_ride.pick_origin'.tr
        : 'publish_ride.pick_destination'.tr;

    return Material(
      color: scheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: DriverShellTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _query,
                focusNode: _focus,
                onChanged: _onChanged,
                decoration: InputDecoration(
                  hintText: 'publish_ride.search_hint'.tr,
                  filled: true,
                  fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.25)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.25)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: DriverShellTheme.primaryGreen, width: 1.4),
                  ),
                  prefixIcon: Icon(Icons.search_rounded, color: DriverShellTheme.textSecondary),
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.45,
                ),
                child: _loading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator(strokeWidth: 2.2)),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: _results.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final p = _results[i];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            leading: Icon(Icons.place_outlined, color: DriverShellTheme.primaryGreen),
                            title: Text(
                              p.shortLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: DriverShellTheme.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              p.displayName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: DriverShellTheme.textSecondary,
                                height: 1.25,
                              ),
                            ),
                            onTap: () => _pick(p),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
