import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import '../../constants/mycolors.dart';

class CustomFloatingSearchBar extends StatelessWidget {
  final FloatingSearchBarController searchBarController;
  final bool isLoading;
  final Function(String query) onQueryChanged;
  final Function(bool isFocused) onFocusChanged;
  final Widget suggestionBloc;
  final Widget selectedPlaceBlocListener;
  final Widget routesBloc;

  const CustomFloatingSearchBar({
    super.key,
    required this.searchBarController,
    required this.isLoading,
    required this.onQueryChanged,
    required this.onFocusChanged,
    required this.suggestionBloc,
    required this.selectedPlaceBlocListener,
    required this.routesBloc,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: searchBarController,
      hint: 'Find a place...',
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18.sp),
      queryStyle: TextStyle(fontSize: 18.sp),
      border: const BorderSide(style: BorderStyle.none),
      progress: isLoading,
      margins: EdgeInsets.fromLTRB(20.w, 70.h, 20.w, 0),
      padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 0),
      height: 52.h,
      iconColor: MyColors.blue,
      scrollPadding: EdgeInsets.only(top: 16.h, bottom: 56.h),
      transitionDuration: const Duration(microseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0,
      width: isPortrait ? 600.w : 500.w,
      debounceDelay: const Duration(microseconds: 500),
      onQueryChanged: onQueryChanged,
      onFocusChanged: onFocusChanged,
      
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(
              Icons.place,
              color: Colors.black.withOpacity(.6),
            ),
            onPressed: () {},
          ),
        ),
      ],
      builder: (context, transition) => ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            suggestionBloc,
            selectedPlaceBlocListener,
            routesBloc,
          ],
        ),
      ),
    );
  }
}
