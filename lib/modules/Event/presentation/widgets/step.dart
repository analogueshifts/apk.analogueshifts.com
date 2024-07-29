import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  StepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(totalSteps, (index) {
        return Row(
          children: [
            _buildStep(index + 1),
            // if (index < totalSteps - 1) Expanded(child: _buildLine(index)),
          ],
        );
      }),
    );
  }

  Widget _buildStep(int step) {
    bool isCompleted = step < currentStep;
    bool isCurrent = step == currentStep;

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isCurrent ? Colors.green : Colors.white,
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 20)
                : CircleAvatar(
              radius: 5,
              backgroundColor: AppColors.white,
            )
          ),
        ),
        Gap(5),
        Text(
          'Step $step',
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.manRope
          ),
        ),
        _buildDottedLine(step != 3)
      ],
    );
  }

  Widget _buildDottedLine(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: !isActive ? 0:  50,
      child: CustomPaint(
        painter: DottedLinePainter(
          color: !isActive ? Colors.transparent : Colors.grey,
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
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashWidth = 3;
    const dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}