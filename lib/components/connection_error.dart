import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  final Color iconColor;

  const ConnectionError({Key? key, Color? iconColor})
      : iconColor =
            iconColor ?? Colors.yellow,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.signal_wifi_off, size: 50, color: iconColor),
            const Text(
                "Не удалось получить данные",
              style: TextStyle(
                fontSize: 16
              ),
            )
          ],
        )
    );
  }
}
