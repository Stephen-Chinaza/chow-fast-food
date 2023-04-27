import 'package:flutter/material.dart';

import '../../widgets/button_view.dart';
import '../../widgets/text_edit_view.dart';

class PromoCodeField extends StatelessWidget {
  const PromoCodeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: TextEditView(
                  borderColor: Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).primaryColor,
                  controller: TextEditingController(text: ''),
                  prefixIcon: null,
                  hintText: 'Enter Promo Code',
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonView(
                    onPressed: () {},
                    child: const Text('Apply',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18))),
              ),
            ],
          )),
    );
  }
}
