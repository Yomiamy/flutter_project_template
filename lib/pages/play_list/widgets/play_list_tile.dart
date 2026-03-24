import 'package:flutter/material.dart';
import 'package:flutter_home_work/constants/sizes.dart';
import 'package:flutter_home_work/data/paly_list/dto/dto.dart';
import 'package:flutter_home_work/generated/l10n.dart';
import 'package:flutter_home_work/gen/colors.gen.dart';

class PlayListTile extends StatelessWidget {
  final bool isPlay;
  final PlayListItem item;

  const PlayListTile({
    super.key,
    this.isPlay = false,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingL,
        vertical: Sizes.paddingM,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              item.title ?? '',
              style: const TextStyle(
                fontSize: Sizes.fontSizeM,
                fontWeight: FontWeight.bold,
                color: ColorName.color333333,
              ),
            ),
          ),
          const SizedBox(width: Sizes.paddingL),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _ActionButton(isPlay: isPlay),
              const SizedBox(height: Sizes.paddingXS),
              Text(
                item.modified ?? '',
                style: const TextStyle(
                  color: ColorName.color9e9e9e,
                  fontSize: Sizes.fontSizeS,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final bool isPlay;

  const _ActionButton({required this.isPlay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: Sizes.paddingXS,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ColorName.color4d9e9e9e),
        color: ColorName.colorFfffff,
        borderRadius: BorderRadius.circular(Sizes.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPlay ? Icons.play_arrow : Icons.download_sharp,
            size: Sizes.iconS,
            color: ColorName.colorDe00000,
          ),
          const SizedBox(width: Sizes.paddingXS),
          Text(
            isPlay ? S.of(context).play : S.of(context).download,
            style: const TextStyle(
              fontSize: Sizes.fontSizeS,
              fontWeight: FontWeight.w500,
              color: ColorName.colorDe00000,
            ),
          ),
        ],
      ),
    );
  }
}



