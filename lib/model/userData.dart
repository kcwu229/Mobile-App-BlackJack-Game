// TO DO: add write level, exp data
import 'package:shared_preferences/shared_preferences.dart';

Future saveUserData(level, exp, gachaCoin, coin) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('level', level);
  await prefs.setInt('exp', exp);
  await prefs.setInt('gachaCoin', gachaCoin);
  await prefs.setInt('coin', coin);
  //await prefs.setString('appliedBG', appliedBG);
}

Future<void> saveBG(appliedBG) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('appliedBG', appliedBG);
}

Future<Map<String, dynamic>> loadBG() async {
  final prefs = await SharedPreferences.getInstance();
  final appliedBG =
      prefs.getString('appliedBG') ?? 'assets/img/background/mainPage.gif';
  print('From function loadBG in mainPage, now appliedBG is ${appliedBG}');
  return {'appliedBG': appliedBG};
}

// TO DO: add read level, exp data
Future<Map<String, dynamic>> loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final level = prefs.getInt('level') ?? 1;
  final exp = prefs.getInt('exp') ?? 0;
  final gachaCoin = prefs.getInt('gachaCoin') ?? 0;
  final coin = prefs.getInt('coin') ?? 0;
  return {'level': level, 'exp': exp, 'gachaCoin': gachaCoin, 'coin': coin};
}

class UserExp {
  final experienceTable = {
    1: 100,
    2: 300,
    3: 600,
    4: 1000,
    5: 1500,
    6: 2100,
    7: 2800,
    8: 3600,
    9: 4500,
    10: 5500,
    11: 6600,
    12: 7800,
    13: 9100,
    14: 10500,
    15: 12000,
    16: 13600,
    17: 15300,
    18: 17100,
    19: 19000,
    20: 21000,
    21: 23100,
    22: 25300,
    23: 27600,
    24: 30000,
    25: 32500,
    26: 35100,
    27: 37800,
    28: 40600,
    29: 43500,
    30: 46500,
    31: 49600,
    32: 52800,
    33: 56100,
    34: 59500,
    35: 63000,
    36: 66600,
    37: 70300,
    38: 74100,
    39: 78000,
    40: 82000,
    41: 86100,
    42: 90300,
    43: 94600,
    44: 99000,
    45: 103500,
    46: 108100,
    47: 112800,
    48: 117600,
    49: 122500,
    50: 127500,
    51: 132600,
    52: 137800,
    53: 143100,
    54: 148500,
    55: 154000,
    56: 159600,
    57: 165300,
    58: 171100,
    59: 177000,
    60: 183000,
    61: 189100,
    62: 195300,
    63: 201600,
    64: 208000,
    65: 214500,
    66: 221100,
    67: 227800,
    68: 234600,
    69: 241500,
    70: 248500,
    71: 255600,
    72: 262800,
    73: 270100,
    74: 277500,
    75: 285000,
    76: 292600,
    77: 300300,
    78: 308100,
    79: 316000,
    80: 324000,
    81: 332100,
    82: 340300,
    83: 348600,
    84: 357000,
    85: 365500,
    86: 374100,
    87: 382800,
    88: 391600,
    89: 400500,
    90: 409500,
    91: 418600,
    92: 427800,
    93: 437100,
    94: 446500,
    95: 456000,
    96: 465600,
    97: 475300,
    98: 485100,
    99: 495000,
    100: 505000
  };

  int getExp(level) {
    return experienceTable[level] ?? 0;
  }

  Future<void> checkOut(
      level, exp, expGained, int gachaCoinReward, int coinReward) async {
    //var a = await loadUserData();
    final prefs = await SharedPreferences.getInstance();
    int gachaCoin = prefs.getInt('gachaCoin') ?? 0;
    gachaCoin += gachaCoinReward;
    int coin = prefs.getInt('coin') ?? 0;
    coin += coinReward;
    int requiredExp = getExp(level);
    exp = exp + expGained;
    if (exp >= requiredExp) {
      level += 1;
      exp -= requiredExp;
    }
    await saveUserData(level, exp, gachaCoin, coin);
  }
}
