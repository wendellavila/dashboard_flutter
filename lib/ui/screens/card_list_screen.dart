import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({
    required this.menuData,
    required this.baseUrl,
    this.path = '',
    this.sort = 'nameAsc',
    super.key,
  });

  final String path;
  final String sort;
  final String baseUrl;
  final Map menuData;

  @override
  State<CardListScreen> createState() => _CardListScreen();
}

class _CardListScreen extends State<CardListScreen> {
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

  void _filterData(String filterString) {
    filterString = filterString.toLowerCase();
    List<Map<String, dynamic>> filteredData = [];

    if (_subdirsFull.isNotEmpty) {
      for (final folder in _subdirsFull) {
        final String title = folder['title'].toString().toLowerCase();
        final String subtitle = folder['subtitle'].toString().toLowerCase();
        final String date = folder['date'].toString().toLowerCase();
        if (title.contains(filterString) || subtitle.contains(filterString) || date.contains(filterString)) {
          filteredData.add(folder);
        }
      }
      setState(() {
        _subdirsFiltered = filteredData;
      });
    }
  }

  Card _cardItem({Widget? child}) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: child,
      ),
    );
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

  Widget _subdirCard(int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      hoverColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      onTap: () => Beamer.of(context).beamToNamed("/${widget.menuData['route']}/view?p=${_subdirsFiltered[index]['path']}&t=article&b=1&d=1"),
      child: SizedBox(
        width: 350,
        height: 380,
        child: Card(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
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
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
                      child: Text(
                        _subdirsFiltered[index]['title'] ?? '',
                        style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 0),
                      child: Text(
                        _subdirsFiltered[index]['text'] ?? '',
                        maxLines: 4,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    _subdirsFiltered[index]['subtitle'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _subdirsFiltered[index]['date'] ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterBar() {
    return _cardItem(
      child: SelectionContainer.disabled(
        child: TextField(
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            labelText: 'Filter',
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 12),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.0,
              ),
            ),
            suffixIconColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.focused) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface),
            suffixIcon: const Icon(
              Icons.search_outlined,
            ),
          ),
          onChanged: (value) {
            _filterData(value);
          },
        ),
      ),
    );
  }

  Widget _cardListBody() {
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
              height: 8,
            ),
            _filterBar(),
            const SizedBox(
              height: 20,
            ),
            if (_subdirsFiltered.isNotEmpty) ...[
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < _subdirsFiltered.length; i++) _subdirCard(i),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 2),
        child: _cardListBody(),
      ),
    );
  }
}
