import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.buttonText, required this.action})
      : super(key: key);
  final VoidCallback? action;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
          width: MediaQuery.of(context).size.width/2,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(4, 4),
                  spreadRadius: 4,
                  blurRadius: 7)
            ],
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: Text(
                '$buttonText',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'YanoneKaffeesatz'
                ),
              ))),
    );
  }
}
