import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 1.5;
const double TEXT_ON = 0.5;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class TabItem extends StatefulWidget {
  final String? title;
  final bool selected;
  final String? iconPath;
  final TextStyle textStyle;
  final Function callbackFunction;
  final Color tabIconColor, tabSelectedColor;
  final bool isOwnColor;

  TabItem({
    required this.title,
    required this.selected,
    required this.iconPath,
    required this.textStyle,
    required this.tabIconColor,
    required this.tabSelectedColor,
    required this.callbackFunction,
    required this.isOwnColor,
  });

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  double iconYAlign = ICON_ON;
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  _setIconTextAlpha() {
    setState(() {
      iconYAlign = (widget.selected) ? ICON_OFF : ICON_ON;
      textYAlign = (widget.selected) ? TEXT_ON : TEXT_OFF;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              alignment: Alignment(0, textYAlign),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.title!,
                  style: widget.textStyle,
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeIn,
              alignment: Alignment(0, iconYAlign),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: ANIM_DURATION),
                opacity: iconAlpha,
                // child: IconButton(
                //   highlightColor: Colors.transparent,
                //   splashColor: Colors.transparent,
                //   padding: EdgeInsets.all(0),
                //   alignment: Alignment(0, 0),
                //   icon: Icon(widget.iconData, color: widget.tabIconColor),
                //   onPressed: () {
                //     widget.callbackFunction();
                //   },
                // ),
                child: InkWell(
                  onTap: () {
                    widget.callbackFunction();
                  },
                  child: SvgPicture.asset(
                    widget.iconPath!,
                    color: widget.isOwnColor
                        ? null
                        : (widget.selected
                            ? Colors.white
                            : widget.tabIconColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
