import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchTextField({super.key, required this.onChanged});

  @override
  SearchTextFieldState createState() => SearchTextFieldState();
}

class SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();

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
    widget.onChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search_rounded),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              _controller.clear();
            },
          ),
          labelText: context.l10n.techniqueLibraryScreen_search_hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
