import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//sementara di hardcode
var negara = <DropdownMenuItem<String>> [
  DropdownMenuItem(
    child: Row(
      children: [
        Container(
          width: 40,
          height: 35,
          child: Image.asset('assets/images/flag_indo.png'),
        ),
        SizedBox(width: 10,),
        VerticalDivider(
          thickness: 2,
        ),
        SizedBox(width: 10,),
        Text('Indonesia', style: GoogleFonts.rubik(
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)
        ),),
      ],
    ),
    value: 'Indonesia',
  )
];

var sumberDana = <DropdownMenuItem<String>> [
  DropdownMenuItem(
    child: 
        Text('Saldo Eidupay', style: GoogleFonts.rubik(
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)
        ),),
     
    value: 'Saldo Eidupay',
  )
];