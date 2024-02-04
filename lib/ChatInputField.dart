import "package:flutter/material.dart";

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
  
  width: 200,
  height: 30,  // Set the desired width
  child: TextField(
    
    expands: true,
    maxLines: null,
    style: TextStyle(fontSize: 15),cursorHeight: 15,
  ),
  
)
;
    
  }
}
