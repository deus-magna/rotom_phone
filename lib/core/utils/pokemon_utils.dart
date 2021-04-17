import 'package:flutter/material.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/domain/entities/pokedex/move_learn_method.dart';
import 'utils.dart' as utils;

MoveLearnMethodType learnMethodType(String name) {
  return utils.enumFromString(
    MoveLearnMethodType.values,
    name.toUpperCase().replaceAll('-', '_'),
  );
}

Color versionColor(String version) {
  switch (version) {
    // I Gen games
    case 'red':
      return redVersion;
    case 'green':
      return leafGreenVersion;
    case 'blue':
      return blueVersion;
    case 'yellow':
      return yellowVersion;
    // II Gen games
    case 'gold':
      return goldVersion;
    case 'silver':
      return silverVersion;
    case 'crystal':
      return crystalVersion;
    // III Gen Games
    case 'ruby':
      return rubyVersion;
    case 'sapphire':
      return sapphireVersion;
    case 'emerald':
      return emeraldVersion;
    case 'firered':
      return fireRedVersion;
    case 'leafgreen':
      return leafGreenVersion;
    // IV Gen Games
    case 'diamond':
      return diamondVersion;
    case 'pearl':
      return pearlVersion;
    case 'platinum':
      return platinumVersion;
    case 'heartgold':
      return heartgoldVersion;
    case 'soulsilver':
      return soulsilverVersion;
    // V Gen Games
    case 'black':
      return blackVersion;
    case 'white':
      return whiteVersion;
    case 'black-2':
      return blackVersion;
    case 'white-2':
      return whiteVersion;
    // VI Gen Games
    case 'x':
      return xVersion;
    case 'y':
      return yVersion;
    case 'alpha-sapphire':
      return alphaSapphireVersion;
    case 'omega-ruby':
      return omegaRubyVersion;
    // VII Gen Games
    case 'sun':
      return sunVersion;
    case 'moon':
      return moonVersion;
    case 'ultra-sun':
      return ultraSunVersion;
    case 'ultra-moon':
      return ultraMoonVersion;
    // VIII Gen Games
    case 'lets-go-pikachu':
      return letsGoPikachuVersion;
    case 'lets-go-eevee':
      return letsGoEeveeVersion;
    case 'sword':
      return swordVersion;
    case 'shield':
      return shieldVersion;

    default:
      return Colors.grey;
  }
}
