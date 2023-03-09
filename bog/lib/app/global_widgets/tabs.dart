import 'package:bog/core/theme/app_colors.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/theme/app_styles.dart';
import 'app_input.dart';

enum IndicatorSide { start, end }

/// A vertical tab widget for flutter
class VerticalTabs extends StatefulWidget {
  final int initialIndex;
  final double tabsWidth;
  final double indicatorWidth;
  final IndicatorSide indicatorSide;
  final List<Tab> tabs;
  final List<Widget> contents;
  final TextDirection direction;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color selectedTabBackgroundColor;
  final Color tabBackgroundColor;
  final TextStyle selectedTabTextStyle;
  final TextStyle tabTextStyle;
  final Duration changePageDuration;
  final Curve changePageCurve;
  final Color tabsShadowColor;
  final double tabsElevation;
  final Function(int tabIndex)? onSelect;
  final Color? backgroundColor;

  const VerticalTabs(
      {Key? key,
        required this.tabs,
        required this.contents,
        this.tabsWidth = 200,
        this.indicatorWidth = 3,
        this.indicatorSide = IndicatorSide.end,
        this.initialIndex = 0,
        this.direction = TextDirection.ltr,
        this.indicatorColor = Colors.green,
        this.disabledChangePageFromContentView = false,
        this.contentScrollAxis = Axis.horizontal,
        this.selectedTabBackgroundColor = const Color(0x1100ff00),
        this.tabBackgroundColor = const Color(0xfff8f8f8),
        this.selectedTabTextStyle = const TextStyle(color: Colors.black),
        this.tabTextStyle = const TextStyle(color: Colors.black38),
        this.changePageCurve = Curves.easeInOut,
        this.changePageDuration = const Duration(milliseconds: 300),
        this.tabsShadowColor = Colors.black54,
        this.tabsElevation = 2.0,
        this.onSelect,
        this.backgroundColor})
      : assert(tabs.length == contents.length),
        super(key: key);

  @override
  _VerticalTabsState createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs> with TickerProviderStateMixin {
  late int _selectedIndex;
  bool? _changePageByTapView;

  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = const AlwaysScrollableScrollPhysics();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    for (int i = 0; i < widget.tabs.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    _selectTab(widget.initialIndex);

    if (widget.disabledChangePageFromContentView == true) pageScrollPhysics = const NeverScrollableScrollPhysics();

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.initialIndex);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
//    Border border = Border(
//        right: BorderSide(
//            width: 0.5, color: widget.dividerColor));
//    if (widget.direction == TextDirection.rtl) {
//      border = Border(
//          left: BorderSide(
//              width: 0.5, color: widget.dividerColor));
//    }

    return Directionality(
      textDirection: widget.direction,
      child: Container(
        color: widget.backgroundColor ?? Theme.of(context).canvasColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Material(
                    color: widget.tabBackgroundColor,
                    child: Column(
                      children: [
                        Text('Categories',style: AppTextStyle.subtitle1.copyWith(fontSize: 25 * Get.height * 0.01 * 0.07,color: Colors.black,fontWeight: FontWeight.w500),),
                        SizedBox(height: Get.height*0.02,),
                        SizedBox(
                          width: widget.tabsWidth,
                          height: Get.height*0.7,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: widget.tabs.length,
                            itemBuilder: (context, index) {
                              Tab tab = widget.tabs[index];

                              Alignment alignment = Alignment.centerLeft;
                              if (widget.direction == TextDirection.rtl) {
                                alignment = Alignment.centerRight;
                              }

                              Widget child;
                              if (tab.child != null) {
                                child = tab.child!;
                              } else {
                                child = Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        (tab.text != null)
                                            ? SizedBox(
                                            width: widget.tabsWidth - 50,
                                            child: Text(
                                              tab.text!,
                                              softWrap: true,
                                              textAlign: TextAlign.start,
                                            ))
                                            : Container(),
                                      ],
                                    ));
                              }

                              Color itemBGColor = widget.tabBackgroundColor;
                              if (_selectedIndex == index) itemBGColor = widget.selectedTabBackgroundColor;

                              double? left, right;
                              if (widget.direction == TextDirection.rtl) {
                                left = ((widget.indicatorSide == IndicatorSide.end) ? 0 : null);
                                right = ((widget.indicatorSide == IndicatorSide.start) ? 0 : null);
                              } else {
                                right = ((widget.indicatorSide == IndicatorSide.end) ? 0 : null);
                                left = ((widget.indicatorSide == IndicatorSide.start) ? 0 : null);
                              }

                              return GestureDetector(
                                onTap: () {
                                  _changePageByTapView = true;
                                  setState(() {
                                    _selectTab(index);
                                  });

                                  pageController.animateToPage(index, duration: widget.changePageDuration, curve: widget.changePageCurve);
                                },
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 2,
                                      bottom: 2,
                                      width: widget.indicatorWidth,
                                      left: left,
                                      right: right,
                                      child: ScaleTransition(
                                        scale: Tween(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(
                                            parent: animationControllers[index],
                                            curve: Curves.elasticOut,
                                          ),
                                        ),
                                        child: Container(
                                          color: widget.indicatorColor,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _changePageByTapView = true;
                                        setState(() {
                                          _selectTab(index);
                                        });

                                        pageController.animateToPage(index, duration: widget.changePageDuration, curve: widget.changePageCurve);
                                      },
                                      child: Container(
                                        alignment: alignment,
                                        padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                                        child: child,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.5,
                    color: AppColors.grey.withOpacity(.2),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text((widget.tabs[_selectedIndex].child as Text).data.toString(),style: AppTextStyle.subtitle1.copyWith(fontSize: 25 * Get.height * 0.01 * 0.07,color: Colors.black,fontWeight: FontWeight.w500),),
                        SizedBox(height: Get.height*0.02,),
                        Padding(
                          padding: EdgeInsets.only(left: Get.width*0.038,right: Get.width*0.038),
                          child: AppInput(
                            hintText: 'Search with keyword ...',
                            filledColor: Colors.grey.withOpacity(.1),
                            prefexIcon: Icon(
                              FeatherIcons.search,
                              color: Colors.black.withOpacity(.5),
                              size: Get.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height*0.02,),
                        Expanded(
                          child: SizedBox(
                            height: Get.height*0.68,
                            child: PageView.builder(
                              scrollDirection: widget.contentScrollAxis,
                              physics: pageScrollPhysics,
                              onPageChanged: (index) {
                                if (_changePageByTapView == false || _changePageByTapView == null) {
                                  _selectTab(index);
                                }
                                if (_selectedIndex == index) {
                                  _changePageByTapView = null;
                                }
                                setState(() {});
                              },
                              controller: pageController,

                              // the number of pages
                              itemCount: widget.contents.length,

                              // building pages
                              itemBuilder: (BuildContext context, int index) {
                                return widget.contents[index];
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();

    if (widget.onSelect != null) {
      widget.onSelect!(_selectedIndex);
    }
  }
}
