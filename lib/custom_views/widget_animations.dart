import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';




class FadeInAnimation extends StatelessWidget {
  const FadeInAnimation({this.delay = 01, this.child});

  final int delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween(
        [Track('opacity').add(const Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0))]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delay),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: child,
      ),
    );
  }
}

class FadeOutAnimation extends StatelessWidget {
  const FadeOutAnimation({this.delay = 01, this.animationDuration = 500, this.child});

  final int delay;
  final int animationDuration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Duration animDuration = Duration(milliseconds: animationDuration);
    final tween = MultiTrackTween([
      Track('opacity').add(animDuration, Tween(begin: 1.0, end: 0.0), curve: Curves.easeOut),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delay),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: child,
      ),
    );
  }
}

class SlideInToastMessageAnimation extends StatelessWidget {
  const SlideInToastMessageAnimation(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('translateY')
          .add(
            const Duration(milliseconds: 250),
            Tween(begin: -100.0, end: 0.0),
            curve: Curves.easeOut,
          )
          .add(const Duration(seconds: 1, milliseconds: 250), Tween(begin: 0.0, end: 0.0))
          .add(const Duration(milliseconds: 250), Tween(begin: 0.0, end: -100.0),
              curve: Curves.easeIn),
      Track('opacity')
          .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0))
          .add(const Duration(seconds: 1), Tween(begin: 1.0, end: 1.0))
          .add(const Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.0)),
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: Transform.translate(offset: Offset(0, animation['translateY']), child: child),
      ),
    );
  }
}
