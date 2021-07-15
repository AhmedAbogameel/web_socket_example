import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_example/views/chat/controller.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool _isConnected = false;

  TextEditingController _messageController = TextEditingController();
  ChatController _chatController = ChatController();

  List<String> messages = [];

  void joinChannel(){
    _chatController.connect().then((value) {
      setState(()=> _isConnected = true);
      _chatController.channel.stream.listen((event) => setState(()=> messages.insert(0, event)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(icon: Icon( _isConnected ? Icons.close : Icons.add_to_home_screen),onPressed: (){
            if(!_isConnected) {
              joinChannel();
              return;
            }
            _chatController.disconnect();
            setState(() => _isConnected = false);
          },),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: _isConnected ? Colors.green : Colors.red,
            alignment: Alignment.center,
            child: Text(_isConnected ? 'Connected!' : 'Disconnected!',style: TextStyle(fontSize: 12,color: Colors.white),),
            height: 20,
          ),
          Expanded(
            child: _isConnected ? ListView.separated(
              itemCount: messages.length,
              reverse: true,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) => Text(messages[index]),
              separatorBuilder: (context, index) => Divider(),
            ) : Center(child: Text('You have to connect to see this messages!'))),
          if(_isConnected)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: 'Message...'
                    ),
                  )),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){
                    if(_messageController.text.isEmpty) return;
                    _chatController.sendMessage(_messageController.text);
                    _messageController.clear();
                    setState(() {});
                  }, child: Icon(CupertinoIcons.rocket))
                ],
              ),
            ),
        ],
      ),
    );
  }
}