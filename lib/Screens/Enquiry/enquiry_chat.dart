import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class EnquiryChat extends StatefulWidget {
  final UserModel userModel;
  const EnquiryChat({Key key, this.userModel}) : super(key: key);

  @override
  _EnquiryChatState createState() => _EnquiryChatState();
}

class _EnquiryChatState extends State<EnquiryChat> {
  final _allApi = AllApi();
  final _messageController = TextEditingController();

  var _message = '';

  Widget _messageBox({
    @required String text,
    @required bool isMe,
    @required String timeStamp,
  }) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: isMe ? mandysPink : summerGreen,
        shape: isMe
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              )
            : const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                timeStamp,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatWindow() {
    return Expanded(
      child: FutureBuilder<List<EnquiryModel>>(
        future: _allApi.getEnquiries(
          empEmail: widget.userModel.email,
          companyId: widget.userModel.companyId,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Image.asset('assets/Images/loading.gif'),
            );
          }
          var enquiries = snapshot.data;
          return ListView.builder(
            itemCount: enquiries.length,
            itemBuilder: (context, index) {
              return _messageBox(
                text: enquiries[index].description,
                isMe: !enquiries[index].subject.contains('Reply'),
                timeStamp: enquiries[index].timeStamp,
              );
            },
          );
        },
      ),
    );
  }

  Widget _messageBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.08,
          child: TextField(
            controller: _messageController,
            autocorrect: true,
            enableSuggestions: true,
            showCursor: true,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: null,
            expands: true,
            decoration: const InputDecoration(
              hintText: 'Type your message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _message = value;
              });
            },
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size.fromRadius(25),
              ),
              shape: MaterialStateProperty.all(
                const CircleBorder(),
              ),
            ),
            child: const Icon(
              Icons.send_rounded,
            ),
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Images/background_image.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enquiry'),
          centerTitle: true,
          backgroundColor: hippieBlue,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _chatWindow(),
            _messageBar(),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    var toEmail = '';
    final _subject = 'Enquiry email by ${widget.userModel.name}';
    FocusScope.of(context).unfocus();
    var users = await _allApi.getAllUsers(
      companyId: widget.userModel.companyId,
    );
    for (int i = 0; i < users.length; i++) {
      if (users[i].empId == widget.userModel.hrId) {
        toEmail = users[i].email;
      }
    }
    await _allApi.postEnquiry(
      empName: widget.userModel.name,
      subject: _subject,
      description: _message,
      refId: widget.userModel.refId,
      companyId: widget.userModel.companyId,
      empEmail: widget.userModel.email,
      hrId: widget.userModel.hrId,
      hrName: widget.userModel.hrName,
    );
    await _allApi.sendEmail(
      subject: _subject,
      content: _message,
      toEmail: toEmail,
    );
    _messageController.clear();
    setState(() {
      _message = '';
    });
  }
}
