import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({super.key});

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {

  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return QuillToolbar.simple(

            configurations: QuillSimpleToolbarConfigurations(
              multiRowsDisplay: false,
              
              controller: _controller,
              showDirection: false,
              showRedo: false,
              showUndo: false,
              showSubscript: false,
              showClipboardCut: false,
              showClipboardCopy: false,
              showClearFormat: false,
              showClipboardPaste: false,
              showHeaderStyle: false,
              showInlineCode: false,
              showSuperscript: false,
              showSearchButton: false,
              showCodeBlock: true,
              showJustifyAlignment: false,
              showFontFamily: false,
              showFontSize: false,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('en'),
              ),
            ),
          );
  }
}