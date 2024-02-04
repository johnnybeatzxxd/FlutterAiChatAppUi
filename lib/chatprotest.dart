import 'package:chat_app/index.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uuid/uuid.dart';

//part 'ChatProvider.g.dart';
class Lot extends StatefulWidget {
  Lot({super.key});

  @override
  State<Lot> createState() => _LotState();
}

class _LotState extends State<Lot> with TickerProviderStateMixin {
  // late AnimationController _sendController;
  // get sendController => _sendController;
  @override
  // void initState() {
  //   super.initState();
  //   _sendController = AnimationController(vsync: this);
  // }

  // @override
  // void dispose() {
  //   sendController.dispose();
  //   super.dispose();
  // }

  

  Widget build(BuildContext context) {
    return Lottie.asset("assets/send_light.json",
        frameRate: FrameRate.max,
    //     controller: _sendController, onLoaded: (compostion) {
    //   sendController.duration = compostion.duration;
    //  }
     );
  }
}
