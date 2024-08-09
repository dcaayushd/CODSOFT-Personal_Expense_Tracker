import 'package:flutter/cupertino.dart';

import '../components/category_badge.dart';
import '../extensions/date_extensions.dart';
import '../extensions/number_extensions.dart';
import '../models/expense.dart';

class ExpenseRow extends StatelessWidget {
  final Expense expense;

  const ExpenseRow({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              expense.note ?? expense.category?.name ?? 'Unknown',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            Text(
              "NRs. ${expense.amount.removeDecimalZeroFormat()}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryBadge(category: expense.category),
              Text(
                expense.date.time,
                style: const TextStyle(
                  color: CupertinoColors.inactiveGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
