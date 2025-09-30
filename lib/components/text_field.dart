import 'package:flutter/material.dart';

/// A small, stylish, and easy-to-use text field widget.
///
/// Place this file in your project (for example: lib/widgets/beautiful_textfield.dart)
/// then import and use it:
///
/// ```dart
/// import 'package:your_app/widgets/beautiful_textfield.dart';
/// 
/// BeautifulTextField(
///   controller: TextEditingController(),
///   hintText: 'Email',
///   prefixIcon: Icons.email,
///   suffixIcon: Icons.clear,
/// );
/// ```

class BeautifulTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final double borderRadius;
  final double height;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color accentColor;
  final Color textColor;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool enabled;
  final int? maxLines;
  final int? minLines;

  const BeautifulTextField({
    Key? key,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.borderRadius = 12.0,
    this.height = 56.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.backgroundColor = const Color(0xFFF5F7FA),
    this.accentColor = const Color(0xFF5C5BB0),
    this.textColor = const Color(0xFF1F2937),
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  @override
  _BeautifulTextFieldState createState() => _BeautifulTextFieldState();
}

class _BeautifulTextFieldState extends State<BeautifulTextField> {
  late FocusNode _focusNode;
  bool _ownFocusNode = false;
  bool _hasFocus = false;
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
    }

    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _hasFocus = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_ownFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _hasFocus ? widget.accentColor : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  color: widget.accentColor.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.prefixIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(
                widget.prefixIcon,
                color: _hasFocus ? widget.accentColor : widget.textColor,
              ),
            ),

          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              obscureText: _obscure,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
                height: 1.2,
              ),
              cursorColor: widget.accentColor,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: widget.textColor.withOpacity(0.6)),
                border: InputBorder.none,
              ),
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              textInputAction: TextInputAction.done,
            ),
          ),

          if (widget.suffixIcon != null)
            GestureDetector(
              onTap: () {
                if (widget.onSuffixTap != null) {
                  widget.onSuffixTap!();
                } else if (widget.obscureText) {
                  setState(() {
                    _obscure = !_obscure;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  widget.suffixIcon,
                  color: widget.textColor.withOpacity(0.9),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
