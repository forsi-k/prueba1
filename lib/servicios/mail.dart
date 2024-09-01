import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> enviar(String? idbob, num progreso, num meta) async {
  String username = 'avisostte@gmail.com';
  String password = 'emsy ynby wqbz adjp';

  final hoy = DateFormat('dd-MM, H:m').format(DateTime.now());

  final porcentaje = ((progreso / meta) * 100);

  final smtpserver = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'AVISO')
    ..recipients.add('alejomaciel97@gmail.com')
    ..subject = 'La bobina $idbob esta a punto de terminar'
    ..text =
        '$hoy \n La bobina $idbob va un $porcentaje% \n va $progreso vueltas de un total de $meta vueltas';
  if (kDebugMode) {
    print("mail enviado");
  }
  try {
    final sendreport = await send(message, smtpserver);
    if (kDebugMode) {
      print('mensaje enviado: $sendreport');
    }
  } on MailerException catch (e) {
    if (kDebugMode) {
      print('mensaje no enviado');
    }
    for (var p in e.problems) {
      if (kDebugMode) {
        print('problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
