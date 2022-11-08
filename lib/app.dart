import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/presentation/core/resources/theme.dart';
import 'package:flutter_test_project/presentation/core/routes/router.gr.dart';
import 'package:month_year_picker/month_year_picker.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, w) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates
              ..add(
                MonthYearPickerLocalizations.delegate,
              ),
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            debugShowCheckedModeBanner: false,
            theme: getThemeData(context),
            builder: (context, widget) {
              return Builder(builder: (context) {
                return Builder(
                  builder: (context) {
                    if (widget == null) {
                      return Container();
                    }
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(
                          physics: const BouncingScrollPhysics(),
                        ),
                        child: SafeArea(
                          top: false,
                          left: false,
                          right: false,
                          child: widget,
                        ),
                      ),
                    );
                  },
                );
              });
            },
          );
        },
      ),
    );
  }
}
