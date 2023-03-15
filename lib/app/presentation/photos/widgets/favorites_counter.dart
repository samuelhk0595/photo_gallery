import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';

class FavoritesCounter extends StatefulWidget {
  const FavoritesCounter({
    super.key,
    required this.count,
    required this.onTap,
  });

  final int count;
  final void Function() onTap;

  @override
  State<FavoritesCounter> createState() => _FavoritesCounterState();
}

class _FavoritesCounterState extends State<FavoritesCounter> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          Text(
            '${widget.count}',
            style: TextStyle(
              fontSize: 20,
              color: widget.count == 0 ? Colors.black : Colors.red,
            ),
          ),
          const SizedBox(width: 5),
          Icon(
            widget.count == 0
                ? FontAwesomeIcons.heart
                : FontAwesomeIcons.solidHeart,
            color: widget.count == 0 ? Colors.black : Colors.red,
          ),
        ],
      ),
    );
  }
}
