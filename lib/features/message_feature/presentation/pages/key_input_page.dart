import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_software_synopsis/features/global_widgets/custom_text_field.dart';

import '../../../../utils/route_names.dart';

class KeyInputPage extends StatefulWidget {
  Map<String, String> queryParams;

  KeyInputPage({required this.queryParams});

  @override
  State<KeyInputPage> createState() => _KeyInputPageState();
}

class _KeyInputPageState extends State<KeyInputPage> {
  String textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
              hintText: 'input your 16 character secret key',
              onInputChanged: (value) {
                setState(() {
                  textFieldValue = value;
                });
              }),
          ElevatedButton(
              onPressed: () {
                context.pushNamed(CHAT, queryParams: {
                  'contact': widget.queryParams['contact'],
                  'key': textFieldValue
                });
              },
              child: Text('Go to chat'))
        ],
      ),
    );
  }
}
