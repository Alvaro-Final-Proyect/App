import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final double width;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const ExpandedButton(
      {Key? key,
      required this.text,
      this.margin = EdgeInsets.zero,
      this.width = double.infinity,
      this.padding = EdgeInsets.zero,
      this.onPressed,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: padding,
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold
                  ),
            ),
          ),),
    );
  }
}
