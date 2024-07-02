import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  late TextEditingController textController;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // leading: CupertinoNavigationBarBackButton(),
        middle: Text('Categories'),
      ),
      child: SafeArea(
        bottom: true,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Column(
            children: [
              Expanded(
                child: CupertinoFormSection.insetGrouped(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  children: [
                    ...List.generate(
                      5,
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
                                break;
                            }
                          },
                          child: DecoratedBox(
                            decoration: const BoxDecoration(),
                            child: CupertinoFormRow(
                              prefix: Row(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: pickerColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Text('Category Name')
                                ],
                              ),
                              helper: null,
                              padding:
                                  const EdgeInsets.fromLTRB(16, 14, 16, 14),
                              child: Container(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: const Text('Pick a category color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                color: pickerColor,
                                onColorChanged: changeColor,
                                heading: const Text('Select color'),
                                subheading: const Text('Select color shade'),
                                wheelSubheading:
                                    const Text('Selected color and its shades'),
                                pickersEnabled: const <ColorPickerType, bool>{
                                  ColorPickerType.primary: true,
                                  ColorPickerType.accent: true,
                                  ColorPickerType.custom: true,
                                  ColorPickerType.wheel: true,
                                },
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoButton(
                                child: const Text('Got it'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: pickerColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                            // strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: CupertinoTextField(
                          controller: textController,
                          placeholder: 'Category Name',
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: const Icon(CupertinoIcons.paperplane_fill),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
