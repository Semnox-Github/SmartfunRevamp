import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/colors/colors.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/entities/splash_screen/home_page_cms_response.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/utils/extensions.dart';
import 'package:semnox/core/widgets/image_handler.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';
import 'package:semnox/features/home/widgets/buy_new_card_button.dart';
import 'package:semnox/features/home/widgets/carousel_cards.dart';
import 'package:semnox/features/home/widgets/custom_bottom_bar.dart';
import 'package:semnox/features/home/widgets/home_view_widgets/home_top_bar_icons.dart';
import 'package:semnox/features/home/widgets/link_a_card.dart';
import 'package:semnox/features/home/widgets/recharge_card_details_button.dart';
import 'package:semnox/features/login/widgets/profile_picture.dart';
import 'package:semnox/features/login/widgets/quick_link_item.dart';
import 'package:semnox/features/membership_info/provider/membership_info_provider.dart';
import 'package:semnox/features/recharge_card/pages/select_recharge_card_page.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';
import 'package:semnox/features/splash/provider/new_splash_screen/new_splash_screen_notifier.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

final promoImagesProvider = Provider<List<String>>((ref) {
  final cms = ref.watch(newHomePageCMSProvider);
  final promos = cms?.cmsModulePages
      ?.where((element) => element.displaySection == 'IMAGE')
      .toList();
  return promos?.map((e) => e.contentURL).toList() ?? [];
});

final safePromoImagesProvider =
    FutureProvider.family<List<CMSModulePage>, String>((ref, type) async {
  final cms = ref.watch(newHomePageCMSProvider);
  final promos = cms?.cmsModulePages
      ?.where((element) => element.displaySection == type)
      .toList();
  final safeUrls = <CMSModulePage>[];
  final dio = Dio();
  try {
    for (var image in promos ?? <CMSModulePage>[]) {
      final response = await dio.get(
        image.contentURL,
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        safeUrls.add(image);
      }
    }
    return safeUrls;
  } catch (e) {
    Logger().e(e);
    return [];
  }
});
final homeColors = Provider<CMSModuleColorsHome?>((ref) {
  final cms = ref.watch(newHomePageCMSProvider);
  return cms?.cmsModuleColorsHome;
});

final currentCardProvider = StateProvider<CardDetails?>((ref) {
  final cardsList = ref.watch(CardsProviders.userCardsProvider);

  return cardsList.maybeWhen(
    orElse: () => null,
    data: (data) => data.isNotEmpty ? data.first : null,
  );
});

