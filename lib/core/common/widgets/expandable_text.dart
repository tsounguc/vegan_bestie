import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.context, {
    required this.text,
    this.style,
    super.key,
  });

  final BuildContext context;
  final String text;
  final TextStyle? style;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;
  late TextSpan textSpan;
  late TextPainter textPainter;

  @override
  void initState() {
    textSpan = TextSpan(
      text: widget.text,
      style: widget.style,
      children: [
        TextSpan(
          text: expanded ? 'show less' : 'show more',
          style: const TextStyle(
            // color: context.theme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                expanded = !expanded;
              });
            },
        ),
      ],
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: expanded ? null : 4,
    )..layout(
        maxWidth: widget.context.width * 0.9,
      );

    super.initState();
  }

  @override
  void dispose() {
    textPainter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      height: 1.8,
      fontSize: 16,
      color: context.theme.textTheme.bodyMedium?.color,
    );
    return Container(
      child: textPainter.didExceedMaxLines
          ? RichText(
              text: TextSpan(
                text: expanded
                    ? widget.text
                    : '${widget.text.substring(
                        0,
                        textPainter
                            .getPositionForOffset(
                              Offset(
                                widget.context.width,
                                widget.context.height,
                              ),
                            )
                            .offset,
                      )}...',
                style: widget.style ?? defaultStyle,
                children: [
                  TextSpan(
                    text: expanded ? '  \nShow less' : 'Show more',
                    style: TextStyle(
                      color: context.theme.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                  ),
                ],
              ),
            )
          : Text(
              widget.text,
              style: widget.style ?? defaultStyle,
            ),
    );
  }
}
