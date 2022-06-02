import 'package:get/get.dart';
import 'en.dart';
import 'es.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'es_ES': es
  };
}