final userCardProvider = StateProvider<CardDetails?>((ref) {
  final cardsList = ref.watch(CardsProviders.userCardsProvider);
  return cardsList.maybeWhen(
    orElse: () => null,
    data: (data) => data.isNotEmpty ? data.first : null,
  );
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late int _cardIndex = -1;
  late int _cardLength = 0;
  final CarouselController _carouselController = CarouselController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _carouselCardsKey = GlobalKey();

  void _scrollToCarouselCards() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _carouselCardsKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero).dy;
      _scrollController.jumpTo(position);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardsWatch = ref.watch(CardsProviders.userCardsProvider);
    final homeColor = ref.watch(homeColors);
    final user = ref.watch(userProvider);
    final itemsOrder = ref
        .watch(newHomePageCMSProvider)
        ?.homePageOrder
        .sorted((a, b) => a.position.compareTo(b.position));
    itemsOrder?.removeWhere((element) => !element.isVisible);

    ref.watch(SplashScreenNotifier.getInitialData);
    final cardDetails = ref.watch(currentCardProvider);
    // debugPrint("carddetalis $cardDetails");
    cardsWatch.maybeWhen(
      orElse: () => context.loaderOverlay.hide(),
      loading: () => context.loaderOverlay.show(),
      skipLoadingOnRefresh: false,
    );
    AlertDialog buildExitDialog(BuildContext context) {
      return AlertDialog(
        title: MulishText(
          text: SplashScreenNotifier.getLanguageLabel('Please confirm'),
        ),
        content: MulishText(
          text: SplashScreenNotifier.getLanguageLabel(
              'Do you want to exit the app?'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: MulishText(
              text: SplashScreenNotifier.getLanguageLabel('No'),
            ),
          ),
          TextButton(
            onPressed: () => {
              SystemNavigator.pop(),
              Navigator.of(context).pop(true),
            },
            child: MulishText(
              text: SplashScreenNotifier.getLanguageLabel('Yes'),
            ),
          ),
        ],
      );
    }

    Future<bool> onWillPop(BuildContext context) async {
      bool? exitResult = await showDialog(
        context: context,
        builder: (context) => buildExitDialog(context),
      );
      return exitResult ?? false;
    }

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: CustomColors.customLigthBlue,
        bottomNavigationBar: const CustomBottomBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                    color: CustomColors.customLigthBlue,
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 10.0, right: 10.0),
                    child: Row(
                      children: [
                        ProfilePicture(customerDTO: user!),
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
                                  error: (_, __) =>
                                      const MulishText(text: 'Error '),
                                  loading: () => const ShimmerLoading(
                                    height: 10.0,
                                    width: 50,
                                  ),
                                  data: (data) {
                                    if (data.membershipId == -1) {
                                      return Container();
                                    }
                                    return MulishText(
                                      text:
                                          SplashScreenNotifier.getLanguageLabel(
                                              '${data.memberShipName}'),
                                      fontWeight: FontWeight.bold,
                                    );
                                  },
                                ),
                          ],
                        ),
                        const Spacer(),
                        HomeTopBarIcons(
                          onSearchTap: () =>
                              Navigator.pushNamed(context, Routes.kSearch),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...itemsOrder?.map(
                            (e) {
                              List<CMSModulePage>? content = ref
                                  .watch(newHomePageCMSProvider)
                                  ?.getLinks(e.displaySection ?? '');
                              switch (e.widget) {
                                case "CARDS":
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                      color: HexColor.fromHex(
                                          homeColor?.upperHalf),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          SplashScreenNotifier.getLanguageLabel(
                                              e.title),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: cardsWatch.when(
                                            skipLoadingOnRefresh: false,
                                            loading: () => const ShimmerLoading(
                                                height: 200),
                                            error: (_, __) => Center(
                                              child: MulishText(
                                                  text: SplashScreenNotifier
                                                      .getLanguageLabel(
                                                          'No Cards found')),
                                            ),
                                            data: (data) {
                                              return Column(
                                                children: [
                                                  data.isNotEmpty
                                                      ? CarouselCards(
                                                          key:
                                                              _carouselCardsKey,
                                                          carouselController:
                                                              _carouselController,
                                                          initialPosition:
                                                              _cardIndex,
                                                          cards: data,
                                                          onCardChanged:
                                                              (cardIndex) {
                                                            setState(() {
                                                              _cardIndex =
                                                                  cardIndex;
                                                              _cardLength =
                                                                  data.length;
                                                            });
                                                            if (cardIndex !=
                                                                data.length) {
                                                              ref
                                                                  .read(currentCardProvider
                                                                      .notifier)
                                                                  .update((state) =>
                                                                      data[
                                                                          cardIndex]);
                                                            } else {
                                                              ref
                                                                  .read(currentCardProvider
                                                                      .notifier)
                                                                  .update(
                                                                      (state) =>
                                                                          null);
                                                            }
                                                          },
                                                        )
                                                      : LinkACard(),
                                                  if (data.isNotEmpty &&
                                                      _cardIndex != data.length)
                                                    RechargeCardDetailsButton(
                                                      cardDetails:
                                                          cardDetails ??
                                                              data.first,
                                                      cardIndex: _cardIndex,
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
                                  );
                                case "LINKS":
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          SplashScreenNotifier.getLanguageLabel(
                                              e.title),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        cardsWatch.when(
                                          error: (error, stackTrace) =>
                                              Container(),
                                          loading: () => const ShimmerLoading(
                                              height: 200.0),
                                          data: (data) {
                                            bool hasCard =
                                                data.isNotEmpty ? true : false;
                                            String msgCardNoLink =
                                                SplashScreenNotifier
                                                    .getLanguageLabel(
                                                        'No card is associated with customer, please link your card.');
                                            if (content.isNullOrEmpty()) {
                                              return const MulishText(
                                                  text:
                                                      'No quicklinks setup. Contact your administrator');
                                            }
                                            return GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                              ),
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: content!.length,
                                              itemBuilder: (context, index) {
                                                final quickLink =
                                                    content[index];
                                                return SizedBox(
                                                  height: 45,
                                                  width: 45,
                                                  child: QuickLinkItem(
                                                    color: quickLink
                                                        .backgroundColor,
                                                    imageUrl:
                                                        quickLink.contentURL,
                                                    text: SplashScreenNotifier
                                                        .getLanguageLabel(
                                                            quickLink
                                                                .contentName),
                                                    onTap: () {
                                                      if (quickLink.source
                                                              .toLowerCase() ==
                                                          'recharge') {
                                                        if (!hasCard) {
                                                          Dialogs.showMessageInfo(
                                                              context,
                                                              SplashScreenNotifier
                                                                  .getLanguageLabel(
                                                                      'Recharge Card'),
                                                              msgCardNoLink);
                                                        } else {
                                                          //if the user has no card selected show dialog
                                                          if (cardDetails ==
                                                              null) {
                                                            Dialogs
                                                                .showMessageInfo(
                                                              context,
                                                              SplashScreenNotifier
                                                                  .getLanguageLabel(
                                                                      'Recharge Card'),
                                                              SplashScreenNotifier
                                                                  .getLanguageLabel(
                                                                      "Please select a card to recharge."),
                                                            );
                                                            //if there is a card selected and is not blocked or expired then navigate
                                                          } else if (!(cardDetails
                                                                  .isBlocked() ||
                                                              cardDetails
                                                                  .isExpired())) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const SelectCardRechargePage(),
                                                              ),
                                                            );
                                                          } else {
                                                            //else show dialog
                                                            Dialogs
                                                                .showMessageInfo(
                                                              context,
                                                              SplashScreenNotifier
                                                                  .getLanguageLabel(
                                                                      'Recharge Card'),
                                                              SplashScreenNotifier
                                                                  .getLanguageLabel(
                                                                      "Temporary or expired cards can't be recharged."),
                                                            );
                                                          }
                                                        }
                                                      } else if (quickLink
                                                              .source
                                                              .toLowerCase() ==
                                                          'link card') {
                                                        _scrollToCarouselCards();
                                                        _carouselController
                                                            .animateToPage(
                                                                _cardLength);

                                                        // Scroll to CarouselCards
                                                        Navigator.pushNamed(
                                                            context,
                                                            Routes
                                                                .kLinkPageCard);
                                                      } else if (quickLink
                                                              .source
                                                              .toLowerCase() ==
                                                          'transfer credits') {
                                                        if (hasCard) {
                                                          if (cardDetails ==
                                                                  null ||
                                                              cardDetails
                                                                  .isBlocked() ||
                                                              cardDetails
                                                                  .isExpired()) {
                                                            Dialogs.showMessageInfo(
                                                                context,
                                                                SplashScreenNotifier
                                                                    .getLanguageLabel(
                                                                        'Transfer Credits'),
                                                                SplashScreenNotifier
                                                                    .getLanguageLabel(
                                                                        'Please select an active card'));
                                                          } else {
                                                            Navigator.pushNamed(
                                                                context,
                                                                quickLink
                                                                    .contentKey
                                                                    .replaceAll(
                                                                        'sf:/',
                                                                        ''));
                                                          }
                                                        } else {
                                                          Dialogs.showMessageInfo(
                                                              context,
                                                              SplashScreenNotifier
                                                                  .getLanguageLabel(
                                                                      'Transfer Credits'),
                                                              msgCardNoLink);
                                                        }
                                                      } else {
                                                        if (hasCard) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              quickLink
                                                                  .contentKey
                                                                  .replaceAll(
                                                                      'sf:/',
                                                                      ''));
                                                        } else if (!hasCard &&
                                                            quickLink.source
                                                                    .toLowerCase() ==
                                                                "buy a card") {
                                                          Navigator.pushNamed(
                                                            context,
                                                            quickLink.contentKey
                                                                .replaceAll(
                                                                    'sf:/', ''),
                                                          );
                                                        } else {
                                                          Dialogs.showMessageInfo(
                                                              context,
                                                              SplashScreenNotifier
                                                                  .getLanguageLabel(
                                                                      'Activities'),
                                                              msgCardNoLink);
                                                        }
                                                      }
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                case "CAROUSEL":
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MulishText(
                                          text: SplashScreenNotifier
                                              .getLanguageLabel(e.title),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                        PromoImages(
                                          contentDisplay:
                                              e.displaySection ?? '',
                                        ),
                                      ],
                                    ),
                                  );
                                default:
                                  return Container();
                              }
                            },
                          ).toList() ??
                          [],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PromoImages extends ConsumerWidget {
  const PromoImages({
    required this.contentDisplay,
    super.key,
  });
  final String contentDisplay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(safePromoImagesProvider(contentDisplay)).when(
          error: (error, stacktrace) {
            Logger().e('Hubo un error', error, stacktrace);
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          data: (images) {
            if (images.isEmpty) {
              return const ImageHandler(
                imageKey: "no_promo_image_path",
              );
            }
            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                height: 200.0,
                enableInfiniteScroll: images.length > 1,
                enlargeCenterPage: true,
              ),
              items: images.map((promo) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        final Uri url = Uri.parse(promo.contentKey);
                        launchUrl(url);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CachedNetworkImage(
                          imageUrl: promo.contentURL,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (_, __, ___) => Container(),
                        ),
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
