import 'package:flutter/material.dart';

class ScrollShaderMask extends StatelessWidget {
  final Widget? child;
  const ScrollShaderMask({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.transparent,
            Theme.of(context).colorScheme.surface,
          ],
          stops: const [
            0.8,
            1.0,
          ],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 2),
        child: child,
      ),
    );
  }
}
