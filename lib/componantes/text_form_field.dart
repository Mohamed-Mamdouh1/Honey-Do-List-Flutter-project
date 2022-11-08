import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  CustomField(
      {Key? key,
      this.maxLines ,
      this.minLines,
      this.isFill,
      this.fillColor,
      required this.type,
      required this.hintText,
      this.onChanged,
      this.onTap,
      this.obSecureText = false,
      required this.prefix,
      required this.controller})
      : super(key: key);
  bool? isFill = false;
  int ?maxLines;
  int ? minLines;
  Color? fillColor;
  Function(String)? onChanged;
  VoidCallback? onTap;
  TextInputType type;
  TextEditingController controller;
  Widget? hintText;
  bool? obSecureText;
  IconData prefix;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      cursorColor: Colors.pinkAccent,
      style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
      keyboardType: type,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obSecureText!,
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return "This Field can't be Empty";
        }
      },
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(

          filled: isFill,
          fillColor: fillColor,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Icon(
              prefix,
              color: const Color(0xfff50d56),
            ),
          ),
          label: hintText,
          labelStyle:  TextStyle(
              fontFamily: "YanoneKaffeesatz",
              color: Colors.grey.shade700,
              fontSize: 22,
              fontWeight: FontWeight.bold,shadows: [Shadow(offset: Offset(1,1))]),
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
          border: OutlineInputBorder(

              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
