import 'package:flutter/material.dart';
import 'package:keanggotaan_orbit/helpers/color.dart';

class TextFieldCustom extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  int? maxLines;
  bool readOnly = false;
  void Function(String)? onChanged;
  void Function()? onTap;
  bool isPassword;
  String? errorText;
  TextFieldCustom(
      {Key? key,
      required this.label,
      required this.hintText,
      required this.controller,
      this.readOnly = false,
      this.onTap,
      this.maxLines,
      this.onChanged,
      this.errorText,
      this.isPassword = false})
      : super(key: key);

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      maxLines: widget.maxLines ?? 1,
      obscureText: widget.isPassword ? secure : false,
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        label: Text(widget.label),
        labelStyle: TextStyle(color: kDarkBlueColor),
        hintText: widget.hintText,
        isDense: true,
        focusColor: kDarkBlueColor,
        filled: true,
        errorText: widget.errorText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(secure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    secure = !secure;
                  });
                },
              )
            : SizedBox(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kDarkBlueColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kDarkBlueColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
