import 'package:flutter/material.dart';


import 'password_visibility_suffix_icon.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.onInputChanged,
    this.iconData,
    this.hintText,
    this.isPasswordField = false,
    this.text,
    this.maxLines = 1,
  }) : super(key: key);

  Function(String value) onInputChanged;
  String? text;
  IconData? iconData;
  String? hintText;
  bool isPasswordField;
  int? maxLines;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = true;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      if (widget.text != null) {
        textEditingController.text = widget.text!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: TextField(
        style: TextStyle(fontSize: 15),
        maxLines: widget.maxLines,
        controller: textEditingController,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          hintText: widget.hintText,
        //  hintStyle: TextStyle(color: DARK_GREY),
          enabledBorder: OutlineInputBorder(
          //  borderSide: BorderSide(color: LIGHT_GREY, width: 2),
          ),
          prefixIcon: widget.iconData == null
              ? null
              : Icon(
                  widget.iconData,
                  //color: LIGHT_GREY,
                ),
          suffixIcon: widget.isPasswordField
              ? PasswordVisibilitySuffixIcon(onTap: (isVisible) {
                  setState(() {
                    isPasswordVisible = isVisible;
                  });
                })
              : null,
          border: OutlineInputBorder(
           // borderSide: BorderSide(color: LIGHT_GREY, width: 3),
          ),
        ),
        onChanged: (value) {
          widget.onInputChanged(value);
        },
      ),
    );
  }
}
