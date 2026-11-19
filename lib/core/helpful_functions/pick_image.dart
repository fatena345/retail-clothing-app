import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage({
  required ImageSource source,
}) async {
  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickImage(
    source: source,
  );

  return image;
}