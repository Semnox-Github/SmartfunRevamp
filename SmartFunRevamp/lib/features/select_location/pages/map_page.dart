import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/routes.dart';
import 'package:semnox/core/utils/dialogs.dart';
import 'package:semnox/core/widgets/custom_button.dart';
import 'package:semnox/core/widgets/mulish_text.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox/features/select_location/provider/select_location_provider.dart';
import 'package:semnox/features/splash/provider/splash_screen_notifier.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

const CameraPosition kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 15,
);

final _locationProvider = FutureProvider.autoDispose<Position>((ref) async {
  final geolocator = GeolocatorPlatform.instance;
  LocationPermission permission = await geolocator.checkPermission();
  Logger().d(permission);
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Permission Denied');
    }
  }
  return await geolocator.getCurrentPosition();
});

// final userLocationProvider = StateProvider.autoDispose<Position?>((ref) {
//   final position = ref.watch(_locationProvider).valueOrNull;
//   return position;
// });

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late GoogleMapController _mapController;
  bool hasSelectedSite = false;
  late SiteViewDTO selectedSite;
  @override
  Widget build(BuildContext context) {
    ref.listen(
      selectLocationStateProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () => context.loaderOverlay.hide(),
          error: (message) {
            context.loaderOverlay.hide();
            Dialogs.showErrorMessage(context, message);
          },
          inProgress: () => context.loaderOverlay.show(),
          newContextSuccess: (selectedSite) {
            ref.read(loginProvider.notifier).selectedSite = selectedSite;
            ref.read(loginProvider.notifier).saveSelectedSite();
            context.loaderOverlay.hide();
            Navigator.pushReplacementNamed(context, Routes.kHomePage);
          },
        );
      },
    );

    ref.listen(_locationProvider, (_, next) {
      next.maybeWhen(
        orElse: () => {},
        error: (_, __) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: SplashScreenNotifier.getLanguageLabel('Error'),
            desc: 'No location permission granted',
            descTextStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            btnOkOnPress: () {
              Navigator.pop(context);
            },
            useRootNavigator: true,
            btnOkText: SplashScreenNotifier.getLanguageLabel('OK'),
            btnOkColor: Colors.red,
          ).show();
        },
      );
    });
    return Scaffold(
      floatingActionButton: hasSelectedSite
          ? CustomButton(
              label: 'Select',
              onTap: () {
                ref.read(selectLocationStateProvider.notifier).selectSite(selectedSite);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            return ref.watch(_locationProvider).when(
                  error: (_, __) => const SizedBox.shrink(),
                  loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                  data: (data) {
                    Set<Marker> markers = {};
                    Marker resultMarker = Marker(
                      markerId: const MarkerId('ME'),
                      infoWindow: const InfoWindow(title: "Me"),
                      position: LatLng(data.latitude, data.longitude),
                    );
                    markers.add(resultMarker);
                    final sites = ref.watch(getAllSitesProvider);
                    return sites.when(
                      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                      error: (_, __) => Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            MulishText(
                              text: SplashScreenNotifier.getLanguageLabel('There was an error'),
                            )
                          ],
                        ),
                      ),
                      data: (sitesCoordinates) {
                        for (var site in sitesCoordinates) {
                          if (site.latitude != null && site.longitude != null) {
                            Marker resultMarker = Marker(
                              markerId: MarkerId(site.siteName ?? ''),
                              infoWindow: InfoWindow(title: "${site.siteName}"),
                              position: LatLng(site.latitude!, site.longitude!),
                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                              onTap: () {
                                selectedSite = site;
                                if (!hasSelectedSite) {
                                  setState(() {
                                    hasSelectedSite = true;
                                  });
                                }
                              },
                            );
                            markers.add(resultMarker);
                          }
                        }

                        return GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: kGooglePlex,
                          onMapCreated: (mapController) {
                            _mapController = mapController;
                            _mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(data.latitude, data.longitude), 15));
                            _controller.complete(mapController);
                          },
                          markers: markers,
                          myLocationEnabled: true,
                        );
                      },
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
