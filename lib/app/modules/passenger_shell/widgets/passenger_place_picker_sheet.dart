import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/maps/geo_place.dart';
import '../../../core/maps/nominatim_geocode_service.dart';
import '../theme/passenger_shell_theme.dart';

/// Search-and-pick a place (same interaction pattern as publish ride).
class PassengerPlacePickerSheet extends StatefulWidget {
  const PassengerPlacePickerSheet({super.key, required this.forOrigin});

  final bool forOrigin;

  @override
  State<PassengerPlacePickerSheet> createState() =>
      _PassengerPlacePickerSheetState();
}

class _PassengerPlacePickerSheetState extends State<PassengerPlacePickerSheet> {
  final _query = TextEditingController();
  final _focus = FocusNode();
  Timer? _debounce;
  List<GeoPlace> _results = [];
  bool _loading = false;

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
      final list = await NominatimGeocodeService.search(t);
      if (mounted) setState(() => _results = list);
    } catch (_) {
      if (mounted) setState(() => _results = []);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _pick(GeoPlace p) {
    Get.back(result: p);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.forOrigin
        ? 'publish_ride.pick_origin'.tr
        : 'publish_ride.pick_destination'.tr;

    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: 12,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 14,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: PassengerShellTheme.textSecondary.withValues(
                      alpha: 0.15,
                    ),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              Text(
                title,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: PassengerShellTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _query,
                focusNode: _focus,
                onChanged: _onChanged,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: PassengerShellTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'publish_ride.search_hint'.tr,
                  filled: true,
                  fillColor: PassengerShellTheme.softGreenBg.withValues(
                    alpha: 0.45,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: PassengerShellTheme.primaryGreen.withValues(
                        alpha: 0.12,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: PassengerShellTheme.primaryGreen.withValues(
                        alpha: 0.12,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: PassengerShellTheme.primaryGreen,
                      width: 1.2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: PassengerShellTheme.textSecondary.withValues(
                      alpha: 0.85,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.45,
                ),
                child: _loading
                    ? Center(
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: PassengerShellTheme.primaryGreen.withValues(
                              alpha: 0.85,
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: _results.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: PassengerShellTheme.textSecondary.withValues(
                            alpha: 0.08,
                          ),
                        ),
                        itemBuilder: (context, i) {
                          final p = _results[i];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 2,
                            ),
                            leading: Icon(
                              Icons.place_outlined,
                              color: PassengerShellTheme.primaryGreen
                                  .withValues(alpha: 0.9),
                            ),
                            title: Text(
                              p.shortLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: PassengerShellTheme.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              p.displayName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: PassengerShellTheme.textSecondary,
                                height: 1.35,
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
