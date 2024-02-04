void main() {
  List<Map<String, String>> convo = [
    {"role": "user", "text": "Hello"},
    {"role": "bot", "text": "Hi"}
  ];
  convo.add({"role": "human", "text": "Hi"});
//print convo last object of role
  print(convo.elementAt(convo.length - 1)["role"] as String); // prints "bot"
}
