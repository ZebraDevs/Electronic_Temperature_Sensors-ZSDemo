import 'dart:typed_data';

import 'package:either_option/either_option.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:zsdemo_app/models/models.dart';

Future<Either<GenericException, DirectoryLocation?>> pickFileDirectory() async {
  if (!await FlutterFileDialog.isPickDirectorySupported()) {
    return Left(NotSupportedError(500, error: "Pick directory is not supported"));
  }

  return Right(await FlutterFileDialog.pickDirectory());
}

Future<Either<GenericException, String?>> saveFileToDirectory({
  required String mimeType,
  required Uint8List data,
  required DirectoryLocation directory,
  required String fileName,
}) async {
  try {
    return Right(await FlutterFileDialog.saveFileToDirectory(
      directory: directory,
      data: data,
      mimeType: mimeType,
      fileName: fileName,
      replace: false,
    ));
    
  } catch (e) {
    return Left(GenericException(500, error: e.toString()));
  }
}

Future<Either<GenericException, String?>> pickFile() async {
  try {
    const params = OpenFileDialogParams(dialogType: OpenFileDialogType.document, copyFileToCacheDir: true);
    return Right(await FlutterFileDialog.pickFile(params: params));
  } catch (e) {
    return Left(GenericException(500, error: e.toString()));
  }
}
