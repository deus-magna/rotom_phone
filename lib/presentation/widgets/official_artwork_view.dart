import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OfficialArtworkView extends StatelessWidget {
  const OfficialArtworkView({
    Key key,
    @required this.artwork,
    @required this.tag,
    this.height = 60,
  }) : super(key: key);

  final String artwork;
  final double height;
  final int tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Hero(
        tag: tag,
        child: FadeInImage(
            placeholder: const AssetImage('assets/images/white_pokeball.png'),
            height: height,
            image: CachedNetworkImageProvider(artwork)),
      ),
    );
  }
}
