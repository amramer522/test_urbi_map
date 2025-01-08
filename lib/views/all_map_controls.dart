import 'package:dgis_mobile_sdk_full/dgis.dart' as sdk;
import 'package:flutter/material.dart';

import 'common.dart';

class AllMapControlsPage extends StatefulWidget {
  final String title;

  const AllMapControlsPage({required this.title, super.key});

  @override
  State<AllMapControlsPage> createState() => _AllMapControlsPageState();
}

class _AllMapControlsPageState extends State<AllMapControlsPage> {
  final mapWidgetController = sdk.MapWidgetController();
  final sdkContext = sdk.DGis.initialize();

  @override
  void initState() {
    super.initState();
    final locationService = sdk.LocationService(sdkContext);
    checkLocationPermissions(locationService).then((_) {
      mapWidgetController.getMapAsync((map) {
        final locationSource = sdk.MyLocationMapObjectSource(sdkContext);
        map.addSource(locationSource);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      // bottomSheet: DraggableScrollableSheet(
      //   minChildSize: .2,
      //   maxChildSize: .9,
      //   initialChildSize: .5,
      //   builder: (context, scrollController) => Container(color: Colors.red),
      // ),
      body: sdk.MapWidget(
        sdkContext: sdkContext,
        mapOptions: sdk.MapOptions(
          position:  sdk.CameraPosition(
            point: sdk.GeoPoint(
              longitude: sdk.Longitude(31.2444487),
              latitude: sdk.Latitude(30.7493823),
            ),
            zoom: sdk.Zoom(16),
          ),
        ),
        controller: mapWidgetController,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: sdk.TrafficWidget(),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        sdk.ZoomWidget(),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: sdk.CompassWidget(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: sdk.MyLocationWidget(),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: sdk.IndoorWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
