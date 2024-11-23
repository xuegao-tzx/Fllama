import 'package:fcllama_example/view/module/DownloadButton.dart';
import 'package:isar/isar.dart';

part "models.g.dart";

@collection
class ModelData {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String mName = ""; //模型名称
  String sUrl = ""; //模型下载Host
  String policy = ""; //模型用户协议
  String ext = "."; //模型下载地址链接符
  List<ModelInfo>? info; //模型详情
}

@embedded
class ModelInfo {
  String? size;
  String? hash;
  String? quantMethod;
  bool? hasDownloaded;
  @ignore
  DownloadController? dController;
}

@collection
class LocalModelData {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String fName = ""; //模型文件名称
  LocalModelInfo? lmInfo; //模型详情
  bool isSelect = false; //是否已经选中
}

@embedded
class LocalModelInfo {
  String mName = ""; //模型名称
  String mPath = ""; //模型本地路径
  String policy = ""; //模型用户协议
  String quantMethod = ""; //模型精度
}

@collection
class ChatData {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String cId = ""; //聊天id
  LocalModelInfo? lmInfo; //模型详情
  List<ChatInfo>? cInfo; //聊天详情
}

@embedded
class ChatInfo {
  String? uName; //my\bot
  int? time; //时间戳
  String? content; //内容
}
