import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/utilities/providers/SearchBar/provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DistanceToggleSwitch extends StatelessWidget {
  const DistanceToggleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchBarProvider>(context);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Distance'),
              Align(
                alignment: Alignment.centerLeft,
                child: ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColors: const [
                    [FollowMeColors.darkAccentColor],
                    [FollowMeColors.darkAccentColor],
                    [FollowMeColors.darkAccentColor]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: FollowMeColors.lightAccentColor,
                  inactiveFgColor: FollowMeColors.darkAccentColor,
                  initialLabelIndex: provider.distanceIndex,
                  totalSwitches: 3,
                  labels: const ['<100km', '<50km', '<25km'],
                  radiusStyle: true,
                  onToggle: (index) {
                    provider.distanceIndex = index;
                  },
                ),
              ),
            ]));
  }
}
