import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final FocusNode priceFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode imageUrlFocus = FocusNode();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    imageUrlFocus.addListener(loadImage);
    super.initState();
  }

  @override
  void dispose() {
    priceFocus.dispose();
    descriptionFocus.dispose();
    imageUrlController.removeListener(loadImage);
    imageUrlController.dispose();
    imageUrlFocus.dispose();
    super.dispose();
  }

  void loadImage() => setState(() {});

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
              onFieldSubmitted: (value) {
                imageUrlFocus.requestFocus();
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    onTapOutside: (_) => loadImage(),
                    controller: imageUrlController,
                    focusNode: imageUrlFocus,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Image URL',
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  alignment: Alignment.center,
                  child: imageUrlController.text.isEmpty
                      ? const Text('Enter Url')
                      : Image.network(imageUrlController.text),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
