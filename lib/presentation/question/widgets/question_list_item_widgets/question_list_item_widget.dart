import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:flutter_test_project/presentation/core/routes/router.gr.dart';
import 'package:flutter_test_project/presentation/question/widgets/question_list_item_widgets/owner_card.dart';
import 'package:flutter_test_project/presentation/question/widgets/question_list_item_widgets/statistics.dart';
import 'package:flutter_test_project/presentation/question/widgets/question_list_item_widgets/tag_chips.dart';

class QuestionListItemWidget extends StatelessWidget {
  final Question info;
  const QuestionListItemWidget({Key? key, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(QuestionPageInfoRoute(question: info));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // owner
            if (info.owner != null)
              Hero(
                tag: info.owner?.accountId ?? info.questionId,
                child: OwnerCard(
                  owner: info.owner!,
                ),
              ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TagChips(
                  tags: info.tags,
                ),
                Text(
                  info.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Statistics(
                        icon: Icons.remove_red_eye_rounded,
                        numbers: info.viewCount,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Statistics(
                        icon: Icons.question_answer_rounded,
                        numbers: info.answerCount,
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('yyyy MMM dd').format(info.creationDate),
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
