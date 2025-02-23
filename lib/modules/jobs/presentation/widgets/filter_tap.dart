import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:flutter/material.dart';

/// A horizontally scrollable list of selectable filter chips.
class FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;


  const FilterChips({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ChoiceChip(
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              side:
                  WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const BorderSide(color: Colors.transparent);
                }
                return BorderSide(
                  color: AppColors.primaryColor,
                );
              }),
                visualDensity: VisualDensity.compact,
              label: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.primaryColor,
                ),
              ),
              selected: isSelected,
              selectedColor: Colors.amber.shade600,
              onSelected: (selected) {
                onSelected(index);
              },
            ),
          );
        },
      ),
    );
  }
}