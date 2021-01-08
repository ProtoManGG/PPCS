import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    @required this.isTextOnly,
    @required this.text,
    @required this.onPressed,
    this.icon,
    this.color = Colors.lightBlueAccent,
  }) : super(key: key);

  final bool isTextOnly;
  final String text;
  final Color color;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FlatButton(
        padding: const EdgeInsets.all(13),
        color: color,
        splashColor: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        onPressed: () {
          onPressed();
        },
        child: isTextOnly
            ? Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(icon, color: Colors.white),
                  ),
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  )
                ],
              ),
      ),
    );
  }
}
