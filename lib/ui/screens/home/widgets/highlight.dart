import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'banner_card.dart';

class Hightlight extends StatefulWidget {
  const Hightlight({
    required this.baseUrl,
    super.key,
  });

  final String baseUrl;

  @override
  State<Hightlight> createState() => _HightlightState();
}

class _HightlightState extends State<Hightlight> {
  final Map<String, dynamic> _data = {
    'links': [
      {
        'text': "New Features!",
        'url': "home",
        'content': "",
      }
    ],
    'images': [
      {'type': "image", 'url': "assets/img/photos/new.jpg"}
    ]
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {}

  @override
  Widget build(BuildContext context) {
    if ((_data['links'] as List<dynamic>).isNotEmpty) {
      return LayoutBuilder(
        builder: ((context, constraints) => BannerCard(
              title: _data['links'][0]['text'],
              image: _data['images'][0]['url'],
              backgroundColor: Theme.of(context).colorScheme.surface,
              showBadge: true,
              fit: BoxFit.cover,
              minHeight: 300,
              icon: Icon(
                Symbols.grade_sharp,
                weight: 650,
                size: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onTap: _data['links'][0]['url'] != null ? () => Beamer.of(context).beamToNamed("/${_data['links'][0]['url']}") : null,
              child: _data['links'][0]['content'] != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var text in _data['links'][0]['content'].toString().split('\n'))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 18,
                                color: _data['images'][0]['url'] != null ? Colors.white : null,
                              ),
                            ),
                          ),
                      ],
                    )
                  : null,
            )),
      );
    }
    return const SizedBox.shrink();
  }
}
