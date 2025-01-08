import 'package:flutter/material.dart';
import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class MyMapView extends StatefulWidget {
  const MyMapView({super.key});

  @override
  State<MyMapView> createState() => _MyMapViewState();
}

class _MyMapViewState extends State<MyMapView> {
  // final mapWidgetController = sdk.MapWidgetController();
  final sdkContext = sdk.DGis.initialize();

  // Future<void> checkLocationPermissions(
  //   sdk.LocationService locationService,
  // ) async {
  //   final permission = await Permission.location.request();
  //   if (permission.isGranted) {
  //     locationService.onPermissionGranted();
  //   }
  // }
  //
  @override
  void initState() {
    super.initState();
    final locationService = sdk.LocationService(sdkContext);
    // checkLocationPermissions(locationService).then((_) {
    //   mapWidgetController.getMapAsync((map) {
    //     final locationSource = sdk.MyLocationMapObjectSource(sdkContext);
    //     map.addSource(locationSource);
    //   });
    // });
  }

  String? _mapStyle;

  void setupMap() async {
    rootBundle.loadString('assets/map_style.json').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: sdk.MapWidget(
          sdkContext: sdkContext,
          // controller: mapWidgetController,
          mapOptions: sdk.MapOptions(
            appearance: sdk.AutomaticAppearance(
              sdk.MapTheme.defaultDayTheme(),
              sdk.MapTheme.defaultNightTheme(),
            ),
            position: const sdk.CameraPosition(
              point: sdk.GeoPoint(
                longitude: sdk.Longitude(31.2444487),
                latitude: sdk.Latitude(30.7493823),
              ),
              zoom: sdk.Zoom(10),
            ),
            // style: sdk.Style
          ),
        ),
      ),
      //     body: SafeArea(
      //   child: sdk.MapWidget(
      //     sdkContext: sdkContext,
      //     // mapOptions: sdk.MapOptions(
      //     //   style: sdk.Style(),
      //     //     position: sdk.CameraPosition(
      //     //         zoom: sdk.Zoom.new(10),
      //     //         point: sdk.GeoPoint(
      //     //             latitude: sdk.Latitude.new(24.7248316),
      //     //             longitude: sdk.Longitude.new(46.4928738)))),
      //     controller: mapWidgetController,
      //     // child: const Padding(
      //     //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      //     //   child: Stack(
      //     //     children: [
      //     //       Column(
      //     //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //     //         mainAxisAlignment: MainAxisAlignment.center,
      //     //         children: [
      //     //           Align(
      //     //             alignment: Alignment.topRight,
      //     //             child: sdk.TrafficWidget(),
      //     //           ),
      //     //           Spacer(),
      //     //           Align(
      //     //             alignment: Alignment.centerRight,
      //     //             child: Column(
      //     //               children: [
      //     //                 sdk.ZoomWidget(),
      //     //                 Padding(
      //     //                   padding: EdgeInsets.only(top: 8),
      //     //                   child: sdk.CompassWidget(),
      //     //                 ),
      //     //                 Padding(
      //     //                   padding: EdgeInsets.only(top: 8),
      //     //                   child: sdk.MyLocationWidget(),
      //     //                 ),
      //     //               ],
      //     //             ),
      //     //           ),
      //     //           Spacer(),
      //     //         ],
      //     //       ),
      //     //       Align(
      //     //         alignment: Alignment.centerLeft,
      //     //         child: sdk.IndoorWidget(),
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),
      //   ),
      // )
    );
  }
}
