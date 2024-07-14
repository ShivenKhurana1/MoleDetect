import 'package:flutter/material.dart';
import 'package:MoleDetect/constants/constants.dart';

class ChatMessage extends StatelessWidget {
  final Role? role;
  final String message;
  final void Function()? onTap;
  const ChatMessage({super.key, required this.message, this.role, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: role != null ? 20 : 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (role == Role.ai) ...[_buildAvatar(), const SizedBox(width: 10)],
          if (role == Role.human || role == null) const Spacer(),
          _buildChatMessage(context),
          if (role == Role.ai) const Spacer(),
          if (role == Role.human) ...[
            const SizedBox(width: 10),
            _buildAvatar()
          ],
        ],
      ),
    );
  }

  Widget _buildChatMessage(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: role == Role.ai ? ThemeColors.darkBackground : null,
            border: role == Role.human || role == null
                ? Border.all(color: ThemeColors.darkOutline, width: 0.5)
                : null),
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * (role == null ? 0.8 : 0.7)),
        child: Text(
          message,
          softWrap: true,
          style: TextStyles.smallBody,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 0.5, color: ThemeColors.darkOutline)),
      child: Text(
        role == Role.ai ? 'AI' : 'ME',
        style: TextStyles.smallLabel,
      ),
    );
  }
}

enum Role { ai, human }
