import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/domain/question/entities/owner.dart';
import 'package:flutter_test_project/presentation/core/utils/generated_assets/assets.gen.dart';

class OwnerCard extends StatelessWidget {
  final Size? size;
  final Size? imageSize;
  final Owner owner;
  final double? fontSize;
  const OwnerCard({
    Key? key,
    required this.owner,
    this.imageSize,
    this.size,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size?.height ?? 125.h,
      width: size?.width ?? 100.w,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              owner.profileImage,
              width: imageSize?.width ?? 45.w,
              height: imageSize?.height ?? 45.h,
              fit: BoxFit.cover,
              errorBuilder: (ctx, e, s) {
                return Image.asset(
                  Assets.images.background.path,
                  width: imageSize?.width ?? 45.w,
                  height: imageSize?.height ?? 45.h,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            owner.displayName,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: fontSize ?? 10,
                ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
