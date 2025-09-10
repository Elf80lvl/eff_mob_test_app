import 'package:eff_mob_tes_app/data/const.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatefulWidget {
  final bool isActive;
  final String text;
  final VoidCallback onPressed;
  const AppBarButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActive,
  });

  @override
  State<AppBarButton> createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHover = false;
        });
      },
      cursor: _isHover ? SystemMouseCursors.click : MouseCursor.defer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: widget.isActive
                  ? Color(kColorAccent).withValues(alpha: 0.15)
                  : Colors.transparent,
            ),
            child: TextButton(
              onPressed: widget.onPressed,
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: Color(kColorAccent),
                ),
              ),
            ),
          ),
          // CircleAvatar(
          //   radius: 3,
          //   backgroundColor: widget.isActive
          //       ? Color(kColorAccent)
          //       : Colors.transparent,
          // ),
        ],
      ),
    );
  }
}
