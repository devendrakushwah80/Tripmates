import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'passenger_shell_assets.dart';
import '../theme/passenger_shell_theme.dart';

/// Road-style map with pickup (placeholder), drop (pin), optional animated driver (car).
/// Uses the same Carto Voyager tiles as the driver flow for a consistent “live map” feel.
class PassengerRoadTrackingMap extends StatefulWidget {
  const PassengerRoadTrackingMap({
    super.key,
    required this.height,
    this.animateDriver = true,
  });

  final double height;
  final bool animateDriver;

  /// Demo corridor (Jaipur → Delhi) — dummy geometry, visually realistic path.
  static List<LatLng> get demoRoute => const [
        LatLng(26.9124, 75.7873),
        LatLng(27.02, 75.95),
        LatLng(27.18, 76.22),
        LatLng(27.42, 76.55),
        LatLng(27.68, 76.92),
        LatLng(27.95, 77.22),
        LatLng(28.18, 77.45),
        LatLng(28.42, 77.62),
        LatLng(28.7041, 77.1025),
      ];

  @override
  State<PassengerRoadTrackingMap> createState() => _PassengerRoadTrackingMapState();
}

class _PassengerRoadTrackingMapState extends State<PassengerRoadTrackingMap> with SingleTickerProviderStateMixin {
  AnimationController? _drive;

  static const _pickupAsset = PassengerShellAssets.passengerMarker;
  static const _dropAsset = PassengerShellAssets.dropIcon;
  static const _carAsset = PassengerShellAssets.carMarker;

  @override
  void initState() {
    super.initState();
    if (widget.animateDriver) {
      _drive = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
      _drive!.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _drive?.dispose();
    super.dispose();
  }

  static double _segmentLength(LatLng a, LatLng b) {
    const d = Distance();
    return d.distance(a, b);
  }

  static LatLng _interpolateAlong(List<LatLng> pts, double t) {
    if (pts.isEmpty) return const LatLng(0, 0);
    if (pts.length == 1) return pts.first;
    t = t.clamp(0.0, 1.0);
    var total = 0.0;
    final segLens = <double>[];
    for (var i = 0; i < pts.length - 1; i++) {
      final l = _segmentLength(pts[i], pts[i + 1]);
      segLens.add(l);
      total += l;
    }
    if (total <= 0) return pts.first;
    var target = total * t;
    for (var i = 0; i < pts.length - 1; i++) {
      final l = segLens[i];
      if (target <= l) {
        final u = l == 0 ? 0.0 : target / l;
        return LatLng(
          pts[i].latitude + (pts[i + 1].latitude - pts[i].latitude) * u,
          pts[i].longitude + (pts[i + 1].longitude - pts[i].longitude) * u,
        );
      }
      target -= l;
    }
    return pts.last;
  }

  static double _bearingRad(LatLng a, LatLng b) {
    final lat1 = a.latitude * math.pi / 180;
    final lat2 = b.latitude * math.pi / 180;
    final dLon = (b.longitude - a.longitude) * math.pi / 180;
    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    return math.atan2(y, x);
  }

  @override
  Widget build(BuildContext context) {
    final pts = PassengerRoadTrackingMap.demoRoute;
    final pickup = pts.first;
    final dropoff = pts.last;
    final bounds = LatLngBounds.fromPoints(pts);

    final markers = <Marker>[
      Marker(
        point: pickup,
        width: 44,
        height: 52,
        alignment: Alignment.bottomCenter,
        child: const _MapImageMarker(asset: _pickupAsset, size: 40),
      ),
      Marker(
        point: dropoff,
        width: 44,
        height: 52,
        alignment: Alignment.bottomCenter,
        child: const _MapImageMarker(asset: _dropAsset, size: 40),
      ),
    ];
    if (widget.animateDriver) {
      final t = _drive?.value ?? 0;
      final driver = _interpolateAlong(pts, t);
      final ahead = _interpolateAlong(pts, math.min(1.0, t + 0.02));
      final bearing = _bearingRad(driver, ahead);
      markers.add(
        Marker(
          point: driver,
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: bearing + math.pi / 2,
            child: const _MapImageMarker(asset: _carAsset, size: 44, shadow: true),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: widget.height,
        child: FlutterMap(
          options: MapOptions(
            initialCameraFit: CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 36),
            ),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
              subdomains: const ['a', 'b', 'c', 'd'],
              userAgentPackageName: 'dev.flutter.tripmates',
              retinaMode: RetinaMode.isHighDensity(context),
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: pts,
                  color: Colors.white,
                  strokeWidth: 9,
                ),
                Polyline(
                  points: pts,
                  color: const Color(0xFF1A73E8),
                  strokeWidth: 5,
                ),
              ],
            ),
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }
}

class _MapImageMarker extends StatelessWidget {
  const _MapImageMarker({required this.asset, required this.size, this.shadow = false});

  final String asset;
  final double size;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.place_rounded, size: size * 0.7, color: PassengerShellTheme.primaryGreen),
      ),
    );
  }
}
