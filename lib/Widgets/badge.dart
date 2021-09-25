import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  Widget Child;
  String value;
  Color color;
  Badge({this.Child, this.color, this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Child,
        Positioned(
          right: 2,
          top: 3,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Container(
              // constraints: BoxConstraints(
              //   maxHeight: 20,
              //   maxWidth: double.infinity,
              // ),
              // padding: EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.red),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
