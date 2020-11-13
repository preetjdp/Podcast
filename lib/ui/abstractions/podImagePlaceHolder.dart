// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PodImagePlaceholder extends StatelessWidget {
  const PodImagePlaceholder.network({
    Key key,
    @required this.url,
    this.placeholder = const SizedBox.shrink(),
    this.child,
    this.duration = const Duration(milliseconds: 200),
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.fit,
  })  : assert(url != null),
        super(key: key);

  /// The image url that we are loading.
  final String url;

  /// Widget displayed while the target [image] is loading.
  final Widget placeholder;

  /// What widget you want to display instead of [placeholder] after [image] is
  /// loaded.
  ///
  /// Defaults to display the [image].
  final Widget child;

  /// The duration for how long the the fade out of the placeholder and
  /// fade in of [child] should take.
  final Duration duration;

  /// See [Image.excludeFromSemantics].
  final bool excludeFromSemantics;

  /// See [Image.width].
  final double width;

  /// See [Image.height].
  final double height;

  /// See [Image.fit].
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        // We only need to animate the loading of images on the web. We can
        // also return early if the images are already in the cache.
        if (wasSynchronouslyLoaded) {
          return this.child ?? child;
        } else {
          return AnimatedSwitcher(
            duration: duration,
            child: frame != null ? this.child ?? child : placeholder,
          );
        }
      },
    );
  }
}
