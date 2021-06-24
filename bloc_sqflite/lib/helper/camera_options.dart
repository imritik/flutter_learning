import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

String albumName = 'Media';
openCamera() async {
  ImagePicker().getImage(source: ImageSource.camera).then((PickedFile? image) {
    if (image != null) {
      GallerySaver.saveImage(image.path, albumName: albumName)
          .then((bool? success) {});
    }
  });
}

recordVideo() async {
  ImagePicker().getVideo(source: ImageSource.camera).then((PickedFile? video) {
    if (video != null) {
      GallerySaver.saveVideo(video.path, albumName: albumName)
          .then((bool? success) {});
    }
  });
}

openGallery() async {
  ImagePicker().getImage(source: ImageSource.gallery);
}
