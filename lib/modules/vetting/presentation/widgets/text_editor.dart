import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final TextEditingController _controller = TextEditingController();
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff000000).withOpacity(0.1)),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: [
                  IconButton(
                    icon: Icon(Icons.format_bold),
                    onPressed: () => setState(() => _isBold = !_isBold),
                    color: _isBold ? Colors.blue : Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.format_italic),
                    onPressed: () => setState(() => _isItalic = !_isItalic),
                    color: _isItalic ? Colors.blue : Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.format_underline),
                    onPressed: () => setState(() => _isUnderline = !_isUnderline),
                    color: _isUnderline ? Colors.blue : Colors.black,
                  ),
                  IconButton(icon: Icon(Icons.link), onPressed: () {}),
                  IconButton(icon: Icon(Icons.format_list_bulleted), onPressed: () {}),
                  IconButton(icon: Icon(Icons.format_list_numbered), onPressed: () {}),
                  IconButton(icon: Icon(Icons.code), onPressed: () {}),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Untitled question',
                ),
                style: TextStyle(
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration: _isUnderline ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ),
          ],
        )
    );
  }
}