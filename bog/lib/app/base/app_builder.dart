import 'package:flutter/material.dart';

import '../../core/widgets/loading_widget/ui/loading_screen.dart';
import '../../core/widgets/popup_widget/ui/popup_screen.dart';



class AppBuilder extends StatelessWidget {

  final ThemeData theme;
  final Widget Function(ThemeData theme) builder;
  const AppBuilder({required this.theme,
    required this.builder,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: Stack(
          children: [
            builder(theme),
            popupWidget,
            loadingWidget,
          ],
        ),
    ));
  }

  Widget get popupWidget => const PopupScreen();

  Widget get loadingWidget => const LoadingScreen();

}
