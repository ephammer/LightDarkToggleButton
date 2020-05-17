import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_dark_togglebutton/moon_icons.dart';


const double _kTrackHeight = 14.0;
const double _kTrackWidth = 33.0;
const double _kTrackRadius = _kTrackHeight / 2.0;
const double _kThumbRadius = 10.0;
const double _kSwitchWidth = _kTrackWidth - 2 * _kTrackRadius +
    2 * kRadialReactionRadius;
const double _kSwitchHeight = 2 * kRadialReactionRadius + 8.0;
const double _kSwitchHeightCollapsed = 2 * kRadialReactionRadius;

class LightDarkToggleButton extends StatefulWidget {

  final MaterialTapTargetSize materialTapTargetSize;

  /// Whether this switch is on or off.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  /// ```
  final ValueChanged<bool> onChanged;

  const LightDarkToggleButton({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.materialTapTargetSize,
  });

  @override
  _LightDarkToggleButtonState createState() => _LightDarkToggleButtonState();
}

class _LightDarkToggleButtonState extends State<LightDarkToggleButton> {

  Duration _duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double _height = 20;
    double _width = 50;

    return Center(
      child: AnimatedContainer(
        duration: _duration,
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
//          border: Border.all(width: 4),
          gradient: widget.value
              ? LinearGradient(
            colors: [Color(0xFF97EBF4),Color(0xFF35D6ED)],
          )
              : LinearGradient(
            colors: [Color(0xFF1D1D55), Color(0xFF122394)],
          ),
//          color: _toggleValue ? Color(0xFF7fd2e2) : null,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: _duration,
              curve: Curves.easeIn,
              top: 3.0,
              left: widget.value ? 30 : 0,
              right: widget.value ? 0 : 30,
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: toggleButton,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  transitionBuilder: (Widget widget,
                      Animation<double> animation) {
//                    return RotationTransition(turns: animation,child: widget,);
                    return FadeTransition(opacity: animation, child: widget,);
                  },
                  child: widget.value
                      ? Icon(
                    Icons.wb_sunny,
                    size:14,
                    color: Colors.yellow,
                    key: UniqueKey(),
                  )
                      : Icon(
                    Moon.moon_phases,
                    size:14,
                    color: Colors.yellow,
                    key: UniqueKey(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void toggleButton() {
    if (widget.onChanged != null) {
      widget.onChanged(!widget.value);
    }
  }

  Size getSwitchSize(ThemeData theme) {
    switch (widget.materialTapTargetSize ?? theme.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        return const Size(_kSwitchWidth, _kSwitchHeight);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        return const Size(_kSwitchWidth, _kSwitchHeightCollapsed);
        break;
    }
    assert(false);
    return null;
  }
}
