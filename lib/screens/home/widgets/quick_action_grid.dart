import 'package:flutter/material.dart';

import '../../../models/wallet_models.dart';
import '../../../theme/app_colors.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({
    super.key,
    required this.actions,
    required this.onSelected,
  });

  final List<QuickAction> actions;
  final ValueChanged<QuickAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 8,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final action = actions[index];
        return Semantics(
          button: true,
          label: action.label,
          child: InkWell(
            onTap: () => onSelected(action),
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: action.background,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(action.icon, size: 24, color: action.foreground),
                ),
                const SizedBox(height: 8),
                Text(
                  action.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.inkSoft,
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
