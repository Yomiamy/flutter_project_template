import 'package:flutter/material.dart';
import 'package:flutter_home_work/constants/constants.dart';
import 'package:flutter_home_work/data/paly_list/dto/dto.dart';
import 'package:flutter_home_work/generated/l10n.dart';
import 'package:flutter_home_work/gen/colors.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_home_work/bloc/play_list/play_list.dart';

class PlayListTile extends StatelessWidget {
  final PlayListItem item;

  const PlayListTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        final isDownloaded = state.downloadedIds.contains(item.id);
        final downloadProgress = state.progress[item.id];
        final isDownloading = downloadProgress != null;

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
                  _ActionButton(
                    isDownloaded: isDownloaded,
                    isDownloading: isDownloading,
                    progress: downloadProgress,
                    onTap: () {
                      if (isDownloaded) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(title: Text(item.title ?? '')),
                              body: const Center(child: Text('Page 2 (Player Overlay)')),
                            ),
                          ),
                        );
                      } else if (!isDownloading) {
                        context.read<DownloadBloc>().add(DownloadStart(item: item));
                      }
                    },
                  ),
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
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final bool isDownloaded;
  final bool isDownloading;
  final double? progress;
  final VoidCallback onTap;

  const _ActionButton({
    required this.isDownloaded,
    required this.isDownloading,
    required this.onTap,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            if (isDownloading)
              SizedBox(
                width: Sizes.iconS,
                height: Sizes.iconS,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  color: ColorName.colorDe00000,
                ),
              )
            else
              Icon(
                isDownloaded ? Icons.play_arrow : Icons.download_sharp,
                size: Sizes.iconS,
                color: ColorName.colorDe00000,
              ),
            const SizedBox(width: Sizes.paddingXS),
            Text(
              isDownloading
                  ? '${((progress ?? 0) * 100).toInt()}%'
                  : (isDownloaded ? S.of(context).play : S.of(context).download),
              style: const TextStyle(
                fontSize: Sizes.fontSizeS,
                fontWeight: FontWeight.w500,
                color: ColorName.colorDe00000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



