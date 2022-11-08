import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:flutter_test_project/presentation/question/widgets/question_list_item_widgets/owner_card.dart';
import 'package:flutter_test_project/presentation/question/widgets/question_list_item_widgets/tag_chips.dart';
import 'package:flutter_test_project/presentation/question/widgets/vertical_statistics.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionPageInfo extends StatefulWidget {
  final Question question;
  const QuestionPageInfo({Key? key, required this.question}) : super(key: key);

  @override
  State<QuestionPageInfo> createState() => _QuestionPageInfoState();
}

class _QuestionPageInfoState extends State<QuestionPageInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton.icon(
            onPressed: () async {
              await launchUrl(Uri.parse(widget.question.link));
            },
            icon: const Icon(
              Icons.launch_rounded,
              color: Colors.white,
            ),
            label: Text('open_link'.tr())),
        appBar: AppBar(
          centerTitle: true,
          title: Text('${'question'.tr()} #${widget.question.questionId}'),
        ),
        body: Column(
          children: [
            if (widget.question.owner != null)
              Hero(
                tag: widget.question.owner?.accountId ??
                    widget.question.questionId,
                child: OwnerCard(
                  fontSize: 16,
                  owner: widget.question.owner!,
                  imageSize: Size(100.w, 100.h),
                  size: Size(150.w, 200.h),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.75),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'tags'.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    // tags
                    Expanded(
                      child: TagChips(
                        wrapped: true,
                        tags: widget.question.tags,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(widget.question.title),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text(
                      DateFormat('yyyy MMM dd')
                          .addPattern('jm')
                          .format(widget.question.creationDate),
                      style: TextStyle(
                          fontSize: 12, color: Theme.of(context).disabledColor),
                    ),
                  ),
                ],
              ),
            ),
            // statistics
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerticalStatistics(
                    icon: Icons.remove_red_eye_rounded,
                    numbers: widget.question.viewCount,
                  ),
                  Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: widget.question.isAnswered
                        ? 'questionAnswered'.tr()
                        : 'questionNotAnswered'.tr(),
                    child: VerticalStatistics(
                      color: widget.question.isAnswered
                          ? Colors.green
                          : Colors.red,
                      icon: widget.question.isAnswered
                          ? Icons.check_rounded
                          : Icons.cancel,
                      numbers: 0,
                    ),
                  ),
                  VerticalStatistics(
                    icon: Icons.question_answer_rounded,
                    numbers: widget.question.answerCount,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
