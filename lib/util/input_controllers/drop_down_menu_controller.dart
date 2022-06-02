import 'package:get/get.dart';

class DropdownMenuController<T> extends GetxController {
  DropdownMenuController({T? initial}){ _selected = Rx(initial); }

  late final Rx<T?> _selected;
  T? get selected => _selected.value;

  void onChanged(T? value) => _selected.value = value;
}