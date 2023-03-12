import 'dart:async';

import 'package:sport_center_project/flip_animation/config/device_config.dart';
import 'package:sport_center_project/flip_animation/flip_tile.dart';
import 'package:sport_center_project/flip_animation/widgets/front_widget.dart';
import 'package:sport_center_project/flip_animation/widgets/inner_widget.dart';
import 'package:flutter/material.dart';

class SecondColumn extends StatelessWidget {
  const SecondColumn({
    Key ?key,
    this.controller,
  }) : super(key: key);

  final StreamController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: width,
        ),
        Container(
          child: FlipTile(
            key: GlobalKey<FlipTileState>(),
            frontWidget: BuildFrontWidget(asset: 'assets/irene.png'),
            innerWidget: InnerWidget(
              name: 'IRENE',
              tags: [
                'Sports',
                'Math',
                'Books',
                'Rock Band Drummer',
                'Fitness',
              ],
              backgroundColor: Color(0xFF10b4a5),
            ),
            tileSize: Size(width / 2, width / 2),

            animationDuration: Duration(milliseconds: 300),
            // borderRadius: 10,

            stackController: controller,
            unfoldDirection: SwipeDirection.left,
            parentKey: key!,
          ),
        ),
        FlipTile(
          key: GlobalKey<FlipTileState>(),
          frontWidget: BuildFrontWidget(asset: 'assets/julia.png'),
          innerWidget: InnerWidget(
            name: 'JULIA',
            tags: ['Running', 'Books', 'Rock Music', 'Art', 'Science'],
            backgroundColor: Color(0xFFf0b136),
          ),
          tileSize: Size(width / 2, width / 2),
          animationDuration: Duration(milliseconds: 300),
          stackController: controller,
          unfoldDirection: SwipeDirection.left,
          parentKey: key,
        ),
        FlipTile(
          key: GlobalKey<FlipTileState>(),
          frontWidget: BuildFrontWidget(asset: 'assets/paul.png'),
          innerWidget: InnerWidget(
            name: 'PAUL',
            tags: ['Sports', 'Motorcyclying', 'Books', 'Blondies', 'Pet'],
            backgroundColor: Color(0xFffe6d72),
          ),
          tileSize: Size(width / 2, width / 2),
          animationDuration: Duration(milliseconds: 300),
          stackController: controller,
          unfoldDirection: SwipeDirection.left,
          parentKey: key,
        ),
        FlipTile(
          key: GlobalKey<FlipTileState>(),
          frontWidget: BuildFrontWidget(asset: 'assets/irene.png'),
          innerWidget: InnerWidget(
            name: 'IRENE',
            tags: ['Fitness', 'Coding', 'Sports', 'Art', 'Dance'],
            backgroundColor: Color(0xFFffcd23),
          ),
          tileSize: Size(width / 2, width / 2),
          animationDuration: Duration(milliseconds: 300),
          stackController: controller,
          unfoldDirection: SwipeDirection.left,
          parentKey: key,
        )
      ],
    );
  }
}