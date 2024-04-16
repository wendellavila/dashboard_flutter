import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    this.photos = const [],
    this.startIndex = 0,
    super.key,
  });
  final int startIndex;
  final List<String> photos;

  @override
  State<GalleryScreen> createState() => _GalleryScreen();
}

class _GalleryScreen extends State<GalleryScreen> {
  late int _currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.startIndex);
    _currentIndex = widget.startIndex;
  }

  void _downloadImage(String url) {
    String filename = url.substring(url.lastIndexOf('/') + 1).replaceAll("%20", "_");
    WebImageDownloader.downloadImageFromWeb(url, name: filename);
  }

  void _previousImage() {
    if (_currentIndex - 1 >= 0) {
      pageController
          .animateToPage(_currentIndex - 1, duration: const Duration(milliseconds: 200), curve: Curves.linear)
          .whenComplete(() => setState(() => _currentIndex -= 1));
    }
  }

  Widget _leftArrow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 40,
          onPressed: _currentIndex - 1 >= 0 ? () => _previousImage() : null,
          icon: Icon(
            Icons.chevron_left,
            size: 40,
            color: _currentIndex - 1 >= 0 ? Colors.white : null,
          ),
          disabledColor: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  void _nextImage() {
    if (_currentIndex + 1 < widget.photos.length) {
      pageController
          .animateToPage(_currentIndex + 1, duration: const Duration(milliseconds: 200), curve: Curves.linear)
          .whenComplete(() => setState(() => _currentIndex += 1));
    }
  }

  Widget _rightArrow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 40,
          onPressed: _currentIndex + 1 < widget.photos.length ? () => _nextImage() : null,
          icon: Icon(
            Icons.chevron_right,
            size: 40,
            color: _currentIndex + 1 < widget.photos.length ? Colors.white : null,
          ),
          disabledColor: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  Widget _closeButton() {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.of(context).maybePop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageViewer() {
    return Column(
      children: [
        Row(
          children: [
            _leftArrow(),
            SizedBox(
              height: MediaQuery.of(context).size.height > 800 ? 600 : MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width * 0.6 : 300,
              child: PhotoViewGallery.builder(
                pageController: pageController,
                itemCount: widget.photos.length,
                backgroundDecoration: BoxDecoration(color: Colors.black.withOpacity(0.0)),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.photos[index]),
                  );
                },
              ),
            ),
            _rightArrow(),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: () {
            _downloadImage(widget.photos[_currentIndex]);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.download_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Download",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _galleryBody() {
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          return switch (event.logicalKey.keyLabel) {
            "Arrow Left" => _previousImage(),
            "Arrow Right" => _nextImage(),
            "Escape" => Navigator.of(context).maybePop(context),
            _ => () {}
          };
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _closeButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageViewer(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: _galleryBody(),
    );
  }
}
