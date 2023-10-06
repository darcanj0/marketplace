import 'dart:math';

import 'package:clothing/helpers/string_validation.dart';
import 'package:clothing/model/product.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, Object> formData = {};

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      final FormState? formState = formKey.currentState;
      if (formState!.validate()) {
        formState.save();
        final newProduct = Product(
          id: Random().nextInt(1000000).toString(),
          title: formData['title'] as String,
          description: formData['description'] as String,
          price: formData['price'] as double,
          imageUrl: formData['imageUrl'] as String,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
        actions: [
          IconButton(onPressed: submitForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  onFieldSubmitted: (value) {
                    priceFocus.requestFocus();
                  },
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => const StringValidationComposite(
                      validations: [
                        IsEmptyStringValidation(),
                        IsTooShortString(size: 3),
                        IsTooLongString(size: 50)
                      ]).validate(value),
                  onSaved: (newValue) => formData['title'] = newValue as String,
                ),
                TextFormField(
                  focusNode: priceFocus,
                  onFieldSubmitted: (value) {
                    descriptionFocus.requestFocus();
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Price'),
                  onSaved: (newValue) =>
                      formData['price'] = double.parse(newValue ?? '0'),
                  validator: (value) => StringValidationComposite(
                      validations: [IsValidPriceString()]).validate(value),
                ),
                TextFormField(
                  focusNode: descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  onFieldSubmitted: (_) {
                    imageUrlFocus.requestFocus();
                  },
                  onSaved: (newValue) =>
                      formData['description'] = newValue as String,
                  validator: (value) =>
                      const StringValidationComposite(validations: [
                    IsEmptyStringValidation(),
                    IsTooShortString(size: 10),
                    IsTooLongString(size: 100)
                  ]).validate(value),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTapOutside: (_) => loadImage(),
                        onFieldSubmitted: (_) => submitForm(),
                        onSaved: (newValue) =>
                            formData['imageUrl'] = newValue as String,
                        validator: (value) => StringValidationComposite(
                            validations: [IsImageUrlString()]).validate(value),
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
