import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class FileList extends StatelessWidget {
  const FileList({super.key, required this.context, required this.files, required this.route, this.image});

  final BuildContext context;
  final List files;
  final String route;
  final String? image;

  String _getPdfName({required String path}) {
    return path.substring(path.lastIndexOf('/') + 1, path.length - 4).replaceAll('%20', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var file in files)
          InkWell(
            borderRadius: BorderRadius.circular(6),
            hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            onTap: () => Beamer.of(context).beamToNamed("/$route/view?p=${file['url'].toString()}&t=web"),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  image != null
                      ? Container(
                          height: 120,
                          width: 700,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                image!,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: 50,
                    width: 700,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            _getPdfName(path: file['url'].toString()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
