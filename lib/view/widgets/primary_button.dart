import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? title;
  const PrimaryButton({super.key, this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.purple, borderRadius: BorderRadius.circular(12)),
      child: MaterialButton(
        onPressed: onPressed,
        height: 55,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text(
          title ?? "",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
