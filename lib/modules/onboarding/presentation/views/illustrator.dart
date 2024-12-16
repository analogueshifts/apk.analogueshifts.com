import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class IllustrationIndicator extends StatelessWidget {
  const IllustrationIndicator({
    super.key,
    required this.activeCard,
    this.length
  });
  final int activeCard;
  final int? length;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length ?? 3,
              (index) => AnimatedContainer(
            width: index == activeCard ? 25 : 8,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              // shape: BoxShape.,
              borderRadius: BorderRadius.circular(15),
              color: index == activeCard
                  ? AppColors.primaryColor
                  : const Color(0XFFFFBB0A).withOpacity(0.30),
            ),
          ),
        ),
      ),
    );
  }
}