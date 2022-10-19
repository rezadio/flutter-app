import 'package:eidupay/controller/chat/chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:lottie/lottie.dart';

class ChatScreenPage extends StatefulWidget {
  static final route =
      GetPage(name: '/chat/:name', page: () => const ChatScreenPage());
  const ChatScreenPage({Key? key}) : super(key: key);

  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  @override
  Widget build(BuildContext context) {
    final _name = Get.parameters['name']
        ?.split('-')
        .map((element) => element.capitalizeFirst)
        .join(' ');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/sample_card.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _name ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '0822 1234 5678',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: t70),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _BodyChatScreenPage(
        name: Get.parameters['name'] ?? '',
      ),
    );
  }
}

class _BodyChatScreenPage extends StatefulWidget {
  final String name;
  const _BodyChatScreenPage({Key? key, required this.name}) : super(key: key);

  @override
  _BodyChatScreenPageState createState() => _BodyChatScreenPageState();
}

class _BodyChatScreenPageState extends State<_BodyChatScreenPage> {
  final _getController = Get.put(ChatScreenController());
  @override
  Widget build(BuildContext context) {
    final _dummyChat = <Widget>[
      Obx(
        () => _getController.isRequested.value
            ? _RequestDoneCard()
            : _getController.isDeclined.value
                ? _RequestDeclinedCard()
                : _RequestCard(
                    onCancelPressed: () {
                      _getController.isDeclined.value = true;
                    },
                  ),
      ),
      SizedBox(height: h(20)),
      Obx(
        () => _getController.isPaid.value
            ? _PayDoneCard()
            : _getController.isDeclined.value
                ? _PayDeclinedCard()
                : _PayCard(
                    onPayPressed: () {
                      Get.toNamed('/chat/${widget.name}/pay');
                      //TODO: implement boolean when payment success
                      // _getController.isPaid.value = true;
                      // _getController.isRequested.value = true;
                    },
                    onDeclinePressed: () {
                      _getController.isDeclined.value = true;
                    },
                  ),
      ),
      SizedBox(height: h(20)),
      _ChatCard(isMe: false),
      SizedBox(height: h(20)),
      _ChatCard(isMe: true),
    ];

    return Column(
      children: [
        Expanded(
          child: _dummyChat.isEmpty
              ? Center(child: _HelloContainer())
              : ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  reverse: true,
                  children: _dummyChat,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    color: t30,
                    borderRadius: BorderRadius.all(Radius.circular(60))),
                child: Center(
                    child: Text(
                  'Thanks!',
                  style: TextStyle(fontSize: 12, color: t70),
                )),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: t30,
                    borderRadius: BorderRadius.all(Radius.circular(60))),
                child: Center(
                    child: Text(
                  'If you receive it, answer me!',
                  style: TextStyle(fontSize: 12, color: t70),
                )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed('/chat/${widget.name}/pay');
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: Center(
                      child: Text(
                    'Pay',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/chat/${widget.name}/request');
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: Center(
                      child: Text(
                    'Request',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(width: 8),
              Form(
                key: _getController.formKey,
                child: Expanded(
                  child: TextFormField(
                    controller: _getController.chatController,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      hintText: 'Send Message..',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        borderSide: BorderSide(color: t70, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        borderSide: BorderSide(color: t70, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        borderSide: BorderSide(color: blue, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.add),
                ),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ChatCard extends StatelessWidget {
  final bool isMe;

  _ChatCard({
    Key? key,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isMe == false)
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sample_card.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        SizedBox(width: 8),
        Container(
            height: 45,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: isMe ? green.withOpacity(0.1) : t30,
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))
                    : BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
            child: Text(
              'Hello!',
              style:
                  TextStyle(fontSize: 14, color: isMe ? green : Colors.black),
            )),
      ],
    );
  }
}

class _RequestCard extends StatelessWidget {
  final void Function()? onCancelPressed;
  const _RequestCard({
    Key? key,
    this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: blue, borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Text(
                  'Rp 250,000',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              Text(
                'Request sent 12:41 PM',
                style: TextStyle(color: t70, fontSize: 10),
              ),
              SizedBox(height: h(17)),
              MaterialButton(
                color: Colors.white,
                onPressed: onCancelPressed,
                shape: StadiumBorder(),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 12, color: blue),
                ),
              )
            ],
          )),
    );
  }
}

class _RequestDoneCard extends StatelessWidget {
  const _RequestDoneCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          height: 70,
          width: 200,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(color: blue),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rp 250,000',
                style: TextStyle(fontSize: 18, color: blue),
              ),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration:
                        BoxDecoration(color: green, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        size: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'You were paid 12:55 PM',
                    style: TextStyle(fontSize: 10, color: t70),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class _RequestDeclinedCard extends StatelessWidget {
  const _RequestDeclinedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          height: 70,
          width: 200,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(color: blue),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rp 250,000',
                style: TextStyle(fontSize: 18, color: blue),
              ),
              Row(
                children: [
                  Icon(
                    Icons.not_interested,
                    size: 10,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Requested Declined',
                    style: TextStyle(fontSize: 10, color: t70),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class _PayCard extends StatelessWidget {
  final void Function()? onPayPressed;
  final void Function()? onDeclinePressed;

  const _PayCard({
    Key? key,
    this.onPayPressed,
    this.onDeclinePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/sample_card.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        SizedBox(width: 8),
        Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    'Rp 250,000',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Text(
                  'Request received 12:41 PM',
                  style: TextStyle(color: t70, fontSize: 10),
                ),
                SizedBox(height: h(17)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        color: green,
                        onPressed: onPayPressed,
                        shape: StadiumBorder(),
                        child: Text(
                          'Pay',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.white,
                        onPressed: onDeclinePressed,
                        shape: StadiumBorder(),
                        child: Text(
                          'Decline',
                          style: TextStyle(fontSize: 12, color: blue),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }
}

class _PayDoneCard extends StatelessWidget {
  const _PayDoneCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/sample_card.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        SizedBox(width: 8),
        Container(
            height: 70,
            width: 200,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: blue),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp 250,000',
                  style: TextStyle(fontSize: 18, color: blue),
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration:
                          BoxDecoration(color: green, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.done,
                          size: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'You paid 12:55 PM',
                      style: TextStyle(fontSize: 10, color: t70),
                    )
                  ],
                )
              ],
            )),
      ],
    );
  }
}

class _PayDeclinedCard extends StatelessWidget {
  const _PayDeclinedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/sample_card.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        SizedBox(width: 8),
        Container(
            height: 70,
            width: 200,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: blue),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp 250,000',
                  style: TextStyle(fontSize: 18, color: blue),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.not_interested,
                      size: 10,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Request Declined',
                      style: TextStyle(fontSize: 10, color: t70),
                    )
                  ],
                )
              ],
            )),
      ],
    );
  }
}

class _HelloContainer extends StatelessWidget {
  const _HelloContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 170, child: Lottie.asset('assets/lottie/hello.json')),
        SizedBox(height: h(16)),
        Container(
          height: 45,
          width: 145,
          decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: Center(
            child: Text(
              'Say "Hello"',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
