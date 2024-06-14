import 'package:code_standards/core/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Widget? title,
    super.key,
  }) : super(
          backgroundColor: const Color(0xFFe63946),
          toolbarHeight: 62,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: 35,
                child: Image.asset(
                  'assets/icons/pokeball.png',
                  color: Colors.white,
                ),
              ),
              if (title != null) ...[
                const SizedBox(width: Consts.padding),
                DefaultTextStyle(
                  style: Consts.textStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  child: title,
                ),
              ],
            ],
          ),
        );
}
