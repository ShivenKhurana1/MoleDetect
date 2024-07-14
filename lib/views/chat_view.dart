import 'package:flutter/material.dart';
import 'package:MoleDetect/components/chat_message.dart';
import 'package:MoleDetect/constants/constants.dart';
import 'package:MoleDetect/models/chat_option_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Widget> _messages = [
    ChatMessage(
        message:
            'Hello, I am your AI Dermatologist. How can I help you today? Select a suggested prompt below to begin our conversation!',
        role: Role.ai),
  ];
  List<ChatOption> _options = [
    ChatOption('What are the main signs of Melanoma?', '''
The ABCDEs of melanoma are a set of guidelines used to help identify potential signs of melanoma, a type of skin cancer. Here's what each letter stands for:

A - Asymmetry: One half of the mole or lesion does not match the other half.

B - Border irregularity: The edges of the mole are irregular, ragged, notched, or blurred.

C - Color variation: The color of the mole is not uniform. It may include different shades of brown or black, and sometimes patches of red, white, or blue.

D - Diameter: The size of the mole is larger than the size of a pencil eraser (usually greater than 6 millimeters), although melanomas can sometimes be smaller.

E - Evolving: The mole or lesion is changing in size, shape, or color over time.

 Any new symptom such as itching, bleeding, or crusting should also be considered.'''),
    ChatOption('What changes should I be monitoring for?',
        '''You should be monitoring moles for any changes in size, shape, color, or texture. Specifically, look out for asymmetry, irregular borders, variations in color, diameter larger than a pencil eraser (about 6mm), and evolving changes such as itching, bleeding, or oozing. If you notice any of these changes, it's important to consult with a healthcare professional promptly for further evaluation.'''),
    ChatOption('How frequently should I perform skin checks?',
        '''It's generally recommended to perform skin checks regularly, ideally once a month. However, if you have a history of skin cancer or other risk factors, you might need to do them more frequently. Always consult with your healthcare provider for personalized advice based on your medical history and risk factors.'''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Dermatologist',
          style: TextStyles.smallHeadline,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [..._messages, ..._displayOptions()],
        ),
      ),
    );
  }

  List<Widget> _displayOptions() {
    List<Widget> options = [];
    for (ChatOption option in _options) {
      options.add(ChatMessage(
        message: option.message,
        onTap: () => _handleOptionSelected(option),
      ));
    }
    return options;
  }

  void _handleOptionSelected(ChatOption option) {
    setState(() {
      _messages.addAll(option.toMessages());
      _options.removeWhere((element) => element.message == option.message);
    });
  }
}
