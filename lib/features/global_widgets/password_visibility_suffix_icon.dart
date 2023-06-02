import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordVisibilitySuffixIcon extends StatefulWidget {


  PasswordVisibilitySuffixIcon({required this.onTap});
  Function(bool isVisible)  onTap;

  @override
  _PasswordVisibilitySuffixIconState createState() =>
      _PasswordVisibilitySuffixIconState();
}

class _PasswordVisibilitySuffixIconState
    extends State<PasswordVisibilitySuffixIcon> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: (){

        setState(() {
          isVisible = !isVisible;
        });
        widget.onTap(isVisible);

      },
      icon: isVisible ?  Icon(Icons.visibility_sharp) : Icon(Icons.visibility_off_sharp),
    );
  }
}
