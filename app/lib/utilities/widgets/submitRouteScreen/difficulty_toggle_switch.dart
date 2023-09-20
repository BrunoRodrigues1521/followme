import 'package:flutter/material.dart';
import 'package:followme/utilities/providers/SubmitRouteScreen/provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DifficultyToggleSwitch extends StatelessWidget {
  const DifficultyToggleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MySubmitRouteFormProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 20.0),
      ////////////dificulty toggle
      child: Align(
        alignment: Alignment.centerLeft,
        child: ToggleSwitch(
          minWidth: 90.0,
          cornerRadius: 20.0,
          activeBgColors: const [
            [Color(0xffED7C30)],
            [Color(0xffED7C30)],
            [Color(0xffED7C30)]
          ],
          activeFgColor: Colors.white,
          inactiveBgColor:
          const Color(0xffED7C30).withOpacity(0.2),
          inactiveFgColor: const Color(0xffED7C30),
          initialLabelIndex: provider.difficultyIndex,
          totalSwitches: 3,
          labels: const ['Easy', 'Medium', 'Hard'],
          radiusStyle: true,
          onToggle: (index) {
            provider.difficultyIndex = index;
          },
        ),
      ),
    );
  }
}
