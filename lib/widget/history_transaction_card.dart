import 'package:eidupay/model/mutasi.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';
import 'package:intl/intl.dart';

class HistoryTransactionCard extends StatelessWidget {
  final Mutasi lastTransaction;
  final void Function()? onTap;

  const HistoryTransactionCard({
    Key? key,
    required this.lastTransaction,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _toPersonName = lastTransaction.namePenerima ??
        lastTransaction.noHpPenerima ??
        lastTransaction.idIdentitasPenerima ??
        lastTransaction.namaPenerima;
    final _fromPersonName = lastTransaction.namePengirim;

    return InkWell(
      splashColor: Colors.black12,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(.05),
                  blurRadius: 1,
                  offset: const Offset(0.0, 2))
            ],
            border: Border(
              left: BorderSide(
                color: statusColor(),
                width: 3.0,
              ),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: Row(children: [
                  //     if (lastTransaction.statusTrx == 'SUCCESS' ||
                  //         lastTransaction.statusTrx == 'SUKSES')
                  //       const Icon(
                  //         IconData(0xe156, fontFamily: 'MaterialIcons'),
                  //         color: green,
                  //       )
                  //     else if (lastTransaction.statusTrx == 'PENDING')
                  //       const Icon(IconData(0xf112, fontFamily: 'MaterialIcons'),
                  //           color: orange2)
                  //   ]),
                  // ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                lastTransaction.tipeTransaksi.contains('Refund')
                                    ? 'Refund ${lastTransaction.namaTipeTransaksi} '
                                    : '${lastTransaction.namaTipeTransaksi} ',
                                style: TextStyle(
                                    fontSize: w(12),
                                    fontWeight: FontWeight.w800,
                                    color: t70)),
                            // if (_toPersonName != null)
                            //   Text(
                            //     (lastTransaction.typeTrx == 'DEPOSIT')
                            //         ? 'dari '
                            //         : 'ke ',
                            //     overflow: TextOverflow.ellipsis,
                            //     style: TextStyle(
                            //         color: const Color(0xFF82808F),
                            //         fontSize: w(14)),
                            //   ),
                            // if (_toPersonName != null)
                            //   Flexible(
                            //     child: Text(
                            //       (lastTransaction.typeTrx == 'DEPOSIT')
                            //           ? _fromPersonName
                            //           : _toPersonName,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           color: const Color(0xFF82808F),
                            //           fontSize: w(14)),
                            //     ),
                            //   ),
                          ],
                        ),
                        Text(
                          DateFormat.yMMMMd('en_US')
                              .format(lastTransaction.timeStamp),
                          style: TextStyle(
                              color: const Color(0xFF000119).withAlpha(50),
                              fontSize: w(12),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: ((lastTransaction.typeTrx == 'WITHDRAW')
                                ? Colors.red
                                : Colors.green)
                            .withAlpha(10),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Text(
                            ((lastTransaction.typeTrx == 'WITHDRAW')
                                    ? '-'
                                    : '+') +
                                ' Rp ' +
                                lastTransaction.total,
                            style: TextStyle(
                                color: (lastTransaction.typeTrx == 'WITHDRAW')
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: w(12),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            // const Divider()
          ],
        ),
      ),
    );
  }

  Color statusColor() {
    if (lastTransaction.statusTrx == 'SUCCESS' ||
        lastTransaction.statusTrx == 'SUKSES') {
      return green;
    } else if (lastTransaction.statusTrx == 'PENDING')
      return orange2;
    else if (lastTransaction.statusTrx == 'GAGAL') {
      if (lastTransaction.tipeTransaksi.contains('Refund')) {
        return orange1;
      }
      return red;
    }
    ;
    return Colors.white;
  }
}
