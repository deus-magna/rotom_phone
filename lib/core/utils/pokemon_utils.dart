import 'package:flutter/material.dart';

Color versionColor(String version) {
  switch (version) {
    // First Gen games
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'yellow':
      return Colors.yellow;
    // Second Gen games
    case 'gold':
      return Colors.yellow[800];
    case 'silver':
      return Colors.teal[200];
    case 'crystal':
      return Colors.lightBlue;
    // Third Gen Games
    case 'ruby':
      return Colors.red;
    case 'sapphire':
      return Colors.blue;
    case 'emerald':
      return Colors.lightGreen;
    case 'firered':
      return Colors.red;
    case 'leafgreen':
      return Colors.green;
    default:
      return Colors.grey;
  }
}
