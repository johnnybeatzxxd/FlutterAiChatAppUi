import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'index.dart';

class DialogeContent extends StatelessWidget {
  late TextEditingController textFeildController = TextEditingController();
  var instruction = Hive.box("instruction").get("instruction");
  FocusNode _focusNode = FocusNode();

  DialogeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Instruction"),
            TextField(
              maxLines: 10,
              focusNode: _focusNode,
              controller: textFeildController
                ..text = instruction == null ? "" : instruction.toString(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      borderRadius: BorderRadius.circular(30))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Hive.box("instruction")
                      .put("instruction", textFeildController.text);
                  _focusNode.unfocus();
                  Navigator.pop(context);
                  
                },
                child: Text("Save"),
                style: ButtonStyle(
                    shadowColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onBackground),
                    shape: MaterialStatePropertyAll(StadiumBorder()),
                    side: MaterialStatePropertyAll(BorderSide(
                        color: Theme.of(context).colorScheme.onBackground)),
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.background),
                    foregroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onBackground))),
            // Text("Remeber: this content is used.")
          ],
        ),
      ),
    );
  }
}
