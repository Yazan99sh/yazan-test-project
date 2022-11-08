import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_project/presentation/core/widget/loader.dart';
import 'package:location/location.dart' as loc;

import 'package:permission_handler/permission_handler.dart';

class GetLocationWidget extends StatefulWidget {
  final Widget Function(double lat, double long) whenDone;
  final bool required;

  const GetLocationWidget({
    Key? key,
    required this.whenDone,
    this.required = false,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetLocationWidgetState createState() => _GetLocationWidgetState();
}

class _GetLocationWidgetState extends State<GetLocationWidget> {
  late Future<bool> gpsServiceStatus;

  late Future<loc.PermissionStatus> locationPermissionStatus;
  bool _skip = false;

  @override
  void initState() {
    gpsServiceStatus = loc.Location.instance.requestService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToLocation();
    });
    super.initState();
  }

  final loc.Location location = loc.Location();

  late loc.LocationData locationData;

  ///canada lat and long
  double _lat = 54.87043037410258;
  double _long = -104.91493251174687;

  bool refreshRequired = false;

  Future<void> _goToLocation() async {
    gpsServiceStatus =
        loc.Location.instance.requestService().then((value) async {
      if (value) {
        setState(() {
          locationPermissionStatus =
              loc.Location.instance.requestPermission().then((value) async {
            if (value == loc.PermissionStatus.granted ||
                value == loc.PermissionStatus.grantedLimited) {
              locationData = await location.getLocation();
              if (locationData.longitude != null &&
                  locationData.latitude != null) {
                _lat = locationData.latitude!;
                _long = locationData.longitude!;
              }
            }
            return Future.value(value);
          });
        });
      }
      return Future.value(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (refreshRequired) {
      return Center(
        child: MaterialButton(
          color: Theme.of(context).cardTheme.color,
          child: Icon(
            Icons.refresh_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              _goToLocation();
              refreshRequired = false;
            });
          },
        ),
      );
    }
    return widget.required == true || _skip == false
        ? FutureBuilder<bool>(
            future: gpsServiceStatus,
            builder: (context, snapshot) {
              // if (!snapshot.hasData) {
              //   return const Center(
              //     child: Loader(),
              //   );
              // }
              /*else*/ if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gpsServiceStatus =
                                loc.Location.instance.requestService();
                          });
                        },
                        child: const Text(
                          'enable_location_service',
                        ).tr(),
                      ),
                      _buttonSkip()
                    ],
                  ),
                );
              }
              return FutureBuilder<loc.PermissionStatus>(
                  future: locationPermissionStatus,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Loader(),
                      );
                    } else if (snapshot.data == loc.PermissionStatus.denied) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  gpsServiceStatus =
                                      loc.Location.instance.requestService();
                                });
                              },
                              child: const Text(
                                'enable_location_service',
                              ).tr(),
                            ),
                            _buttonSkip()
                          ],
                        ),
                      );
                    } else if (snapshot.data ==
                        loc.PermissionStatus.deniedForever) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await openAppSettings();
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                setState(
                                  () {
                                    refreshRequired = true;
                                  },
                                );
                              },
                              child: const Text(
                                'enable_location_permission_from_setting',
                              ).tr(),
                            ),
                            _buttonSkip()
                          ],
                        ),
                      );
                    } else if (snapshot.data == loc.PermissionStatus.denied) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  locationPermissionStatus = loc
                                      .Location.instance
                                      .requestPermission()
                                      .then((value) async {
                                    if (value == loc.PermissionStatus.granted ||
                                        value ==
                                            loc.PermissionStatus
                                                .grantedLimited) {
                                      locationData =
                                          await location.getLocation();
                                      if (locationData.longitude != null &&
                                          locationData.latitude != null) {
                                        _lat = locationData.latitude!;
                                        _long = locationData.longitude!;
                                      }
                                    }
                                    return Future.value(value);
                                  });
                                });
                              },
                              child: const Text(
                                'enable_location_permission',
                              ).tr(),
                            ),
                            _buttonSkip()
                          ],
                        ),
                      );
                    }
                    return widget.whenDone(_lat, _long);
                  });
            },
          )
        : widget.whenDone(_lat, _long);
  }

  Widget _buttonSkip() {
    return !widget.required
        ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                setState(() {
                  _skip = true;
                });
              },
              child: Text(
                'skip'.tr(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          )
        : const SizedBox();
  }
}
