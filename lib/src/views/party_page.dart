import 'package:access_control/components/app_bar.dart';
import 'package:access_control/components/buttons/rectangle_button.dart';
import 'package:access_control/components/cards/guest_resume_card.dart';
import 'package:access_control/components/dialogs/exception_dialog.dart';
import 'package:access_control/components/dialogs/info_dialog.dart';
import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/shared/routes/navigation.dart';
import 'package:access_control/shared/services/launcher/launcher.dart';
import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/src/view_models/details_view_model.dart';
import 'package:access_control/src/view_models/party_view_model.dart';
import 'package:access_control/theme/colors.dart';
import 'package:access_control/utils/constants/animations.dart';
import 'package:access_control/utils/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PartyPage extends StatefulWidget {
  const PartyPage({super.key});

  @override
  State<PartyPage> createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  late final ILauncher launcher;
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  final List<GuestModel> _currentDisplayedGuests = [];

  @override
  void initState() {
    super.initState();
    launcher = Provider.of<ILauncher>(context, listen: false);
  }

  void _syncAnimatedList(List<GuestModel> currentPartyList) {
    final currentIds = _currentDisplayedGuests
        .map((guest) => guest.id)
        .toList();
    final newIds = currentPartyList.map((guest) => guest.id).toList();

    for (int index = _currentDisplayedGuests.length - 1; index >= 0; index--) {
      if (!newIds.contains(_currentDisplayedGuests[index].id)) {
        final removedGuest = _currentDisplayedGuests.removeAt(index);
        _animatedListKey.currentState?.removeItem(
          index,
          (context, animation) =>
              _buildAnimatedCard(removedGuest, animation, true),
        );
      }
    }

    for (int iindex = 0; iindex < currentPartyList.length; iindex++) {
      if (!currentIds.contains(currentPartyList[iindex].id)) {
        _currentDisplayedGuests.insert(iindex, currentPartyList[iindex]);
        _animatedListKey.currentState?.insertItem(
          iindex,
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
    final partyViewModel = Provider.of<PartyViewModel>(context, listen: false);
    final bool isDeleteMode = partyViewModel.isDeleteMode;
    final bool hasSelectedToDelete = partyViewModel.checkIsSelectedToDelete(
      guest,
    );

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
          child: AccGuestResumeCard.withSelector(
            isSelected: hasSelectedToDelete,
            deleteMode: isDeleteMode,
            city: guest.address.city,
            name: guest.name,
            image: guest.picture,
            age: guest.dob.age,
            email: guest.email,
            phone: guest.phone,
            coordinatesModel: guest.address.coordinates,
            onTap: () {
              if (isDeleteMode) {
                partyViewModel.addToDelete(guest);
                return;
              }
              final detailViewModel = Provider.of<DetailsViewModel>(
                context,
                listen: false,
              );
              detailViewModel.setSelectedGuest(guest);
              detailViewModel.setGuestIsOnParty(true);
              PRNavigation.goToDetailsPage(context);
            },
            iconButtons: [],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccAppBar(label: 'Pessoas na festa'),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: secondaryColor),
          child: Consumer<PartyViewModel>(
            builder: (context, partyViewModel, child) {
              final bool isDeleteMode = partyViewModel.isDeleteMode;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _syncAnimatedList(partyViewModel.onPartyList);
              });

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                  SizedBox(height: Responsive.getSize(16)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.getSize(4),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => partyViewModel.setIsDeleteMode(),
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
                                      text: isDeleteMode
                                          ? 'Remover ('
                                          : 'Pessoas na festa (',
                                      style: AccFontStyle.titleBold.copyWith(
                                        color: isDeleteMode
                                            ? alertColor
                                            : black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${partyViewModel.currentModeListSize}',
                                      style: AccFontStyle.titleBold.copyWith(
                                        color: primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: isDeleteMode ? ') pessoas' : ')',
                                      style: AccFontStyle.titleBold.copyWith(
                                        color: isDeleteMode
                                            ? alertColor
                                            : black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                AccIcons.trash,
                                color: isDeleteMode ? alertColor : primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.getSize(10)),

                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: partyViewModel.onPartyFilteredList.isEmpty
                              ? SizedBox(
                                  child: Lottie.asset(
                                    AccAnimations.emptyList,
                                    repeat: true,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                  ),
                                )
                              : AnimatedList(
                                  key: _animatedListKey,
                                  initialItemCount:
                                      _currentDisplayedGuests.length,
                                  itemBuilder: (context, index, animation) {
                                    return _buildAnimatedCard(
                                      _currentDisplayedGuests[index],
                                      animation,
                                    );
                                  },
                                ),
                        ),

                        if (isDeleteMode)
                          Padding(
                            padding: EdgeInsets.all(Responsive.getSize(16)),
                            child: Align(
                              alignment: Alignment.center,
                              child: AccRectangleButton(
                                width: 220,
                                backgroundColor: partyViewModel.canDelete
                                    ? alertColor.withValues(alpha: 0.5)
                                    : lightGrey,
                                onTapBackgroundColor: secondaryColor,
                                onTap: () async {
                                  if (!partyViewModel.canDelete) return;
                                  await partyViewModel.deleteMultipleGuests();
                                  if (partyViewModel.hasError) {
                                    if (context.mounted) {
                                      await AccExceptionDialog.show(
                                        "Atenção",
                                        'Não foi possível remover os convidados',
                                        context,
                                      );
                                    }
                                  }
                                  if (context.mounted) {
                                    await AccInfoDialog.closeAuto(
                                      "Sucesso!",
                                      'Os convidados foram retirados da festa!',
                                      context,
                                    );
                                  }
                                },
                                child: Text(
                                  "Remover ${partyViewModel.currentModeListSize} convidado(s)",
                                  textAlign: TextAlign.center,
                                  style: AccFontStyle.titleBold.copyWith(
                                    color: partyViewModel.canDelete
                                        ? alertColor
                                        : mediumGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
