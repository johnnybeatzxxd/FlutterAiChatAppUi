import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import "index.dart";

class NavBar extends StatelessWidget {
  NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                  context.read<ThemeIconProvider>().toggleIcon();
                },
                icon: Icon(Provider.of<ThemeIconProvider>(context).icontype))
          ],
        ),
        UserAccountsDrawerHeader(
          accountName: Text(
              Hive.box("userInfo").get("info")["user"]["username"],
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          accountEmail: Text(Hive.box("userInfo").get("info")["user"]["email"],
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          currentAccountPicture: CircleAvatar(
            child: Icon(
              Icons.account_circle_outlined,
              color: Theme.of(context).colorScheme.background,
              size: 30,
            ),
            backgroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: BoxDecoration(),
        ),
        Column(children: [
          ExpansionTile(
            title: Text("Conversations"),
            shape: Border(),
            children: [
              for (var conversations in Hive.box("convo").keys)
                ListTile(
                    dense: false,
                    leading: SizedBox(
                      width: 230,
                      child: Text(Hive.box("convo")
                          .get(conversations.toString())[0]["parts"]
                          .toString()),
                    ),
                    trailing: PopupMenuButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onSelected: (value) {
                        value == "Delete"
                            ? Provider.of<ChatProvider>(context, listen: false)
                                .deleteConvo(conversations.toString())
                            : null;
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: Text("Delete"),
                          height: 8,
                          value: "Delete",
                        )
                      ],
                    ),
                    onTap: () {
                      print(Hive.box("convo").keys);
                      var conversationData = Hive.box("convo")
                          .get(conversations.toString()) as List?;

                      if (conversationData != null) {
                        var conversation = conversationData
                            .map((item) => item.cast<String, String>()
                                as Map<String, String>)
                            .toList();
                        // Now you can safely use the `conversation` list as a `List<Map<String, String>>`
                        print(conversation.runtimeType);

                        Provider.of<ChatProvider>(context, listen: false)
                            .setMessages(conversation, conversations.toString(),
                                animate: true);
                        Navigator.pop(context);
                      }
                    }),
            ],
          ),
        ]),
        Expanded(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                leading: Text(
                  "Logout",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
                ),
                trailing: Icon(Icons.logout),
                onTap: () {
                  Account().logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          SigninPage.routeName,
                          (Route<dynamic> route) =>
                              false); // Remove all previous routes
                },
              )
            ],
          ),
        ))
      ]),
    );
  }
}
