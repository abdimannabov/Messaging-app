import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({Key? key, required this.text, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top:8.0),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: Colors.black12, width: 1.4),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:32.0),
            child: Row(
              children: [
                const Icon(Icons.person, size: 32,),
                const SizedBox(width: 12),
                Expanded(child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
