import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/buy_new_card_button.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/home/widgets/home_view_widgets/home_top_bar_icons.dart';
import 'package:semnox/features/home/widgets/link_a_card.dart';
import 'package:semnox/features/home/widgets/recharge_card_details_button.dart';
import 'package:semnox/features/login/widgets/profile_picture.dart';
import 'package:semnox/features/login/widgets/quick_link_item.dart';
import 'package:semnox/features/membership_info/provider/membership_info_provider.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';
import 'package:semnox/features/splash/cms_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:shimmer/shimmer.dart';

final promoImagesProvider = Provider<List<String>>((ref) {
  final cms = ref.watch(cmsProvider).value;
  final promos = cms?.cmsModulePages?.where((element) => element.displaySection == 'IMAGE').toList();
  return promos?.map((e) => e.contentURL).toList() ?? [];
});

final safePromoImagesProvider = FutureProvider<List<String>>((ref) async {
  final cms = ref.watch(cmsProvider).value;
  final promos = cms?.cmsModulePages?.where((element) => element.displaySection == 'IMAGE').toList();
  final promoImagesUrl = promos?.map((e) => e.contentURL).toList() ?? [];
  final safeUrls = <String>[];
  final dio = Dio();
  try {
    for (var path in promoImagesUrl) {
      final response = await dio.get(
        path,
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        safeUrls.add(path);
      }
    }
    return safeUrls;
  } catch (e) {
    Logger().e(e);
    return [];
  }
});
final homeColors = Provider<CMSModuleColorsHome?>((ref) {
  final cms = ref.watch(cmsProvider).value;
  return cms?.cmsModuleColorsHome;
});

