import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';

class ImageHandler extends ConsumerWidget {
  const ImageHandler({
    Key? key,
    required this.imageKey,
  }) : super(key: key);
  final String imageKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? url = ref.watch(newHomePageCMSProvider)?.cmsImages.toJson().getKey(imageKey);
    return CachedNetworkImage(
      imageUrl: url!,
      placeholder: (_, __) => const Center(child: CircularProgressIndicator.adaptive()),
      fit: BoxFit.contain,
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
            size: 50.0,
          ),
        );
      },
    );
  }
}
