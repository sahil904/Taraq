import 'package:flutter/material.dart';
import 'package:test/utils/date_time_utils.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer(
      {Key key,
      int secondsRemaining,
      this.countDownTimerStyle,
      this.whenTimeExpires,
      this.countDownFormatter,
      this.displaySeconds = true,
      this.disPlayCountdownTimer = true,
      this.widgetToDisplay})
      : secondsRemaining = secondsRemaining,
        super(key: key);

  final int secondsRemaining;
  final Function whenTimeExpires;
  final Function countDownFormatter;
  final TextStyle countDownTimerStyle;
  final bool displaySeconds;
  final bool disPlayCountdownTimer;
  final Widget widgetToDisplay;

  State createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> with TickerProviderStateMixin {
  AnimationController _controller;
  Duration duration;

  String get timerDisplayString {
    Duration duration = _controller.duration * _controller.value;
    return widget.countDownFormatter != null
        ? widget.countDownFormatter(duration.inSeconds)
        : widget.displaySeconds
            ? DateTimeUtils.formatHHMMSS(duration.inSeconds)
            : DateTimeUtils.formatHHMMInUnits(duration.inSeconds);
    // In case user doesn't provide formatter use the default one
    // for that create a method which will be called formatHHMMSS or whatever you like
  }

  @override
  void initState() {
    super.initState();
    duration = Duration(seconds: widget.secondsRemaining);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: widget.secondsRemaining.toDouble());
    _controller.addStatusListener((status) {
      print("my status:  $status");

      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        widget.whenTimeExpires();
      }
    });
  }

  @override
  void didUpdateWidget(CountDownTimer oldWidget) {
    if (widget.secondsRemaining != oldWidget.secondsRemaining) {
      setState(() {
        duration = Duration(seconds: widget.secondsRemaining);
        _controller.dispose();
        _controller = AnimationController(
          vsync: this,
          duration: duration,
        );
        _controller.reverse(from: widget.secondsRemaining.toDouble());
        _controller.addStatusListener((status) {
          print("my status:  $status");
          if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
            widget.whenTimeExpires();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {
              return widget.disPlayCountdownTimer
                  ? Text(
                      timerDisplayString,
                      style: widget.countDownTimerStyle,
                    )
                  : widget.widgetToDisplay;
            }));
  }
}
