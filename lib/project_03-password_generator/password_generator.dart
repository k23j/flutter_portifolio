import 'package:flutter/material.dart';

class PasswordGenerator extends StatelessWidget {
  const PasswordGenerator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Password Generator"),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Include uppercase letters'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Include lowercase letters'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Include numbers'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Include symbols'),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
