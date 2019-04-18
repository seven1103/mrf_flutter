import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// 查看大图
class PhotoView extends StatefulWidget {
  PhotoView({Key key, @required this.index});
  final int index;
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  //  页面控制器
  PageController _pageController;
  //  页面索引
  int _pageindex;
  @override
  void initState() {
    super.initState();
    _pageindex = widget.index;
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
          child: PhotoViewGallery(
        pageController: _pageController,
        pageOptions: <PhotoViewGalleryPageOptions>[
          PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
                "https://b-ssl.duitang.com/uploads/item/201408/18/20140818100117_B55Fc.thumb.700_0.jpeg"),
            heroTag: "图片1",
          ),
          PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
                "https://b-ssl.duitang.com/uploads/item/201408/21/20140821094131_nH5Zm.thumb.700_0.png"),
            heroTag: "图片2",
          ),
          PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
                "https://b-ssl.duitang.com/uploads/item/201410/22/20141022104318_UHivu.thumb.700_0.jpeg"),
            heroTag: "图片3",
          ),
        ],
        onPageChanged: (index) {
          setState(() {
            _pageindex = index;
          });
        },
        backgroundDecoration: BoxDecoration(color: Colors.black87),
      )),
      onWillPop: () {
        Navigator.pop(context, _pageindex);
      },
    );
  }
}
