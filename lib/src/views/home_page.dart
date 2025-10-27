import 'package:access_control/components/app_bar.dart';
import 'package:access_control/components/buttons/animate_icon_button.dart';
import 'package:access_control/components/cards/guest_resume_card.dart';
import 'package:access_control/components/carousels/avatar_carousel.dart';
import 'package:access_control/components/textfields/textfield.dart';
import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/shared/routes/navigation.dart';
import 'package:access_control/shared/services/launcher/launcher.dart';
import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/src/view_models/details_view_model.dart';
import 'package:access_control/src/view_models/home_view_model.dart';
import 'package:access_control/src/view_models/party_view_model.dart';
import 'package:access_control/theme/colors.dart';
import 'package:access_control/utils/constants/animations.dart';
import 'package:access_control/utils/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _refreshController;
  late Animation<double> _rotationAnimation;
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  final List<GuestModel> _currentDisplayedGuests = [];

  late final ILauncher launcher;

  @override
  void initState() {
    super.initState();

    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    launcher = Provider.of<ILauncher>(context, listen: false);

    _refreshController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _rotationAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _refreshController, curve: Curves.linear),
    );

    _refreshController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        homeViewModel.getGuest();
        _refreshController.reset();
        _refreshController.forward();
      }
    });

    homeViewModel.getGuest();
    _refreshController.forward();
  }

  void _syncAnimatedList(List<GuestModel> currentFilteredList) {
    final currentIds = _currentDisplayedGuests
        .map((guest) => guest.profile.uuid)
        .toList();
    final newIds = currentFilteredList
        .map((guest) => guest.profile.uuid)
        .toList();

    for (int index = _currentDisplayedGuests.length - 1; index >= 0; index--) {
      if (!newIds.contains(_currentDisplayedGuests[index].profile.uuid)) {
        final removedGuest = _currentDisplayedGuests.removeAt(index);
        _animatedListKey.currentState?.removeItem(
          index,
          (context, animation) =>
              _buildAnimatedCard(removedGuest, animation, true),
        );
      }
    }

    for (int index = 0; index < currentFilteredList.length; index++) {
      if (!currentIds.contains(currentFilteredList[index].profile.uuid)) {
        _currentDisplayedGuests.insert(index, currentFilteredList[index]);
        _animatedListKey.currentState?.insertItem(
          index,
          duration: const Duration(milliseconds: 500),
        );
      }
    }
  }

  Widget _buildAnimatedCard(
    GuestModel guest,
    Animation<double> animation, [
    bool isRemoving = false,
  ]) {
    final latitude = guest.address.coordinates.latitude;
    final longitude = guest.address.coordinates.longitude;
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: isRemoving ? const Offset(1, 0) : const Offset(-1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: isRemoving ? Curves.easeIn : Curves.easeOut,
                ),
              ),
          child: AccGuestResumeCard(
            city: guest.address.city,
            name: guest.name,
            image: guest.picture,
            age: guest.dob.age,
            email: guest.email,
            phone: guest.phone,
            coordinatesModel: guest.address.coordinates,
            onTap: () {
              final detailViewModel = Provider.of<DetailsViewModel>(
                context,
                listen: false,
              );
              final partyViewModel = Provider.of<PartyViewModel>(
                context,
                listen: false,
              );
              detailViewModel.setSelectedGuest(guest);
              final isOnParty = partyViewModel.checkIsOnParty(guest);
              detailViewModel.setGuestIsOnParty(isOnParty);
              PRNavigation.goToDetailsPage(context);
            },
            iconButtons: [
              AccAnimatedIconButton(
                icon: AccIcons.email,
                onTap: () async => await launcher.sendEmail(guest.email),
                iconColor: primaryFocusColor,
                onTapIconColor: primaryColor,
              ),
              AccAnimatedIconButton(
                icon: AccIcons.phone,
                onTap: () async => await launcher.phoneCall(guest.phone),
                iconColor: primaryFocusColor,
                onTapIconColor: primaryColor,
              ),
              AccAnimatedIconButton(
                icon: AccIcons.map,
                onTap: () async => await launcher.openMap(
                  latitude: latitude,
                  longitude: longitude,
                ),
                iconColor: primaryFocusColor,
                onTapIconColor: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccAppBar(label: 'Controle de acesso'),
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(color: secondaryColor),
            child: Consumer2<HomeViewModel, PartyViewModel>(
              builder: (context, homeViewModel, partyViewModel, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _syncAnimatedList(homeViewModel.filteredList);
                });

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Responsive.getSize(80),
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.getSize(16),
                        vertical: Responsive.getSize(16),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: primaryColor,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: mediumBlue,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: AccTextfield(
                          prefix: Icon(
                            AccIcons.search,
                            color: primaryFocusColor,
                          ),
                          onChanged: (value) {
                            homeViewModel.filterGuests(value);
                            partyViewModel.filterGuests(value);
                          },
                          controller: homeViewModel.filterController,
                          hint: "Buscar convidado...",
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.getSize(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.getSize(4),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            PRNavigation.goToPartyPage(context);
                          },
                          borderRadius: BorderRadius.circular(12),
                          splashColor: primaryColor.withValues(alpha: 0.2),
                          highlightColor: primaryColor.withValues(alpha: 0.1),
                          child: Container(
                            padding: EdgeInsets.all(Responsive.getSize(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Pessoas na festa (',
                                        style: AccFontStyle.titleBold,
                                      ),
                                      TextSpan(
                                        text:
                                            '${partyViewModel.onFilteredPartyQuantity}',
                                        style: AccFontStyle.titleBold.copyWith(
                                          color:
                                              primaryColor, // Destaque para o número
                                        ),
                                      ),
                                      TextSpan(
                                        text: ')',
                                        style: AccFontStyle.titleBold,
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    AccIcons.database,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.getSize(8)),
                    partyViewModel.onPartyFilteredList.isEmpty
                        ? SizedBox(
                            height: Responsive.getSize(80),

                            child: Lottie.asset(
                              AccAnimations.emptyList,
                              repeat: true,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          )
                        : AccAvatarCarousel(
                            guests: partyViewModel.onPartyFilteredList,
                            onTap: (guest) {
                              final detailsViewModel =
                                  Provider.of<DetailsViewModel>(
                                    context,
                                    listen: false,
                                  );
                              detailsViewModel.setSelectedGuest(guest);
                              detailsViewModel.setGuestIsOnParty(true);
                              PRNavigation.goToDetailsPage(context);
                            },
                          ),
                    SizedBox(height: Responsive.getSize(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.getSize(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pessoas na fila (${homeViewModel.onQueueQuantity})',
                            style: AccFontStyle.titleBold,
                          ),
                          AnimatedBuilder(
                            animation: _rotationAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotationAnimation.value * 2 * 3.14159,
                                child: const Icon(Icons.refresh, size: 30),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.getSize(16)),

                    Expanded(
                      child: AnimatedList(
                        key: _animatedListKey,
                        initialItemCount: _currentDisplayedGuests.length,
                        itemBuilder: (context, index, animation) {
                          return _buildAnimatedCard(
                            _currentDisplayedGuests[index],
                            animation,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
