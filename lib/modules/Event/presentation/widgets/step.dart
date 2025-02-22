import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(totalSteps, (index) {
          final stepNumber = index + 1;
          return Row(
            children: [
              _buildStep(stepNumber),
              // Show dotted line only if this isn't the last step
              if (stepNumber < totalSteps) _buildDottedLine(true),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStep(int step) {
    final isCompleted = step < currentStep;
    final isCurrent = step == currentStep;

    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isCurrent ? Colors.green : Colors.white,
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 15.sp)
                : CircleAvatar(
                    radius: 4.r,
                    backgroundColor: AppColors.white,
                  ),
          ),
        ),
        Gap(5.w),
        Text(
          'Step $step',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: AppFonts.manRope,
          ),
        ),
        Gap(8.w),
      ],
    );
  }

  Widget _buildDottedLine(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      // If inactive, set width to 0 so no line appears.
      width: isActive ? 36.w : 0,
      child: CustomPaint(
        painter: DottedLinePainter(
          color: isActive ? Colors.grey : Colors.transparent,
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2 // The thickness of each dash
      ..strokeCap = StrokeCap.round;

    const numberOfDashes = 6;
    const dashWidth = 3.0; // Longer dash

    final totalDashWidth = dashWidth * numberOfDashes;
    final totalSpacing = (size.width - totalDashWidth).clamp(0, double.infinity);
    // With 6 dashes at 5 px each, if width is 30.w, there's no extra space:
    final dashSpace = numberOfDashes > 1
        ? totalSpacing / (numberOfDashes - 1)
        : 0.0;

    double startX = 0;

    for (int i = 0; i < numberOfDashes; i++) {
      final endX = startX + dashWidth;
      canvas.drawLine(
        Offset(startX, 0),
        Offset(endX, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
