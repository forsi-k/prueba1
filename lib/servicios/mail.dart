import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


Future<void> enviar() async{

  String username = 'avisostte@gmail.com';
  String password = 'emsy ynby wqbz adjp';

  final SmtpServer = gmail(username, password);

  final message = Message()
  ..from = Address(username, 'AVISO')
  ..recipients.add('alejomaciel97@gmail.com')
  ..subject = 'Bobina '
  ..text = 'hola hola';

  try {
    final SendReport = await send(message, SmtpServer);
    print('mensaje enviado: '+ SendReport.toString());
  } on MailerException catch (e) {
    print('mensaje no enviado');
    for (var p in e.problems) {
      print('problem: ${p.code}: ${p.msg}');
    }
  }
}
