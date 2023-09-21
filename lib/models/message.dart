import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String senderEmail;
  final String message;
  final Timestamp timeStamp;
  Message({
    required this.senderId,
    required this.recieverId,
    required this.senderEmail,
    required this.message,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "senderEmail": senderEmail,
      "message": message,
      "timeStamp": timeStamp,
    };
  }
}
