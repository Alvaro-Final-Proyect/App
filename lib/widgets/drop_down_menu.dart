import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef DropdownValidator = bool Function(DropdownMenuController dropdownMenuController);

class DropdownMenuController extends GetxController {
  DropdownMenuController(this.selected);
  RxString selected;
  String selectedValue = '';
  var textError = ''.obs;
}

class DropdownMenu extends StatelessWidget {
  DropdownMenu({Key? key, required this.items, required this.hint, required this.validator}) : super(key: key);

  final List<String> items;
  final String hint;
  final DropdownMenuController dropDownMenuController = DropdownMenuController(''.obs);
  final DropdownValidator validator;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField(
        decoration:  InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
          ),
          errorText: dropDownMenuController.textError.value == '' ? null : dropDownMenuController.textError.value
        ),
        items: items.map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item.tr),
        )).toList(),
        onChanged: (value) {
          dropDownMenuController.selected.value = value.toString();
          dropDownMenuController.selectedValue =
            value.toString() == 'textRightPosition' ? 'right'
            : value.toString() == 'textBackhandPosition' ? 'backhand' :
            value.toString() == 'textIndifferentPosition' ? 'indifferent' : '';
        },
        value: dropDownMenuController.selected.value == '' ? null : dropDownMenuController.selected.value,
        hint: Text(hint.tr),
      );
    });
  }
}