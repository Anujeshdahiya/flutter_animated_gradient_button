library flutter_animated_gradient_button;

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedGradientButton extends StatefulWidget {
  const AnimatedGradientButton({
    super.key,
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.btnText,
  });
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Color? color4;
  final String? btnText;

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton> {
   final animationsMap = <String, AnimationInfo>{};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 0.0.ms,
            begin: Offset(5.0, 5.0),
            end: Offset(5.0, 5.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: Offset(-100.0, 0.0),
            end: Offset(100.0, 0.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 2000.0.ms,
            duration: 2000.0.ms,
            begin: Offset(200.0, 0.0),
            end: Offset(-200.0, 0.0),
          ),
        ],
      ),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2,
            sigmaY: 2,
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.color1!,
                      widget.color2!,
                      widget.color3!,
                      widget.color4!,
                    ],
                    stops: [0.1, 0.5, 0.9, 1],
                    begin: AlignmentDirectional(1, 0),
                    end: AlignmentDirectional(-1, 0),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ).animateOnPageLoad(
                  animationsMap['containerOnPageLoadAnimation']!),
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x87000000),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    widget.btnText!,
                    style: const TextStyle(
                          fontFamily: 'Poppins',
                          color:
                              Colors.white,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



enum AnimationTrigger {
  onPageLoad,
  onActionTrigger,
}

class AnimationInfo {
  AnimationInfo({
    required this.trigger,
    required this.effectsBuilder,
    this.loop = false,
    this.reverse = false,
    this.applyInitialState = true,
  });
  final AnimationTrigger trigger;
  final List<Effect> Function()? effectsBuilder;
  final bool applyInitialState;
  final bool loop;
  final bool reverse;
  late AnimationController controller;

  List<Effect>? _effects;
  List<Effect> get effects => _effects ??= effectsBuilder!();

  void maybeUpdateEffects(List<Effect>? updatedEffects) {
    if (updatedEffects != null) {
      _effects = updatedEffects;
    }
  }
}

void createAnimation(AnimationInfo animation, TickerProvider vsync) {
  final newController = AnimationController(vsync: vsync);
  animation.controller = newController;
}

void setupAnimations(Iterable<AnimationInfo> animations, TickerProvider vsync) {
  animations.forEach((animation) => createAnimation(animation, vsync));
}

extension AnimatedWidgetExtension on Widget {
  Widget animateOnPageLoad(
    AnimationInfo animationInfo, {
    List<Effect>? effects,
  }) {
    animationInfo.maybeUpdateEffects(effects);
    return Animate(
      effects: animationInfo.effects,
      child: this,
      onPlay: (controller) => animationInfo.loop
          ? controller.repeat(reverse: animationInfo.reverse)
          : null,
      onComplete: (controller) => !animationInfo.loop && animationInfo.reverse
          ? controller.reverse()
          : null,
    );
  }

  Widget animateOnActionTrigger(
    AnimationInfo animationInfo, {
    List<Effect>? effects,
    bool hasBeenTriggered = false,
  }) {
    animationInfo.maybeUpdateEffects(effects);
    return hasBeenTriggered || animationInfo.applyInitialState
        ? Animate(
            controller: animationInfo.controller,
            autoPlay: false,
            effects: animationInfo.effects,
            child: this)
        : this;
  }
}

class TiltEffect extends Effect<Offset> {
  const TiltEffect({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    Offset? begin,
    Offset? end,
  }) : super(
          delay: delay,
          duration: duration,
          curve: curve,
          begin: begin ?? const Offset(0.0, 0.0),
          end: end ?? const Offset(0.0, 0.0),
        );

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
    EffectEntry entry,
  ) {
    Animation<Offset> animation = buildAnimation(controller, entry);
    return getOptimizedBuilder<Offset>(
      animation: animation,
      builder: (_, __) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(animation.value.dx)
          ..rotateY(animation.value.dy),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
