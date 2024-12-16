import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
   String? html;
  TextEditor({this.html});
  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _formatTracker = [];
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  String _currentBlock = 'p';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    int cursorPosition = _controller.selection.baseOffset;
    if (cursorPosition > _formatTracker.length) {
      _formatTracker.add({
        'bold': _isBold,
        'italic': _isItalic,
        'underline': _isUnderline,
        'block': _currentBlock,
      });
    }
  }

  String getHtml() {
    String html = '';
    String currentText = _controller.text;
    List<String> openTags = [];
    String currentBlock = '';

    for (int i = 0; i < currentText.length; i++) {
      if (i < _formatTracker.length) {
        var format = _formatTracker[i];

        // Handle block-level elements
        String blockType = format['block'] as String? ?? 'p';  // Default to 'p' if null
        if (currentBlock != blockType) {
          logger.w(blockType);
          if (currentBlock.isNotEmpty) {
            html += '</$currentBlock>';
          }
          currentBlock = blockType;
          html += '<$currentBlock>';
        }

        // Close inline tags if format changes
        while (openTags.isNotEmpty && !_isFormatActive(openTags.last, format)) {
          html += '</${openTags.removeLast()}>';
        }

        // Open new inline tags
        if (format['bold'] == true && !openTags.contains('strong')) {
          html += '<strong>';
          openTags.add('strong');
        }
        if (format['italic'] == true && !openTags.contains('em')) {
          html += '<em>';
          openTags.add('em');
        }
        if (format['underline'] == true && !openTags.contains('u')) {
          html += '<u>';
          openTags.add('u');
        }
      }

      html += currentText[i];

    }

    // Close any remaining inline tags
    while (openTags.isNotEmpty) {
      html += '</${openTags.removeLast()}>';
    }

    // Close the final block tag
    if (currentBlock.isNotEmpty) {
      html += '</$currentBlock>';
    }

    logger.d(html);
    // widget.textController.text = html;
    return html;
  }

  bool _isFormatActive(String tag, Map<String, dynamic> format) {
    switch (tag) {
      case 'strong':
        return format['bold'];
      case 'em':
        return format['italic'];
      case 'u':
        return format['underline'];
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff000000).withOpacity(0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      // margin: EdgeInsets.all(8),
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
                DropdownButton<String>(
                  value: _currentBlock,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _currentBlock = newValue;
                      });
                    }
                  },
                  items: <String>['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                final html = getHtml();
                logger.d(html);
                widget.html = html;
                setState(() {
                  widget.html = html;

                });

              },
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
      ),
    );
  }
}