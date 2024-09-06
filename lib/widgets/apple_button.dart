import 'package:flutter/material.dart';
class AppleButton extends StatelessWidget {
  const AppleButton({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(45, 45, 45, 1),
      height: height * 0.075,
      width: width * 0.35,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(
                color: Colors.white, width: 1),
          ),
          onPressed: () {},
          child: const Icon(
            Icons.apple,
            size: 34,
            color: Colors.white,
          )),
    );
  }
}