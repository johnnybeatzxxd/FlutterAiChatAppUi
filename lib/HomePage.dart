import "dart:io";
import "package:chat_app/ChatProvider.dart";
import "package:chat_app/chatprotest.dart";
import "package:flutter/gestures.dart";
import "package:lottie/lottie.dart";
import "index.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var chatController = TextEditingController();
  late var sendController;
  var _scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    sendController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CHEATCHAT',
              style: TextStyle(fontSize: 20),
            ),
            GestureDetector(
                onTap: () {},
                child: Lottie.asset("assets/chat.json", height: 40)),
          ],
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        toolbarHeight: 50,
        bottomOpacity: 0,
        leadingWidth: 50,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              value == "Reset"
                  ? Provider.of<ChatProvider>(context, listen: false).reset()
                  : value == "Delete"
                      ? Provider.of<ChatProvider>(context, listen: false)
                          .deleteConvo(
                              Provider.of<ChatProvider>(context, listen: false)
                                  .chatId)
                      : value == "View Details"
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  // Dialog content here
                                  content: DialogeContent()),
                            )
                          : null;
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  value: "View Details",
                  child: Row(children: [
                    Icon(Icons.info_outline),
                    SizedBox(
                      width: 7,
                    ),
                    Text('View Details')
                  ])),
              PopupMenuItem(
                  value: "Reset",
                  child: Row(children: [
                    Icon(Icons.replay_outlined),
                    SizedBox(
                      width: 7,
                    ),
                    Text('Reset')
                  ])),
              PopupMenuItem(
                  value: "Delete",
                  child: Row(children: [
                    Icon(Icons.delete_outline),
                    SizedBox(
                      width: 7,
                    ),
                    Text('Delete')
                  ])),
            ],
            position: PopupMenuPosition.under,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8.0), // Adjust height as needed
          child: Divider(color: Colors.grey), // Adjust color and style
        ),
      ),
      body: Column(
        children: [
          Flexible(child: Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return CustomScrollView(
                controller: _scrollController,
                reverse: true,
                anchor: BorderSide.strokeAlignCenter,
                slivers: chatProvider.messages,
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      
                    },
                    icon: Icon(Icons.upload_file)),
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: TextField(
                      focusNode: _focusNode,
                      maxLines: 5,
                      minLines: 1,
                      controller: chatController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5)),
                    ),
                  ),
                ),
                AbsorbPointer(
                  absorbing:
                      Provider.of<ChatProvider>(context, listen: true).loading,
                  child: IconButton(
                    onPressed: () async {
                      _focusNode.unfocus();

                      var chatId =
                          Provider.of<ChatProvider>(context, listen: false)
                              .chatId;
                      chatController.text.isNotEmpty
                          ? Provider.of<ChatProvider>(context, listen: false)
                              .addMessage(chatController.text, "user", chatId)
                          : null;
                      _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeOut);
                      chatController.clear();
                    },
                    icon: Icon(Icons.send_rounded),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
