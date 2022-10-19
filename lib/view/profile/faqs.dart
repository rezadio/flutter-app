import 'package:eidupay/controller/profile/faqs_cont.dart';
import 'package:eidupay/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class Faqs extends StatelessWidget {
  const Faqs({Key? key}) : super(key: key);
  static final route = GetPage(name: '/faqs', page: () => const Faqs());

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(FaqsCont(injector.get()));
    return Scaffold(
      appBar: AppBar(title: const Text('FAQs')),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: w(41)),
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                  fontSize: w(18), fontWeight: FontWeight.w500, color: blue),
            ),
            Obx(
              () => (!_c.isLoaded.value)
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: CircularProgressIndicator(),
                    ))
                  : (_c.faqs.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text('Data Kosong',
                              style: TextStyle(
                                  fontSize: w(14),
                                  fontWeight: FontWeight.w400,
                                  color: t70)),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _c.faqs.length,
                          itemBuilder: (context, index) {
                            final faq = _c.faqs[index];
                            return Obx(
                              () => FaqCard(
                                id: faq.id,
                                pertanyaan: faq.pertanyaan,
                                jawaban: faq.jawaban,
                                isTapped: _c.idx.value == index,
                                onTap: () => _c.faqsTap(index),
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      )),
    );
  }
}

class FaqCard extends StatelessWidget {
  final VoidCallback? onTap;
  final int id;
  final String pertanyaan;
  final String jawaban;
  final bool isTapped;

  const FaqCard(
      {Key? key,
      required this.id,
      required this.pertanyaan,
      required this.jawaban,
      required this.isTapped,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          height: isTapped ? 250 : 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isTapped ? green.withOpacity(0.2) : blue.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          pertanyaan,
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w500,
                              color: blue),
                        ),
                      ),
                      isTapped
                          ? const Icon(Icons.keyboard_arrow_up, color: darkBlue)
                          : const Icon(Icons.keyboard_arrow_down_sharp,
                              color: darkBlue)
                    ],
                  ),
                  !isTapped
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30),
                          child: SizedBox(
                            height: 160,
                            child: SingleChildScrollView(
                                child: Html(
                              data: jawaban
                                  .replaceAll('\\n', '<br>')
                                  .replaceAll('\\t', '<pre>'),
                            )),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
