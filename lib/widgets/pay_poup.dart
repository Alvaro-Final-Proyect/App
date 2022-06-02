import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';

class PayPopup {
  static void show({
    required BuildContext context,
    String loadingText = '',
    TextStyle? textStyle,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          title: Text(
            'Precio reserva: ${RetrofitHelper.companySettings.matchPrice}€',
          ),
          content: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Row(
              children: [
                Expanded(child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Pagar en el centro'),
                )),
                const SizedBox(width: 10,),
                Expanded(child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opcion no implementada'),
                      ),
                    );
                  },
                  child: const Text('Pago online'),
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
