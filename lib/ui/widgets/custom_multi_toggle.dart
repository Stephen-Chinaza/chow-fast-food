
import 'package:flutter/material.dart';

class CustomMultiToggle extends StatefulWidget {
  final Color? color;
  final Color? selectedColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final Color? backgroundColor;
  final List<String> title;
  final List<String>? subtitle;
  final List<int>? selectedIndex;
  final double elevation;
  final double height;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? contentMargin;
  final void Function(List<int> index)? onSelected;
  const CustomMultiToggle(
      {Key? key,
        this.color,
        this.selectedColor,
        this.textColor,
        this.selectedTextColor,
        this.backgroundColor,
        required this.title,
        this.subtitle,
        this.onSelected,
        this.selectedIndex,
        this.height=40.0,
        this.contentPadding=const EdgeInsets
            .symmetric(horizontal: 15.0, vertical: 8),
        this.contentMargin=const EdgeInsets.all(12.0),
        this.elevation = 0})
      : super(key: key);

  @override
  _CustomMultiToggleState createState() => _CustomMultiToggleState();
}

class _CustomMultiToggleState extends State<CustomMultiToggle> {

  final List<int> _selectedIndex = [];


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
              border: Border.all(
                  width: 1.0,
                  color: Theme.of(context).shadowColor,
                  style: BorderStyle.solid)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: selected
                          ? (widget.selectedTextColor ??
                              Theme.of(context).primaryColor)
                          : (widget.textColor ??
                              Theme.of(context).textTheme.caption!.color),
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              if(subtitle!=null)...[
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
          )),
    );
  }

  Widget _toggleButton() {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          )),
      child: Builder(builder: (context) {
        return Wrap(
          children: List.generate(
              widget.title.length,
                  (index){
                final selected=(widget.selectedIndex ?? _selectedIndex).contains(index);
                return _toggle(
                    onTap: () {
                      setState((){
                        if(selected){
                          _selectedIndex.remove(index);
                          return;
                        }
                        _selectedIndex.add(index);
                      });
                      widget.onSelected!(_selectedIndex);
                    },
                    title: widget.title[index],
                    subtitle: widget.subtitle?[index],
                    selected: selected);
              }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _toggleButton();
  }

}
