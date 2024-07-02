import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/screens/categories.dart';

class Item {
  final String label;
  final bool isDestructive;

  const Item(
    this.label,
    this.isDestructive,
  );
}

const items = [Item('Categories', false), Item('Delete all data', true)];

class Settings extends StatelessWidget {
  final String title = 'Settings';

  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 147,
      width: double.infinity,
      transformAlignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CupertinoFormSection.insetGrouped(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            ...List.generate(
              items.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Categories(),
                          ),
                        );
                        break;
                      case 1:
                        _showAlertDialog(context);
                        break;
                    }
                  },
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        // color: Color(0xFF1C1C1E),
                        ),
                    child: CupertinoFormRow(
                      prefix: Text(
                        items[index].label,
                        style: TextStyle(
                          color: items[index].isDestructive
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      helper: null,
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      child: items[index].isDestructive
                          ? Container()
                          : const Icon(
                              Icons.arrow_right,
                            ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('This action cannot be undone'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete Data',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ));
  }
}
