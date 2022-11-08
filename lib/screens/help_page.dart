import 'package:flutter/material.dart';
import 'package:todo/componantes/button.dart';
import 'package:todo/componantes/text_form_field.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class HelpPage extends StatelessWidget {
  HelpPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    sendMail() async {

      String username = "mohamedmamdouh837@gmail.com";
      String password = 'emrxlxznczjyilll';

      final smtpServer = gmail(username, password);

      // Create our message.
      final message = Message()
        ..from = Address(emailController.text)
        ..recipients.add("mohamedmamdouh837@gmail.com")

        ..subject = ' ${subjectController.text} ${DateTime.now()}'
        ..text = 'This is the plain text.\nThis is line 2 of the text part.'
        ..html =
            "<h1>${subjectController.text}</h1>\n<p>${messageController.text}</p>\n<p>${emailController.text}</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Row(
            children: [
              Text("We will answer as soon as  possible"),
              Icon(Icons.task_alt_rounded)
            ],
          ),
          backgroundColor: Colors.green,
        ));
      } on MailerException catch (e) {
        print('Message not sent.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [

              Text("Failed to connection , Please Check your network"),
              Icon(Icons.sms_failed_outlined)
            ],
          ),
          backgroundColor: Colors.red,
        ));
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: Offset(4, 4),
                      spreadRadius: 1,
                      color: Colors.black12),
                ], shape: BoxShape.circle),
                child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('lib/asset/background.png'))),
            const Positioned(
                left: 10,
                top: 20,
                child: Text(
                  "M.M",
                  style: TextStyle(
                      fontSize: 48,
                      color: Color(0xfffbf6e0),
                      fontFamily: "YanoneKaffeesatz",
                      shadows: [
                        Shadow(
                            offset: Offset(4, 4),
                            blurRadius: 1,
                            color: Colors.black)
                      ],
                      fontWeight: FontWeight.bold),
                )),
            Positioned(
                left: 1,
                top: 65,
                child: Container(
                  width: 69,
                  height: 5,
                  color: const Color(0xff7abdbd),
                )),
            Positioned(
                left: 1,
                top: 10,
                child: Container(
                  width: 69,
                  height: 5,
                  color:const Color(0xff7abdbd),
                ))
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff7abdbd),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 8,
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "lib/asset/background.png",
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      "Send your Problem ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: "Pacifico",
                          color: Color(0xfff6edd8),
                          shadows: [
                            Shadow(
                              offset: Offset(4, 4),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    CustomField(
                        isFill: true,
                        type: TextInputType.text,
                        fillColor: Colors.white,
                        hintText: const Text("Name"),
                        prefix: Icons.text_fields_outlined,
                        controller: nameController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    CustomField(
                        isFill: true,
                        type: TextInputType.text,
                        fillColor: Colors.white,
                        hintText: const Text("Email address"),
                        prefix: Icons.email_rounded,
                        controller: emailController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    CustomField(
                        isFill: true,
                        type: TextInputType.emailAddress,
                        fillColor: Colors.white,
                        hintText: const Text("Subject"),
                        prefix: Icons.subject,
                        controller: subjectController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    CustomField(
                        minLines: 6,
                        maxLines: 20,
                        isFill: true,
                        type: TextInputType.multiline,
                        fillColor: Colors.white,
                        hintText:const  Text("Enter your message"),
                        prefix: Icons.message_rounded,
                        controller: messageController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    CustomButton(
                      buttonText: 'Send The Message',
                      action: () {
                        if (formKey.currentState!.validate()) {
                          sendMail();
                          nameController.clear();
                          emailController.clear();
                          subjectController.clear();
                          messageController.clear();
                        }
                      },
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
