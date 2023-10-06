import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final FocusNode priceFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();

  @override
  void dispose() {
    priceFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              onFieldSubmitted: (value) {
                priceFocus.requestFocus();
              },
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              focusNode: priceFocus,
              onFieldSubmitted: (value) {
                descriptionFocus.requestFocus();
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              focusNode: descriptionFocus,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ],
        )),
      ),
    );
  }
}
