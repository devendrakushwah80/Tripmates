import '../../../core/widgets/auth/tm_auth_layout.dart';

/// Shared rhythm for signup / verify / driver chrome — delegates to [TmAuthLayout].
abstract final class SignupFlowLayout {
  static const double hPad = TmAuthLayout.hPad;
  static const double topPad = TmAuthLayout.topPad;
  static const double bottomPad = TmAuthLayout.bottomPad;
  static const double bodyBottomPad = TmAuthLayout.bodyBottomPad;
  static const double scrollBottomPad = TmAuthLayout.scrollBottomPad;
  static const double aboveBottomBar = TmAuthLayout.aboveBottomBar;
  static const double sectionGap = TmAuthLayout.sectionGap;
  static const double tightGap = TmAuthLayout.tightGap;
  static const double betweenPrimarySecondary = TmAuthLayout.betweenPrimarySecondary;
}
