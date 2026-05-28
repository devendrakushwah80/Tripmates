import 'package:flutter/material.dart';

export 'signup_flow_tokens.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import 'signup_flow_tokens.dart';
import 'signup_step_header.dart';

/// Header + body + bottom actions — hero + overlapping sheet; **no scrolling** by default
/// (content scales down slightly on very small screens via [FittedBox]).
class SignupFlowPageScaffold extends StatelessWidget {
  const SignupFlowPageScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.scrollable,
    this.bottom = const <Widget>[],

    /// When true, uses a fixed-height viewport for children that contain [Expanded]
    /// (e.g. legacy flex layouts). Prefer false + intrinsic height + [FittedBox].
    this.scrollBody = false,
  });

  final int step;
  final String title;
  final Widget scrollable;
  final List<Widget> bottom;
  final bool scrollBody;

  @override
  Widget build(BuildContext context) {
    final bottomWidget = bottom.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: bottom,
          )
        : null;

    return TmAuthHeroShell(
      bottom: bottomWidget,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SignupStepHeader(step: step, title: title),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    SignupFlowLayout.hPad,
                    SignupFlowLayout.topPad,
                    SignupFlowLayout.hPad,
                    SignupFlowLayout.bodyBottomPad,
                  ),
                  child: scrollable,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
