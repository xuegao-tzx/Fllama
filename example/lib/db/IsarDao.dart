import 'dart:io';

import 'package:fllama_example/bean/newbean.dart';
import 'package:fllama_example/db/models.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDao {
  static Isar? _isar;
  static IsarDao? _instance;

  IsarDao._() {
    if (_isar == null) {
      _initIsarDB();
    }
  }

  get currentDatabaseVersion => (Isar.version, 0);

  static IsarDao? instance() {
    _instance ??= IsarDao._();
    return _instance;
  }

  Future<void> _initIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ModelDataSchema, LocalModelDataSchema],
      name: "ai_local_db",
      directory: dir.path,
    );
  }

  Future<void> setModelList(List<ModelInfoData> mList) async {
    final Directory libraryDirectory = Platform.isAndroid
        ? await getApplicationSupportDirectory()
        : await getLibraryDirectory();
    await _isar?.writeTxn(() async {
      final workModelsInfo = await _isar?.modelDatas.where().findAll();
      if (workModelsInfo != null) {
        Set<String> tempWMINames = workModelsInfo.map((e) => e.mName).toSet();
        for (var mInfo in mList) {
          List<ModelInfo> tmList = [];
          for (var tmInfo in mInfo.info) {
            final fileName = tmInfo.quantMethod.isEmpty
                ? mInfo.name
                : "${mInfo.name}_${tmInfo.quantMethod}";
            final filePath = "${libraryDirectory.path}/model/$fileName.gguf";
            tmList.add(ModelInfo()
              ..size = tmInfo.size
              ..hash = tmInfo.hash
              ..hasDownloaded = File(filePath).existsSync()
              ..quantMethod = tmInfo.quantMethod);
          }
          if (tempWMINames.contains(mInfo.name)) {
            ModelData tMData =
                workModelsInfo.firstWhere((e) => e.mName == mInfo.name)
                  ..mName = mInfo.name
                  ..sUrl = mInfo.sUrl
                  ..policy = mInfo.policy
                  ..ext = mInfo.ext
                  ..info = tmList;
            await _isar?.modelDatas.put(tMData);
          } else {
            ModelData tMData = ModelData()
              ..mName = mInfo.name
              ..sUrl = mInfo.sUrl
              ..policy = mInfo.policy
              ..ext = mInfo.ext
              ..info = tmList;
            await _isar?.modelDatas.put(tMData);
          }
        }
      }
    });
  }

  Future<List<ModelData>?> getModelList() async {
    return await _isar?.modelDatas.where().findAll();
  }

  Future<void> addOneModel(
      {required String mName,
      required String mPath,
      required String mSize,
      String quantMethod = "",
      String policy = ""}) async {
    await _isar?.writeTxn(() async {
      ModelData tMData = ModelData()
        ..mName = mName
        ..sUrl = mPath
        ..policy = policy
        ..info = [
          ModelInfo()
            ..size = mSize
            ..hasDownloaded = true
            ..quantMethod = quantMethod
        ];
      await _isar?.modelDatas.put(tMData);
      LocalModelInfo tLMInfo = LocalModelInfo()
        ..mName = mName
        ..quantMethod = quantMethod
        ..mPath = mPath
        ..policy = policy;
      LocalModelData tLMData = LocalModelData()
        ..fName = quantMethod.isEmpty ? mName : "${mName}_$quantMethod"
        ..lmInfo = tLMInfo;
      await _isar?.localModelDatas.put(tLMData);
    });
  }

  Future<void> addOneDownloadModel(
      {required String mName,
      required String mPath,
      required String mSize,
      required String quantMethod,
      required String policy}) async {
    await _isar?.writeTxn(() async {
      final workModelInfo =
          await _isar?.modelDatas.where().mNameEqualTo(mName).findFirst();
      if (workModelInfo != null) {
        List<ModelInfo>? tmList = workModelInfo.info;
        tmList
            ?.firstWhere((ele) => ele.quantMethod == quantMethod)
            .hasDownloaded = true;
        workModelInfo.info = tmList;
        await _isar?.modelDatas.put(workModelInfo);
      }
      LocalModelInfo tLMInfo = LocalModelInfo()
        ..mName = mName
        ..quantMethod = quantMethod
        ..mPath = mPath
        ..policy = policy;
      LocalModelData tLMData = LocalModelData()
        ..fName = quantMethod.isEmpty ? mName : "${mName}_$quantMethod"
        ..lmInfo = tLMInfo;
      await _isar?.localModelDatas.put(tLMData);
    });
  }

  Future<void> deleteOneModel(
      {required String mName,
      required String mSize,
      required String quantMethod,
      required String policy}) async {
    final Directory libraryDirectory = Platform.isAndroid
        ? await getApplicationSupportDirectory()
        : await getLibraryDirectory();
    await _isar?.writeTxn(() async {
      final workModelInfo =
          await _isar?.modelDatas.where().mNameEqualTo(mName).findFirst();
      if (workModelInfo != null) {
        List<ModelInfo>? tmList = workModelInfo.info;
        tmList
            ?.firstWhere((ele) => ele.quantMethod == quantMethod)
            .hasDownloaded = false;
        workModelInfo.info = tmList;
        await _isar?.modelDatas.put(workModelInfo);
        final fileName = quantMethod.isEmpty ? mName : "${mName}_$quantMethod";
        final filePath = "${libraryDirectory.path}/model/$fileName.gguf";
        await _isar?.localModelDatas.deleteByFName(fileName);
        if (await File(filePath).exists()) {
          await File(filePath).delete();
        }
      }
    });
  }

  Future<List<LocalModelData>?> getLocalModels() async {
    return await _isar?.localModelDatas.where().findAll();
  }

  Future<void> selectOneLocalModel(Id? oldId, Id newId) async {
    await _isar?.writeTxn(() async {
      if (oldId != null && oldId != -1) {
        final oldModel =
            await _isar?.localModelDatas.where().idEqualTo(oldId).findFirst();
        if (oldModel != null) {
          oldModel.isSelect = false;
          await _isar?.localModelDatas.put(oldModel);
        }
      }
      final newModel =
          await _isar?.localModelDatas.where().idEqualTo(newId).findFirst();
      if (newModel != null) {
        newModel.isSelect = true;
        await _isar?.localModelDatas.put(newModel);
      }
    });
  }

  Future<LocalModelData?> getLocalModel({required String mId}) async {
    if (mId.isEmpty) {
      return null;
    }
    return await _isar?.localModelDatas
        .where()
        .idEqualTo(int.parse(mId))
        .findFirst();
  }
}
