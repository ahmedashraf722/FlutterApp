class MessageModel {
  String? senderID;
  String? receiverID;
  String? dataTime;
  String? text;
  String? messageImage;

  MessageModel({
    this.senderID,
    this.receiverID,
    this.dataTime,
    this.text,
    this.messageImage,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderID = json['senderID'];
    receiverID = json['receiverID'];
    dataTime = json['dataTime'];
    text = json['text'];
    messageImage = json['messageImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'dataTime': dataTime,
      'text': text,
      'messageImage': messageImage,
    };
  }
}
