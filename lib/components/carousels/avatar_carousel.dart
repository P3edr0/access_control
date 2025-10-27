import 'package:access_control/components/circle_avatar.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/theme/colors.dart';
import 'package:flutter/material.dart';

class AccAvatarCarousel extends StatefulWidget {
  const AccAvatarCarousel({
    super.key,
    required this.guests,
    required this.onTap,
  });
  final List<GuestModel> guests;
  final Function(GuestModel guest) onTap;

  @override
  State<AccAvatarCarousel> createState() => _AccAvatarCarouselState();
}

class _AccAvatarCarouselState extends State<AccAvatarCarousel>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _waveController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.getSize(90),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.guests.length,
        itemBuilder: (context, index) {
          final guest = widget.guests[index];
          final bool isFirst = index == 0;

          return _buildWaveAvatar(guest, isFirst, index);
        },
      ),
    );
  }

  Widget _buildWaveAvatar(GuestModel guest, bool isFirst, int index) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Interval(
          (index * 0.1).clamp(0.0, 0.7),
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset((1 - animation.value) * -100, 0),
          child: Opacity(
            opacity: animation.value,
            child: Padding(
              padding: EdgeInsets.only(
                right: Responsive.getSize(10),
                left: isFirst ? Responsive.getSize(16) : 0,
              ),
              child: AccCircleAvatar(
                backgroundColor: primaryColor,
                picture: guest.picture,
                size: 42,
                onTap: () => widget.onTap(guest),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }
}
