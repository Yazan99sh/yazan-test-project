import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

typedef OnButtonClick = void Function();

class CustomDialogWidget extends StatefulWidget {
  final String title;
  final String message;
  final String buttonName;
  final OnButtonClick onButtonClick;
  final bool oneAction;
  final String? closeButtonName;

  const CustomDialogWidget(
      {required this.title,
      required this.message,
      required this.buttonName,
      required this.onButtonClick,
      this.closeButtonName,
      this.oneAction = false,
      Key? key})
      : super(key: key);

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(),
      child: AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.only(left: 30, right: 30),
          contentPadding: const EdgeInsets.all(0),
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide.none),
          content: Center(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0.5),
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  const Divider(
                    height: 20.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.message,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: widget.oneAction
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: widget.oneAction == false,
                        child: Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                backgroundColor: Colors.white,
                                fixedSize: const Size.fromHeight(39),
                                padding: const EdgeInsets.all(8)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              widget.closeButtonName ?? 'close'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.oneAction == false,
                        child: const SizedBox(
                          width: 16,
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              fixedSize: const Size.fromHeight(39),
                              padding: const EdgeInsets.all(8)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onButtonClick();
                          },
                          child: Text(
                            widget.buttonName,
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
