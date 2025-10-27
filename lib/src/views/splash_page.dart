import 'dart:async';
import 'dart:developer';

import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/shared/routes/navigation.dart';
import 'package:access_control/src/view_models/party_view_model.dart';
import 'package:access_control/theme/colors.dart';
import 'package:access_control/utils/constants/animations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  Timer? timer;
  double value = 0;

  @override
  void initState() {
    super.initState();

    final partyViewModel = Provider.of<PartyViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await partyViewModel.getAllGuests();

      _startTimer();
      final size = MediaQuery.of(context).size;
      Responsive.defineSize(size, pixelRatio: size.aspectRatio);

      Future.delayed(const Duration(seconds: 3), () async {
        redirect();
      });
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        value += 0.1;
      });
      if (value > 1) timer.cancel();
      log(value.toString());
    });
  }

  Future<void> redirect() async {
    if (context.mounted) {
      PRNavigation.goToHardHomePage(context);
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300]!,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              TextAnimator(
                "Controle de Acesso",
                atRestEffect: WidgetRestingEffects.pulse(effectStrength: 0.6),
                style: AccFontStyle.h1Bold.copyWith(color: secondaryColor),
                textAlign: TextAlign.center,
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
                  blur: const Offset(0, 20),
                  scale: 2,
                ),
              ),
              Text(
                "A festa toda em suas mãos",
                style: AccFontStyle.titleBold.copyWith(color: secondaryColor),
              ),
              Lottie.asset(
                AccAnimations.intro,
                repeat: true,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              Text(
                "Carregando...",
                style: AccFontStyle.body.copyWith(color: secondaryColor),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(
                  minHeight: Responsive.getSize(15),
                  maxHeight: Responsive.getSize(30),
                ),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.blue[200],
                  color: Colors.blue[600],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              SizedBox(height: Responsive.getSize(10)),
            ],
          ),
        ),
      ),
    );
  }
}
