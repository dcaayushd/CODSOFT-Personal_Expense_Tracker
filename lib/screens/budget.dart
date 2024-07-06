import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import '../extensions/number_extensions.dart';
import '../extensions/expenses_extensions.dart';

import '../models/expense.dart';

import '../types/period.dart';
import '../types/widgets.dart';

import '../utils/picker_utils.dart';

import '../constants.dart';

import '../realm.dart';

class Budget extends WidgetWithTitle {
  const Budget({super.key}) : super(title: "Budget");

  @override
  Widget build(BuildContext context) {
    return const BudgetContent();
  }
}

class BudgetContent extends StatefulWidget {
  const BudgetContent({super.key});

  @override
  BudgetContentState createState() => BudgetContentState();
}

class BudgetContentState extends State<BudgetContent> {
  int _selectedPeriodIndex = 1;
  Period get _selectedPeriod => periods[_selectedPeriodIndex];

  var realmExpenses = realm.all<Expense>();
  StreamSubscription<RealmResultsChanges<Expense>>? _expensesSub;
  List<Expense> _expenses = [];

  double get _total => _expenses.map((expense) => expense.amount).sum;

  // Add a map to store budgets for each period
  final Map<Period, double> _budgets = {
    Period.week: 0,
    Period.month: 0,
    Period.year: 0,
  };

  @override
  void initState() {
    super.initState();
    _expenses = realmExpenses.toList().filterByPeriod(_selectedPeriod, 0)[0];
  }

  @override
  Future<void> dispose() async {
    await _expensesSub?.cancel();
    super.dispose();
  }

  void _setBudget() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        String budgetText = '';
        return CupertinoAlertDialog(
          title: Text('Set ${getPeriodDisplayName(_selectedPeriod)} Budget'),
          content: CupertinoTextField(
            keyboardType: TextInputType.number,
            placeholder: 'Enter budget amount',
            onChanged: (value) => budgetText = value,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text('Set'),
              onPressed: () {
                setState(() {
                  _budgets[_selectedPeriod] = double.tryParse(budgetText) ?? 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPieChart() {
    double budget = _budgets[_selectedPeriod] ?? 0;
    double remaining = budget - _total;
    remaining = remaining < 0 ? 0 : remaining;

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: CupertinoColors.activeBlue,
              value: _total,
              title: 'Spent',
              radius: 80,
              titleStyle:
                  const TextStyle(color: CupertinoColors.white, fontSize: 16),
            ),
            PieChartSectionData(
              color: CupertinoColors.activeGreen,
              value: remaining,
              title: 'Remaining',
              radius: 80,
              titleStyle:
                  const TextStyle(color: CupertinoColors.white, fontSize: 16),
            ),
          ],
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _expensesSub ??= realmExpenses.changes.listen((changes) {
      setState(() {
        _expenses =
            changes.results.toList().filterByPeriod(_selectedPeriod, 0)[0];
      });
    });

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF0D0F14),
        middle: Text("Budget"),
      ),
      child: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Time Period:"),
                CupertinoButton(
                  onPressed: () => showPicker(
                    context,
                    CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedPeriodIndex,
                      ),
                      magnification: 1,
                      squeeze: 1.2,
                      useMagnifier: false,
                      itemExtent: kItemExtent,
                      onSelectedItemChanged: (int selectedItem) {
                        setState(
                          () {
                            _selectedPeriodIndex = selectedItem;
                            _expenses = realmExpenses.toList().filterByPeriod(
                                periods[_selectedPeriodIndex], 0)[0];
                          },
                        );
                      },
                      children: List<Widget>.generate(
                        periods.length,
                        (int index) {
                          return Center(
                            child: Text(
                              getPeriodDisplayName(periods[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  child: Text(
                    getPeriodDisplayName(_selectedPeriod),
                  ),
                ),
              ],
            ),
            CupertinoButton(
              onPressed: _setBudget,
              child: Text(
                'Set ${getPeriodDisplayName(_selectedPeriod)} Budget',
              ),
            ),
            const SizedBox(height: 20),
            _buildPieChart(),
            const SizedBox(height: 40),
            Text(
              'Budget: NRs. ${(_budgets[_selectedPeriod] ?? 0).removeDecimalZeroFormat()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Remaining: NRs. ${((_budgets[_selectedPeriod] ?? 0) - _total).removeDecimalZeroFormat()}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
