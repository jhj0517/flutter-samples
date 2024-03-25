import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:googleapis/drive/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../apis/google_api.dart';
import '../utils/text_file_manager.dart' as util;

enum GDriveStatus{
  uninitialized,
  initialized,
  isOnTask,
  failed,
  complete,
}

class GDriveProvider extends ChangeNotifier {

  static const folderName = "AIBridge";
  static const folderMime = "application/vnd.google-apps.folder";

  GDriveStatus _status = GDriveStatus.uninitialized;
  GDriveStatus get status => _status;

  String _value="";
  String get value => _value;

  DriveApi? driveApi;

  final GoogleSignIn googleSignIn;

  GDriveProvider({
    required this.googleSignIn
  });

  Future<void> _setDrive() async {
    final googleAuthData = await googleSignIn.signIn();
    if (googleAuthData == null) {
      _setStatus(GDriveStatus.failed);
      return;
    }

    final client = GoogleHttpClient(
        await googleAuthData.authHeaders
    );
    driveApi = DriveApi(client);
  }

  Future<void> upload() async {
    _setStatus(GDriveStatus.initialized);
    await _setDrive();

    await util.writeTextFile(value);
    final localFile = await util.getTextFile();

    final File gDriveFile = File();
    gDriveFile.name = basename(localFile.absolute.path);

    final existingFile = await _isFileExist(gDriveFile.name!);

    _setStatus(GDriveStatus.isOnTask);
    if (existingFile != null){
      try{
        await driveApi!.files.update(
            gDriveFile,
            existingFile.id!,
            uploadMedia: Media(localFile.openRead(), localFile.lengthSync())
        );
      } catch (err){
        _setStatus(GDriveStatus.failed);
        debugPrint('G-Drive Error : $err');
      }
      _setStatus(GDriveStatus.complete);
      return;
    }

    final folderId =  await _folderId();
    gDriveFile.parents = [folderId!];
    try{
      await driveApi!.files.create(
        gDriveFile,
        uploadMedia: Media(localFile.openRead(), localFile.lengthSync()),
      );
    } catch (err){
      _setStatus(GDriveStatus.failed);
      debugPrint('G-Drive Error : $err');
    }
    _setStatus(GDriveStatus.complete);
  }

  Future<void> download() async{
    _setStatus(GDriveStatus.initialized);
    await _setDrive();

    final localFile = await util.getTextFile();

    final File gDriveFile = File();
    gDriveFile.name = basename(localFile.absolute.path);

    final existingFile = await _isFileExist(gDriveFile.name!);

    if(existingFile ==null){
      _setStatus(GDriveStatus.failed);
      return;
    }

    _setStatus(GDriveStatus.isOnTask);
    Media? downloadedFile;
    try {
      downloadedFile = await driveApi!.files.get(
          existingFile.id!,
          downloadOptions: DownloadOptions.fullMedia
      ) as Media;
    } catch (err){
      _setStatus(GDriveStatus.failed);
      debugPrint('G-Drive Error : $err');
    }

    if(downloadedFile==null){
      _setStatus(GDriveStatus.failed);
      return;
    }

    _setStatus(GDriveStatus.complete);
  }

  Future<File?> _isFileExist(String fileName) async {
    final folderId =  await _folderId();
    if (folderId == null){
      return null;
    }

    final query = "name = '$fileName' and '$folderId' in parents and trashed = false";
    final driveFileList = await driveApi!.files.list(
      q: query,
      spaces: 'drive',
      $fields: 'files(id, name, mimeType, parents)',
    );

    if (driveFileList.files == null || driveFileList.files!.isEmpty) {
      return null;
    }

    return driveFileList.files!.first;
  }

  Future<String?> _folderId() async {
    final found = await driveApi!.files.list(
      q: "mimeType = '$folderMime' and name = '$folderName'",
      $fields: "files(id, name)",
    );
    final files = found.files;

    if (files == null) {
      return null;
    }
    if (files.isEmpty){
      final newFolder = await _createNewFolder();
      return newFolder.id;
    }

    return files.first.id;
  }

  Future<File> _createNewFolder() async{
    final File folder = File();
    folder.name = folderName;
    folder.mimeType = folderMime;
    return await driveApi!.files.create(folder);
  }


  void _setStatus(GDriveStatus status){
    _status = status;
    notifyListeners();
  }

  void setText(String value){
    _value = value;
  }

}