import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListPage extends StatefulWidget {
  static final route =
      GetPage(name: '/chat/', page: () => const ChatListPage());

  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(green),
            shape:
                MaterialStateProperty.all<StadiumBorder>(const StadiumBorder()),
          ),
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.27,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add, color: Colors.white),
                Text(
                  'New Chat',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
      body: const _BodyChatListPage(),
    );
  }
}

class _BodyChatListPage extends StatefulWidget {
  const _BodyChatListPage({Key? key}) : super(key: key);

  @override
  _BodyChatListPageState createState() => _BodyChatListPageState();
}

class _BodyChatListPageState extends State<_BodyChatListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _ChatCard(
            photoUrl: 'assets/images/head.png',
            name: 'Kate Corwin',
            lastChat: 'lorem ipsum dolor sit amet',
            time: '12:34 pm',
            unreadChat: 3,
            onTap: () {
              Get.toNamed('/chat/kate-corwin');
            },
          ),
          _ChatCard(
            photoUrl: 'assets/images/sample_card.png',
            name: 'Rodney Gutmann',
            lastChat: 'lorem ipsum dolor sit amet',
            time: '10:12 am',
            unreadChat: 24,
            onTap: () {
              Get.toNamed('/chat/rodney-gutmann');
            },
          ),
        ],
      ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final String photoUrl;
  final String name;
  final String lastChat;
  final String time;
  final int unreadChat;
  final void Function() onTap;

  const _ChatCard({
    Key? key,
    required this.photoUrl,
    required this.name,
    required this.lastChat,
    required this.time,
    required this.unreadChat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 16,
                top: 14,
                bottom: 14,
              ),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(photoUrl), fit: BoxFit.cover)),
            ),
            Expanded(
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: t60, width: 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            lastChat,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: t70, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(time,
                              style: const TextStyle(color: t70, fontSize: 12)),
                          SizedBox(height: h(10)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: green),
                            child: Text(
                              unreadChat.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
