import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/utilities/providers/SearchBar/provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RatingSwitch extends StatelessWidget {
  const RatingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchBarProvider>(context);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rating'),
              Align(
                alignment: Alignment.centerLeft,
                child: ToggleSwitch(
                  minWidth: 54.0,
                  cornerRadius: 20.0,
                  activeBgColors: const [
                    [FollowMeColors.darkAccentColor],
                    [FollowMeColors.darkAccentColor],
                    [FollowMeColors.darkAccentColor],
                    [FollowMeColors.darkAccentColor],
                    [FollowMeColors.darkAccentColor]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: FollowMeColors.lightAccentColor,
                  inactiveFgColor: FollowMeColors.darkAccentColor,
                  initialLabelIndex: provider.ratingIndex,
                  totalSwitches: 5,
                  icons: const [
                    Icons.local_fire_department_outlined,
                    Icons.local_fire_department_outlined,
                    Icons.local_fire_department_outlined,
                    Icons.local_fire_department_outlined,
                    Icons.local_fire_department_outlined,
                  ],
                  radiusStyle: true,
                  onToggle: (index) {
                    provider.ratingIndex = index;
                  },
                ),
              ),
            ]));
  }
}
