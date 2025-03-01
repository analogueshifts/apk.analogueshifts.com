import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  final ValueChanged<String>? onChanged; // Callback for returning text

  const TextEditor({super.key, this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _formatTracker = [];
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  String _currentBlock = 'p';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onTextChanged();
      final htmlOutput = getHtml();
      if (widget.onChanged != null) {
        widget.onChanged!(htmlOutput);
      }
    });
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
        String blockType = format['block'] as String? ?? 'p';
        if (currentBlock != blockType) {
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

        // Open new inline tags as needed
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
    if (currentBlock.isNotEmpty) {
      html += '</$currentBlock>';
    }
    logger.d(html);
    return html;
  }

  bool _isFormatActive(String tag, Map<String, dynamic> format) {
    switch (tag) {
      case 'strong':
        return format['bold'] == true;
      case 'em':
        return format['italic'] == true;
      case 'u':
        return format['underline'] == true;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                IconButton(
                  icon: const Icon(Icons.format_bold),
                  onPressed: () => setState(() => _isBold = !_isBold),
                  color: _isBold ? Colors.blue : Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.format_italic),
                  onPressed: () => setState(() => _isItalic = !_isItalic),
                  color: _isItalic ? Colors.blue : Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.format_underline),
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
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter text...',
              ),
              style: TextStyle(
                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                decoration: _isUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
