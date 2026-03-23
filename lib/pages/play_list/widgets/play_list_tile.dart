import 'package:flutter/material.dart';
import 'package:flutter_home_work/data/paly_list/dto/dto.dart';
import 'package:flutter_home_work/generated/l10n.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              item.title ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _ActionButton(isPlay: isPlay),
              const SizedBox(height: 4),
              Text(
                item.modified ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPlay ? Icons.play_arrow : Icons.download_sharp,
            size: 16,
            color: Colors.black87,
          ),
          const SizedBox(width: 4),
          Text(
            isPlay ? S.of(context).play : S.of(context).download,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
