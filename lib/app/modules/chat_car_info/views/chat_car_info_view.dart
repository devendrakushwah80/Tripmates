import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../controllers/chat_car_info_controller.dart';

class ChatCarInfoScreenContent extends StatelessWidget {
  const ChatCarInfoScreenContent({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TmMintAppBar(title: "Yassin's Ride", showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(16),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TmCard(
                    child: ListTile(
                      leading: const Icon(Icons.chat_bubble_outline, color: TripMatesColors.green),
                      title: Text('Open chat', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TmCard(
                    child: ListTile(
                      leading: const Icon(Icons.directions_car_outlined, color: TripMatesColors.green),
                      title: Text('Car info', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatCarInfoView extends GetView<ChatCarInfoController> {
  const ChatCarInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: ChatCarInfoScreenContent(showBack: true)),
    );
  }
}

