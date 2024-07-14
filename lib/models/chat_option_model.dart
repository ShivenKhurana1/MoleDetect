import 'package:flutter/material.dart';
import 'package:MoleDetect/components/chat_message.dart';

class ChatOption {
  String message;
  String response;

  ChatOption(this.message, this.response);

  Widget toAIMessage() => ChatMessage(message: response, role: Role.ai);
  Widget toHumanMessage() => ChatMessage(message: message, role: Role.human);
  Widget toOption(void Function() onTap) =>
      ChatMessage(message: message, onTap: onTap);

  List<Widget> toMessages() => [toHumanMessage(), toAIMessage()];
}
