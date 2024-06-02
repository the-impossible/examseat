import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final double? size;
  final String? text;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final bool? isTruncated;

  const DefaultText({
    Key? key,
    this.size,
    required this.text,
    this.color,
    this.weight,
    this.align,
    this.isTruncated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      (isTruncated == true) ? truncateString(text!, 9) : text!,
      softWrap: true,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins',
      ),
    );
  }
}

// String truncateString(String input, int maxLength) {
//     if (input.length <= maxLength) {
//       return input;
//     } else {
//       return "${input.substring(0, maxLength)}...";
//     }
//   }

String truncateString(String input, int maxLength) {
  if (input.length <= maxLength) {
    return input;
  } else {
    return "...${input.substring(input.length - maxLength)}";
  }
}
