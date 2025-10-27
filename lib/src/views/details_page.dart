import 'package:access_control/components/app_bar.dart';
import 'package:access_control/components/buttons/animate_icon_button.dart';
import 'package:access_control/components/cards/description_card/description_card.dart';
import 'package:access_control/components/cards/description_card/description_card_item.dart';
import 'package:access_control/components/cards/detail_profile_card.dart';
import 'package:access_control/components/dialogs/exception_dialog.dart';
import 'package:access_control/components/dialogs/info_dialog.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/shared/services/launcher/launcher.dart';
import 'package:access_control/src/view_models/details_view_model.dart';
import 'package:access_control/src/view_models/home_view_model.dart';
import 'package:access_control/src/view_models/party_view_model.dart';
import 'package:access_control/theme/colors.dart';
import 'package:access_control/utils/constants/icons.dart';
import 'package:access_control/utils/enums/gender.dart';
import 'package:access_control/utils/formatters/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final HomeViewModel homeViewModel;
  late final PartyViewModel partyViewModel;
  late final ILauncher launcher;
  final DateFormatter dateFormatter = DateFormatter();

  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    partyViewModel = Provider.of<PartyViewModel>(context, listen: false);
    launcher = Provider.of<ILauncher>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccAppBar(label: "Detalhes"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<DetailsViewModel>(
            builder: (context, detailsViewModel, child) {
              final selectedGuest = detailsViewModel.selectedGuest!;
              final gender = Gender.translate(selectedGuest.gender);
              final isOnParty = detailsViewModel.isOnParty;
              final picture = selectedGuest.picture;
              final age = selectedGuest.dob.age;
              final name = selectedGuest.name;
              final latitude = selectedGuest.address.coordinates.latitude;
              final longitude = selectedGuest.address.coordinates.longitude;
              return Container(
                decoration: BoxDecoration(color: secondaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccDetailProfileCard(
                      picture: picture,
                      isOnParty: isOnParty,
                      onTapAddOnParty: () async {
                        final newId = await partyViewModel.addGuestOnParty(
                          selectedGuest,
                        );
                        if (partyViewModel.hasError) {
                          final exceptionContent =
                              partyViewModel.exception.message;
                          if (context.mounted) {
                            await AccExceptionDialog.show(
                              "Atenção!",
                              exceptionContent,
                              context,
                            );
                          }
                        } else {
                          if (selectedGuest.id == null && newId != null) {
                            final newGuest = selectedGuest.copyWith(id: newId);
                            detailsViewModel.setSelectedGuest(newGuest);
                          }
                          if (context.mounted) {
                            await AccInfoDialog.closeAuto(
                              "Sucesso",
                              'O convidado entrou na festa!',
                              context,
                            );
                          }

                          homeViewModel.removeGuest(selectedGuest);
                          detailsViewModel.setGuestIsOnParty(true);
                        }
                      },
                      onTapRemoveOnParty: () async {
                        await partyViewModel.removeGuestOnParty(selectedGuest);
                        if (partyViewModel.hasError) {
                          final exceptionContent =
                              partyViewModel.exception.message;
                          if (context.mounted) {
                            await AccExceptionDialog.show(
                              "Atenção!",
                              exceptionContent,
                              context,
                            );
                          }
                        } else {
                          if (context.mounted) {
                            await AccInfoDialog.closeAuto(
                              "Sucesso!",
                              'O convidado foi retirado da festa!',
                              context,
                            );
                          }
                          homeViewModel.insertGuest(selectedGuest);
                          detailsViewModel.setGuestIsOnParty(false);
                        }
                      },
                      age: age,
                      iconButtons: [
                        AccAnimatedIconButton(
                          icon: AccIcons.email,
                          onTap: () async =>
                              await launcher.sendEmail(selectedGuest.email),
                          iconColor: primaryFocusColor,
                          onTapIconColor: primaryColor,
                        ),
                        AccAnimatedIconButton(
                          icon: AccIcons.phone,
                          onTap: () async =>
                              await launcher.phoneCall(selectedGuest.phone),
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
                      isMale: gender.isMale,
                      name: name,
                    ),

                    SizedBox(height: Responsive.getSize(16)),

                    AccDescriptionCard(
                      title: 'Localização',
                      icon: FeatherIcons.mapPin,
                      items: [
                        AccDescriptionCardItem(
                          fieldTitle: 'Rua',
                          content: selectedGuest.address.street.name,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Número',
                          content: selectedGuest.address.street.number
                              .toString(),
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Cidade',
                          content: selectedGuest.address.city,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Estado',
                          content: selectedGuest.address.state,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'País',
                          content: selectedGuest.address.country,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'CEP',
                          content: selectedGuest.address.postcode,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Latitude',
                          content: selectedGuest.address.coordinates.latitude,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Longitude',
                          content: selectedGuest.address.coordinates.longitude,
                          withDivider: false,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Offset',
                          content: selectedGuest.address.timezone.offset,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Marco fuso horário',
                          content: selectedGuest.address.timezone.description
                              .toString(),
                          withDivider: false,
                        ),
                      ],
                    ),

                    SizedBox(height: Responsive.getSize(16)),
                    AccDescriptionCard.secondary(
                      centralColor: secondaryColor,
                      title: 'Perfil',
                      icon: FeatherIcons.user,
                      items: [
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Nome do usuário',
                          content: selectedGuest.profile.username,
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Senha',
                          content: selectedGuest.profile.password.toString(),
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Id ref',
                          content: selectedGuest.systemId.name.toString(),
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Id',
                          content: selectedGuest.systemId.value.toString(),
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Dat. Nascimento',
                          content: dateFormatter.toBrazilFormat(
                            selectedGuest.dob.date,
                          ),
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Naturalidade',
                          content: selectedGuest.nat,
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'UUID',
                          content: selectedGuest.profile.uuid,
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Data de registro',
                          content: dateFormatter.toBrazilFormat(
                            selectedGuest.registry.date,
                          ),
                        ),
                        AccDescriptionCardItem.secondary(
                          textColor: primaryColor,
                          dividerColor: primaryFocusColor,
                          fieldTitle: 'Tempo de registro',
                          content: '${selectedGuest.registry.age} anos',
                          withDivider: false,
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.getSize(16)),
                    AccDescriptionCard(
                      title: 'Contato',
                      icon: FeatherIcons.phone,
                      items: [
                        AccDescriptionCardItem(
                          fieldTitle: 'Email',
                          content: selectedGuest.email,
                        ),
                        AccDescriptionCardItem(
                          fieldTitle: 'Telefone',
                          content: selectedGuest.phone.toString(),
                        ),

                        AccDescriptionCardItem(
                          fieldTitle: 'Celular',
                          content: selectedGuest.cell.toString(),
                          withDivider: false,
                        ),
                      ],
                    ),

                    SizedBox(height: Responsive.getSize(16)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