final currentCardProvider = StateProvider<CardDetails?>((ref) {
  final cardsList = ref.watch(CardsProviders.userCardsProvider);
  return cardsList.maybeWhen(
    orElse: () => null,
    data: (data) => data.first,
  );
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final user = Get.find<CustomerDTO>();
  int _cardIndex = -1;

  @override
  Widget build(BuildContext context) {
    final cardsWatch = ref.watch(CardsProviders.userCardsProvider);
    final promoImages = ref.watch(promoImagesProvider);
    final homeColor = ref.watch(homeColors);
    final cardDetails = ref.watch(currentCardProvider);
    final routes = ref.watch(cmsProvider).value?.quickLinksRoutes;
    cardsWatch.maybeWhen(
      orElse: () => context.loaderOverlay.hide(),
      loading: () => context.loaderOverlay.show(),
      skipLoadingOnRefresh: false,
    );
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: HexColor.fromHex(homeColor?.upperHalf) ?? CustomColors.customLigthBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ProfilePicture(customerDTO: user),
                      const SizedBox(width: 10.0),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.profileDto?.firstName} ${user.profileDto?.lastName}',
                            style: const TextStyle(
                              color: CustomColors.customBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          ref.watch(membershipInfoProvider).when(
                                error: (_, __) => const MulishText(text: 'Error '),
                                loading: () => const ShimmerLoading(
                                  height: 10.0,
                                  width: 50,
                                ),
                                data: (data) {
                                  if (data.membershipId == -1) {
                                    return Container();
                                  }
                                  return MulishText(
                                    text: SplashScreenNotifier.getLanguageLabel('${data.memberShipName}'),
                                    fontWeight: FontWeight.bold,
                                  );
                                },
                              ),
                        ],
                      ),
                      const Spacer(),
                      HomeTopBarIcons(
                        onSearchTap: () => Navigator.pushNamed(context, Routes.kSearch),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: cardsWatch.when(
                      skipLoadingOnRefresh: false,
                      loading: () => const ShimmerLoading(height: 200),
                      error: (_, __) => Center(
                        child: MulishText(text: SplashScreenNotifier.getLanguageLabel('No Cards found')),
                      ),
                      data: (data) {
                        return Column(
                          children: [
                            data.isNotEmpty
                                ? CarouselCards(
                                    cards: data,
                                    onCardChanged: (cardIndex) {
                                      if (cardIndex != data.length) {
                                        ref.read(currentCardProvider.notifier).update((state) => data[cardIndex]);
                                      } else {
                                        ref.read(currentCardProvider.notifier).update((state) => null);
                                      }
                                      _cardIndex = cardIndex;
                                    },
                                  )
                                : LinkACard(),
                            if (data.isNotEmpty && _cardIndex != data.length)
                              RechargeCardDetailsButton(
                                cardDetails: cardDetails ?? data.first,
                              )
                            else
                              const BuyNewCardButton(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0,
              width: 0,
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(getAllSitesProvider).maybeWhen(
                        orElse: () => Container(),
                      );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        SplashScreenNotifier.getLanguageLabel('Quick Links'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  cardsWatch.when(
                    error: (error, stackTrace) => Container(),
                    loading: () => const ShimmerLoading(height: 200.0),
                    data: (data) {
                      bool hasCard = data.isNotEmpty ? true : false;
                      String msgCardNoLink = SplashScreenNotifier.getLanguageLabel('No card is associated with customer, please link your card.');
                      return GridView(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          QuickLinkItem(
                            color: CustomColors.customYellow,
                            image: 'recharge',
                            text: SplashScreenNotifier.getLanguageLabel('Recharge'),
                            onTap: () => ({
                              //if there is not a card selected then show alert dialog
                              if (!hasCard)
                                {Dialogs.showMessageInfo(context, SplashScreenNotifier.getLanguageLabel('Recharge Card'), msgCardNoLink)}
                              else
                                {
                                  //if the user has no card selected show dialog
                                  if (cardDetails == null)
                                    {
                                      Dialogs.showMessageInfo(
                                        context,
                                        SplashScreenNotifier.getLanguageLabel('Recharge Card'),
                                        SplashScreenNotifier.getLanguageLabel("Please select a card to recharge."),
                                      )
                                      //if there is a card selected and is not blocked or expired then navigate
                                    }
                                  else if (!(cardDetails.isBlocked() || cardDetails.isExpired()))
                                    {Navigator.pushNamed(context, routes?.rechargePage ?? Routes.kRechargePageCard)}
                                  else
                                    {
                                      //else show dialog
                                      Dialogs.showMessageInfo(
                                        context,
                                        SplashScreenNotifier.getLanguageLabel('Recharge Card'),
                                        SplashScreenNotifier.getLanguageLabel("Temporary or expired cards can't be recharged."),
                                      )
                                    }
                                }
                            }),
                          ),
                          QuickLinkItem(
                            color: CustomColors.customPink,
                            image: 'new_card',
                            text: SplashScreenNotifier.getLanguageLabel('New Card'),
                            onTap: () => Navigator.pushNamed(context, routes?.newCardPage ?? Routes.kBuyACard),
                          ),
                          QuickLinkItem(
                            color: CustomColors.customLigthBlue,
                            image: 'activities',
                            text: SplashScreenNotifier.getLanguageLabel('Activities'),
                            onTap: () => hasCard
                                ? Navigator.pushNamed(context, routes?.activitiesPage ?? Routes.kActivities)
                                : Dialogs.showMessageInfo(context, SplashScreenNotifier.getLanguageLabel('Activities'), msgCardNoLink),
                          ),
                          QuickLinkItem(
                            color: CustomColors.customOrange,
                            image: 'lost_card',
                            text: SplashScreenNotifier.getLanguageLabel('Lost Card'),
                            onTap: () => hasCard
                                ? Navigator.pushNamed(context, routes?.lostCardPage ?? Routes.kLostPageCard)
                                : Dialogs.showMessageInfo(context, SplashScreenNotifier.getLanguageLabel('Lost Card'), msgCardNoLink),
                          ),
                          QuickLinkItem(
                            color: CustomColors.customGreen,
                            image: 'gameplays',
                            text: SplashScreenNotifier.getLanguageLabel('Game Plays'),
                            onTap: () => hasCard
                                ? Navigator.pushNamed(context, routes?.gameplaysPages ?? Routes.kGameplays)
                                : Dialogs.showMessageInfo(context, SplashScreenNotifier.getLanguageLabel('Game Plays'), msgCardNoLink),
                          ),
                          QuickLinkItem(
                            color: CustomColors.customPurple,
                            image: 'transfer_credit',
                            text: SplashScreenNotifier.getLanguageLabel('Transfer Credit'),
                            onTap: () => hasCard
                                ? Navigator.pushNamed(context, routes?.transferPage ?? Routes.kTransfers)
                                : Dialogs.showMessageInfo(context, SplashScreenNotifier.getLanguageLabel('Transfer Credit'), msgCardNoLink),
                          ),
                        ],
                      );
                    },
                  ),
                  MulishText(
                    text: SplashScreenNotifier.getLanguageLabel("Today's Offers"),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  PromoImages(promoImages: promoImages),
                  MulishText(
                    text: SplashScreenNotifier.getLanguageLabel('More Actions'),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      QuickLinkItem(
                        color: CustomColors.customPink,
                        image: 'new_card',
                        text: SplashScreenNotifier.getLanguageLabel('Link A Card'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  height: 245,
                                  padding: const EdgeInsets.all(10),
                                  child: LinkACard(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      QuickLinkItem(
                        color: CustomColors.customYellow,
                        image: 'tickets',
                        text: SplashScreenNotifier.getLanguageLabel('Tickets'),
                        onTap: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Not implemented'),
                            ),
                          );
                        },
                      ),
                      QuickLinkItem(
                        color: CustomColors.customOrange,
                        image: 'coupons',
                        text: SplashScreenNotifier.getLanguageLabel('Coupons'),
                        onTap: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Not implemented'),
                            ),
                          );
                        },
                      ),
                      QuickLinkItem(
                        color: CustomColors.customGreen,
                        image: 'events',
                        text: SplashScreenNotifier.getLanguageLabel('Events'),
                        onTap: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Not implemented'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoImages extends ConsumerWidget {
  const PromoImages({
    super.key,
    required this.promoImages,
  });

  final List<String> promoImages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(safePromoImagesProvider).when(
          error: (error, stacktrace) {
            Logger().e('Hubo un error', error, stacktrace);
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
          data: (images) {
            if (images.isEmpty) {
              return Image.asset('assets/home/no_promo_image.png');
            }
            return CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: images.length > 1,
                enlargeCenterPage: true,
              ),
              items: images.map((imageLink) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageLink,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (_, __, ___) => Container(),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
    required this.height,
    this.width = double.infinity,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
