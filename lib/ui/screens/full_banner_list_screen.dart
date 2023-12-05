import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class FullBannerListScreen extends StatefulWidget {
  const FullBannerListScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.sort = '',
    super.key,
  });

  final String path;
  final String sort;
  final String baseUrl;
  final Map menuData;

  @override
  State<FullBannerListScreen> createState() => _FullBannerListScreen();
}

class _FullBannerListScreen extends State<FullBannerListScreen> {
  final Map<String, dynamic> _data = {
    'path': "",
    'photos': [
      "assets/placeholder/placeholder.png",
    ],
    'files': [],
    'links': [],
    'subdirs': [
      {
        'path': "",
        'title': "Subdir 1",
        'subtitle': "Placeholder Subdirectory",
        'date': "01/01/2023",
        'text':
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce mattis dapibus luctus.Pellentesque aliquam sapien id lorem varius, nec tempor leo vestibulum. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
        'photos': ["assets/placeholder/placeholder.png"],
      },
      {
        'path': "",
        'title': "Subdir 2",
        'subtitle': "Placeholder Subdirectory 2",
        'date': "02/02/2022",
        'text':
            "Lorem ipsum dolor sit amet, sed dictum nisi laoreet porta. Cras molestie diam est, ac viverra purus scelerisque eget. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
        'photos': ["assets/placeholder/placeholder.png"],
      }
    ],
  };

  List<Map<String, dynamic>> _subdirsFull = [];
  List<Map<String, dynamic>> _subdirsFiltered = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _subdirsFull = (_data['subdirs'] as List).map((item) => item as Map<String, dynamic>).toList();
    setState(() {
      _subdirsFiltered = _subdirsFull;
    });
  }

  String _getPdfName({required String path}) {
    return path.substring(path.lastIndexOf('/') + 1, path.length - 4).replaceAll('%20', ' ');
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Text(
            _data['title'] ?? '',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _subdirCard({required int index}) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      onTap: () => Beamer.of(context).beamToNamed("/${widget.menuData['route']}/view?p=${_subdirsFiltered[index]['path']}&t=dir&d=1&b=1&s=nameAsc"),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 700,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (_subdirsFiltered[index]['photos'] as List).isEmpty
                      ? const AssetImage("assets/img/placeholder/placeholder.jpg") as ImageProvider
                      : NetworkImage(
                          _subdirsFiltered[index]['photos'][0],
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      _subdirsFiltered[index]['title'] ?? '',
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
    );
  }

  Widget _fileList() {
    return Wrap(
      children: [
        for (int i = 0; i < (_data['files'] as List).length; i++)
          InkWell(
            borderRadius: BorderRadius.circular(6),
            hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            onTap: () => Beamer.of(context).beamToNamed("/${widget.menuData['route']}/view?p=${_data['files'][i].toString()}&t=web"),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  (_data['photos'] as List).isNotEmpty
                      ? Container(
                          height: 120,
                          width: 700,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                _data['photos'][0],
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
                            _getPdfName(path: _data['files'][i].toString()),
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

  Widget _fullBannerListBody() {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          primary: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            _header(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: _fileList(),
            ),
            if (_subdirsFiltered.isNotEmpty) ...[
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < _subdirsFiltered.length; i++) _subdirCard(index: i),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _fullBannerListBody(),
    );
  }
}
