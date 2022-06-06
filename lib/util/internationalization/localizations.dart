import 'package:get/get.dart';
import 'fr.dart';
import 'en.dart';
import 'es.dart';
import 'it.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'es_ES': es,
/*    'ca_IT': it,
    'fr_FR': fr,*/
  };
}

