import 'package:flutter/material.dart';
import 'package:padel/widgets/expanded_button.dart';

class MatchResultDialog extends StatelessWidget {
  const MatchResultDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Result:'),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(),
          const Divider(height: 20, thickness: 1,),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10, left: 5),
            child: const Text('TEAM 1'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Set 1',
                      border: OutlineInputBorder(),
                      counterText: ''
                  ),
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Set 2',
                      border: OutlineInputBorder(),
                      counterText: ''
                  ),
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Set 3',
                      border: OutlineInputBorder(),
                      counterText: ''
                  ),
                  maxLength: 1,
                ),
              )
            ],
          ),
          const Divider(height: 20, thickness: 1,),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10, left: 5),
            child: const Text('TEAM 2'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Set 1',
                      border: OutlineInputBorder(),
                      counterText: ''
                  ),
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Set 2',
                      border: OutlineInputBorder(),
                      counterText: ''
                  ),
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Set 3',
                      border: OutlineInputBorder(),
                      counterText: ''
                  ),
                  maxLength: 1,
                ),
              )
            ],
          ),
          const Divider(height: 10, thickness: 1,),
          ExpandedButton(text: 'Save', onPressed: () {},),
        ],
      ),
    );
  }
}