import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String? text;
  final String? highlight;
  final TextStyle? style;
  final TextStyle? highlightStyle;
  final bool? ignoreCase;
  const HighlightText({
    Key? key,
    this.text,
    this.highlight,
    this.style,
    this.highlightStyle,
    this.ignoreCase = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = this.text ?? '';
    if ((highlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(text, style: style);
    }

    var sourceText = ignoreCase == true ? text.toLowerCase() : text;
    var targetHighlight = ignoreCase == true ? highlight?.toLowerCase() : highlight;

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = sourceText.indexOf(targetHighlight!, start);
      if (indexOfHighlight < 0) {
        // no highlight
        spans.add(_normalSpan(text.substring(start)));
        break;
      }
      if (indexOfHighlight > start) {
        // normal text before highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
      }
      start = indexOfHighlight + highlight!.length;
      spans.add(_highlightSpan(text.substring(indexOfHighlight, start)));
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: highlightStyle);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }
}
