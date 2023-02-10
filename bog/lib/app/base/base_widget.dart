import 'dart:async';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/blocs/mode_controller.dart';
import 'package:bog/core/utils/widget_util.dart';

abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({Key? key}) : super(key: key);
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T> {
  bool setup = true;
  String? setupError;

  List<StreamSubscription> subs = [];

  List itemList = [];
  List allItemList = [];
  bool showCancel = false;
  FocusNode focusSearch = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subs.add(ModeController.instance.stream.listen((event) {
      if(mounted)setState(() {});
    }));
    // var errorSub = ErrorBloc.instance.stream.listen((event) {
    //   showPopup(event,delayInMilli: 2000);
    // });
    // subs.add(errorSub);
    if (!setup) _onRetryClicked();
  }

  bool resizeToAvoidBottomInset() => true;

  // bool keepingAlive()=>false;

  onBackPressed() => Navigator.pop(context);

  double get _backButtonSize => 45;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (var sub in subs) {
      sub.cancel();
    }
  }

  List searchKeys() => [];

  bool _canSearch() => searchKeys().isNotEmpty && allItemList.isNotEmpty;

  runSearch() {
    String search = searchController.text.trim();
    if (search.startsWith("0")) {
      search = search.substring(1);
    }
    itemList.clear();
    for (Map m in allItemList) {
      String text = "";
      for (String s in searchKeys()) {
        text = text + m[s].toString();
      }
      if (search.isNotEmpty &&
          !text.toLowerCase().contains(search.toLowerCase())) continue;
      itemList.add(m);
    }
    if (sortKey() != null) {
      itemList.sort((a, b) => a.get(sortKey()).compareTo(b.get(sortKey())));
    }
    itemList = filter(itemList);
    itemList = sortItems(itemList);
    setup = true;
    setState(() {});
  }

  String? sortKey() => null;

  List filter(List itemList) => itemList;
  List sortItems(List itemList) => itemList;

  pageColor() => whiteColor;
  titleColor() => blackColor;

  List<Widget> backgroundWidgets() => [];

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Widget child = Container(
      // color: white,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: pageColor(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Stack(
                fit: StackFit.expand,
                children: backgroundWidgets()
                  ..add(hideBanner()
                      ? Container()
                      : Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            // width: 50,
                            height: 40,
                            // child: Opacity(
                            //     opacity: .1, child: Image.asset(plan_padi)
                            // ),
                          ),
                        )),
              ),
              Scaffold(
                  backgroundColor: transparent,
                  resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
                  body: setupError != null
                      ? EmptyLayout(Icons.error, setupError!, "",
                          onClosed: showAppBar() == false
                              ? null
                              : showBackButtonForLoading()
                                  ? () => Navigator.pop(context)
                                  : null, click: () {
                          _onRetryClicked();
                        }, textColor: titleColor(),pageTitle: getPageTitle(),)
                      : !setup
                          ? loadingLayout(
                              fullPage: showAppBar(),
                      pageTitle: getPageTitle(),
                              trans: true, //getAppBarWidgets().isNotEmpty,
                              onClosed: showAppBar() == false
                                  ? null
                                  : showBackButtonForLoading()
                                      ? () => Navigator.pop(context)
                                      : null,
                              titleColor: titleColor())
                          : Container(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      if (useSafeArea()) addSpace(15),
                                      if (showAppBar())
                                        SafeArea(bottom: false,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, bottom: 20),
                                            child: Stack(
                                              alignment: Alignment.centerRight,
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: _backButtonSize,
                                                      height: _backButtonSize,
                                                      margin: const EdgeInsets.only(
                                                          left: 15, right: 10),
                                                      child: TextButton(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              shape: CircleBorder(),
                                                              backgroundColor: transparent,
                                                              padding: EdgeInsets.zero
                                                          ),
                                                          child:
                                                          Icon(
                                                            Icons.arrow_back_ios,
                                                            color: titleColor() ?? blackColor.withOpacity(.5),
                                                            size: 18,
                                                          )
                                                          // Image.asset(
                                                          //   ic_close,
                                                          //   color: titleColor() ?? blackColor.withOpacity(.5),
                                                          //   height: 14,
                                                          // )
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   width: _backButtonSize,
                                                    //   height: _backButtonSize,
                                                    //   margin: const EdgeInsets.only(
                                                    //       left: 10, right: 10),
                                                    //   child: TextButton(
                                                    //     onPressed: () {
                                                    //       onBackPressed();
                                                    //     },
                                                    //     style: TextButton.styleFrom(
                                                    //       padding: const EdgeInsets.all(0),
                                                    //       shape: const CircleBorder(),
                                                    //     ),
                                                    //     child: Icon(
                                                    //       Icons.arrow_back_ios_new,
                                                    //       color:
                                                    //       titleColor() ?? blackColor,
                                                    //       size: 20,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Flexible(
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            getPageTitle(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: titleColor() ??
                                                                    blackColor),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: _backButtonSize + 30,
                                                    )
                                                  ],
                                                ),
                                                Row(mainAxisSize: MainAxisSize.min,
                                                children: getAppBarWidgets()..add(addSpaceWidth(20)),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (_canSearch())
                                        Container(
                                          height: 45,
                                          margin: EdgeInsets.fromLTRB(
                                              20, 0, 20, searchBottom()),
                                          decoration: BoxDecoration(
                                              // color: white.withOpacity(.8),
                                              //   borderRadius: BorderRadius.circular(25),
                                              border:
                                                  // !focusSearch.hasFocus?null:
                                                  Border(
                                                      bottom: BorderSide(
                                                          color: focusSearch
                                                                  .hasFocus
                                                              ? blue0
                                                              : blue03,
                                                          width: focusSearch
                                                                  .hasFocus
                                                              ? 2
                                                              : 1))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            //mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              addSpaceWidth(10),
                                              Icon(
                                                Icons.search,
                                                color: blackColor
                                                    .withOpacity(
                                                        focusSearch.hasFocus
                                                            ? 1
                                                            : (.5)),
                                                size: 17,
                                              ),
                                              addSpaceWidth(10),
                                              Flexible(
                                                flex: 1,
                                                child: TextField(
                                                  textInputAction:
                                                      TextInputAction.search,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  autofocus: false,
                                                  onSubmitted: (_) {
                                                    runSearch();
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: searchHint(),
                                                      hintStyle: textStyle(
                                                        false,
                                                        18,
                                                        blackColor
                                                            .withOpacity(.2),
                                                      ),
                                                      border: InputBorder.none,
                                                      isDense: true),
                                                  style: textStyle(false, 16,
                                                      blackColor),
                                                  controller: searchController,
                                                  cursorColor: blackColor,
                                                  cursorWidth: 1,
                                                  focusNode: focusSearch,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onChanged: (s) {
                                                    showCancel =
                                                        s.trim().isNotEmpty;
                                                    setState(() {});
                                                    runSearch();
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showCancel = false;
                                                    searchController.text = "";
                                                  });
                                                  runSearch();
                                                },
                                                child: showCancel
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 15, 0),
                                                        child: Icon(
                                                          Icons.close,
                                                          color: red0,
                                                          size: 20,
                                                        ),
                                                      )
                                                    : Container(),
                                              )
                                            ],
                                          ),
                                        ),
                                      Expanded(child: page(context))
                                    ],
                                  ),
                                  Stack(
                                    children: floatingWidgets(),
                                  ),
                                ],
                              ),
                            ))
            ],
          )),
    );

    // if(onPop!=null){
    //   child = WillPopScope(
    //     onWillPop: onPop,
    //     child: child,
    //   );
    // }

    return child;
    // if (!useSafeArea()) return child;
    //
    // if (useSafeArea())
    //   return Container(
    //     // color: pageColor(),
    //     child: SafeArea(
    //       child: child,
    //     ),
    //   );
  }

  String searchHint() => "Search";

  onTitlePressed() {}

  // Future<bool> onPop()=>null;

  bool useSafeArea() => true;

  bool showAppBar() => true;

  bool hideBanner() => true;

  String getPageTitle() => "";

  String getPageSubTitle() => "";

  List<Widget> getAppBarWidgets() => [];

  Widget getPageIcon() => Container();

  double searchTop() => 10;
  double searchBottom() => 10;

  List<Widget> floatingWidgets() => [];

  Widget page(BuildContext context);

  bool showBackButtonForLoading() => true;

  _onRetryClicked() {
    // setup=false;
    setupError = null;
    setState(() {});
    loadItems();
  }

  loadItems() {}




}
