import 'package:flutter/material.dart';

class RoundedTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final void Function()? onTap;

  const RoundedTile({
    super.key,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(80),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          title: Text(title, style: const TextStyle(color: Colors.black)),
          trailing: trailing,
        ),
      ),
    );
  }
}
