import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hudur/Components/models.dart';
import 'package:hudur/Components/api.dart';
import 'package:flutter/material.dart';

class TextFieldModel extends StatelessWidget {
  final TextEditingController controller; 
  final String name;
  final int maxLines;
  final TextInputType type;

  const TextFieldModel({Key key, this.controller, this.name,  this.maxLines, this.type}) : super(key: key);

  

    @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: BorderSide.none);
    return  Padding(
        padding: EdgeInsets.all(20.0),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
           keyboardType: type,
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.grey[300],
            filled: true,
            labelText: name,
            focusedErrorBorder: border,
            focusedBorder: border,
            enabledBorder: border,
            errorBorder: border,
          ),
          // The validator receives the text that the user has entered.
          
        ),
    );
  }
}


class Enquiry extends StatefulWidget {
  const Enquiry({ Key key, this.title }) : super(key: key);

  final String title;

  @override
  _EnquiryState createState() => _EnquiryState();
}

  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();


class _EnquiryState extends State<Enquiry> {


 @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: _formKey,
        onChanged: (() {
          setState(() {
            _enableBtn = _formKey.currentState.validate();
          });
        }),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFieldModel(
                  controller: subjectController,
                  name: "Subject",
              ),
              TextFieldModel(
                  controller: emailController,
                  name: "Email",
              ),  
              TextFieldModel(
                  controller: messageController,
                  name: "Message",
                  maxLines: null,
                  type: TextInputType.multiline),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5);
                            }
                            else if (states.contains(MaterialState.disabled)){
                              return Colors.grey;
                            }
                            return Colors.blue; // Use the component's default.

                            
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ))),
                        onPressed:(null),
                    
                    child: Text('Submit'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}