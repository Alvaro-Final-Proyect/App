import 'package:flutter/cupertino.dart';
import '../res/resolutions_breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayout({Key? key, required this.mobileBody, required this.desktopBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < Breakpoints.tablet) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}