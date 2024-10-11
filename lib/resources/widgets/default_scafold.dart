import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/loading_overlay.dart';
import 'package:nb_utils/nb_utils.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final bool centerTile;
  final String title;
  final bool busy;
  final bool showAppBar, includeAppBarBackButton;
  final bool showAppBarWithStringTitle;
  final Color backgroundColor;
  final Widget? bottomSheet;
  final VoidCallback? overrideBackButton;
  final double? scale;

  const DefaultScaffold(
      {Key? key,
      this.showAppBar = true,
      required this.body,
      this.centerTile = true,
      this.title = "",
      this.busy = false,
      this.backgroundColor = Colors.white,
      this.showAppBarWithStringTitle = true,
      this.includeAppBarBackButton = true,
      this.bottomSheet,
      this.overrideBackButton,
      this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.white,
        appBar: showAppBar
            ? AppBar(
                elevation: 0,
                title: showAppBarWithStringTitle
                    ? Text(title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4B413A)))
                    : Image.asset(AssetUtil.limcadLogo, scale: scale ?? 4.0),
                centerTitle: centerTile,
                leading: !includeAppBarBackButton
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          if (overrideBackButton != null) {
                            overrideBackButton!();
                            return;
                          }

                          Navigator.pop(context);
                        },
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 10),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: 20,
                              color: CustomColors.limcadPrimary,
                            ),
                          ),
                        ),
                      ),
              )
            : const PreferredSize(
                preferredSize: Size(0, 0),
                child: SizedBox(),
              ),
        body: SafeArea(
            child: body.animate().fadeIn(
                duration: 350.ms,
                delay: Duration.zero,
                curve: Curves.easeInOut)),
        bottomSheet: bottomSheet,
      ),
      const LoadingOverlay().hideIf(!busy)
    ]);
  }
}

class DefaultScaffold2 extends StatelessWidget {
  final Widget body;
  final bool centerTile;
  final String title;
  final List<Widget>? actions;
  final bool busy;
  final bool showAppBar, includeAppBarBackButton;
  final bool showAppBarWithStringTitle;
  final Color backgroundColor;
  final Widget? bottomSheet;
  final VoidCallback? overrideBackButton;
  final double? scale;

  const DefaultScaffold2(
      {Key? key,
      this.showAppBar = true,
      required this.body,
      this.centerTile = true,
      this.title = "",
      this.busy = false,
      this.actions,
      this.backgroundColor = Colors.white,
      this.showAppBarWithStringTitle = true,
      this.includeAppBarBackButton = true,
      this.bottomSheet,
      this.overrideBackButton,
      this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: backgroundColor,
        appBar: showAppBar
            ? AppBar(
                elevation: 0,
                title: Text(
                  title,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: CustomColors.blackPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 32),
                ),
                centerTitle: false,
            actions:  actions,
                leading: !includeAppBarBackButton
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (overrideBackButton != null) {
                                overrideBackButton!();
                                return;
                              }

                              Navigator.pop(context);
                            },
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 10),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 20,
                                  color: CustomColors.limcadPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16),
              )
            : const PreferredSize(
                preferredSize: Size(0, 0),
                child: SizedBox(),
              ),
        body: SafeArea(
            child: body.animate().fadeIn(
                duration: 350.ms,
                delay: Duration.zero,
                curve: Curves.easeInOut)),
        bottomSheet: bottomSheet,
      ),
      const LoadingOverlay().hideIf(!busy)
    ]);
  }
}
