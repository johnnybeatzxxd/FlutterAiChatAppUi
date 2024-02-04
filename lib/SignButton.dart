
import "package:flutter/material.dart";
import "index.dart";
class SignButton extends StatelessWidget {
  final text;
  final void Function()? on_tap;

  const SignButton({super.key, required this.text, required this.on_tap});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: Provider.of<ChatProvider>(context, listen: true).loading,
      child: ElevatedButton(onPressed: on_tap,
      onHover: (isHovering) => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isHovering ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 148, 72, 72)),
      ),
      style:ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
        
      
      
        
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8), child: Provider.of<ChatProvider>(context, listen: true).loading == true ? CircularProgressIndicator(backgroundColor: Colors.grey,color:Colors.black,) : Text(text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      )),
    );
  }
}
