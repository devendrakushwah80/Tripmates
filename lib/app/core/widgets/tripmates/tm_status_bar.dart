import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/app_colors.dart';

/// Matches `.sb` â€” time + battery row.
class TmStatusBar extends StatelessWidget {
  const TmStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 10),
      color: TripMatesColors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: TripMatesColors.white,
            ),
          ),
          Row(
            children: [
              Text(
                '5G',
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: TripMatesColors.white,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '100%',
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: TripMatesColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

