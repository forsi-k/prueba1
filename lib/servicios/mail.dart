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
  print("mail enviado");
  try {
    final sendreport = await send(message, smtpserver);
    print('mensaje enviado: ' + sendreport.toString());
  } on MailerException catch (e) {
    print('mensaje no enviado');
    for (var p in e.problems) {
      print('problem: ${p.code}: ${p.msg}');
    }
  }
}
