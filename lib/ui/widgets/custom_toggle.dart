import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final Color? color;
  final Color? selectedColor;
  final Color shadowColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Color? backgroundColor;
  final List<String> title;
  final List<String>? subtitle;
  final int? initialIndex;
  final int? selectedIndex;
  final double elevation;
  final bool scrollable;
  final double height;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? contentMargin;
  final void Function(int index)? onSelected;
  const CustomToggle(
      {Key? key,
      this.color,
      this.selectedColor,
      this.shadowColor = Colors.transparent,
      this.textColor,
      this.selectedTextColor,
      this.backgroundColor,
      required this.title,
      this.subtitle,
      this.initialIndex,
      this.onSelected,
      this.scrollable = false,
      this.selectedIndex,
      this.height = 32.0,
      this.contentPadding = const EdgeInsets.symmetric(horizontal: 11.0),
      this.contentMargin = const EdgeInsets.all(15.0),
      this.elevation = 0})
      : super(key: key);

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  int _selectedIndex = 0;

  final scrollController = ScrollController();

  Widget _toggle(
      {required bool selected,
      required String title,
      String? subtitle,
      required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: widget.height,
          padding: widget.contentPadding,
          margin: widget.contentMargin,
          decoration: BoxDecoration(
            color: selected
                ? (widget.selectedColor ??
                    Theme.of(context).colorScheme.secondary)
                : (widget.color ?? Theme.of(context).backgroundColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: widget.shadowColor, blurRadius: 25, spreadRadius: 1),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selected
                            ? (widget.selectedTextColor ??
                                Theme.of(context).primaryColor)
                            : (widget.textColor ??
                                Theme.of(context).textTheme.caption!.color),
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                if (subtitle != null) ...[
                  Text(subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selected
                              ? (widget.selectedTextColor ??
                                  Theme.of(context).primaryColor)
                              : (widget.textColor ??
                                  Theme.of(context).textTheme.caption!.color),
                          fontSize: 12,
                          fontWeight: FontWeight.w400))
                ]
              ],
            ),
          )),
    );
  }

  Widget _toggleButton() {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          )),
      child: Builder(builder: (context) {
        if (widget.scrollable) {
          _scrollToIndex(widget.selectedIndex ?? _selectedIndex);
          return ListView.builder(
            itemCount: widget.title.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (context, index) {
              return Center(
                child: _toggle(
                    selected: index == (widget.selectedIndex ?? _selectedIndex),
                    title: widget.title[index],
                    subtitle: widget.subtitle?[index],
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        if (widget.onSelected != null) {
                          widget.onSelected!(index);
                        }
                      });
                    }),
              );
            },
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              widget.title.length,
              (index) => Expanded(
                    child: _toggle(
                        onTap: () {
                          widget.onSelected!(index);
                          setState(() => _selectedIndex = index);
                        },
                        title: widget.title[index],
                        subtitle: widget.subtitle?[index],
                        selected:
                            index == (widget.selectedIndex ?? _selectedIndex)),
                  )),
        );
      }),
    );
  }

  _scrollToIndex(int index) async {
    final size = AppUtils.deviceScreenSize(context);

    final _offsetToScrollTo =
        (_calculateScreenPercentage(0.16, height: size.width) * index) +
            (10.0 * index);

    if (scrollController.hasClients) {
      scrollController.animateTo(
        _offsetToScrollTo,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  double _calculateScreenPercentage(double percentage,
      {required double height}) {
    return (percentage * height);
  }

  @override
  void initState() {
    setState(() => _selectedIndex = widget.initialIndex ?? 0);
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    if (widget.initialIndex != null) {
      widget.onSelected!(widget.initialIndex!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _toggleButton();
  }
}
