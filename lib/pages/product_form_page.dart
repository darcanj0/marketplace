import 'package:clothing/helpers/string_validation.dart';
import 'package:clothing/model/product.dart';
import 'package:clothing/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg != null) {
      final productToEdit = arg as Product;
      formData['id'] = productToEdit.id;
      formData['title'] = productToEdit.title;
      formData['price'] = productToEdit.price.toString();
      formData['imageUrl'] = productToEdit.imageUrl;
      formData['description'] = productToEdit.description;

      imageUrlController.text = productToEdit.imageUrl;
    }
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
  bool awaitingResponse = false;

  void submitForm() {
    final FormState? formState = formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      setState(() => awaitingResponse = true);
      context
          .read<ProductListProvider>()
          .saveProductFromData(formData)
          .then((_) {
        setState(() => awaitingResponse = true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Successfully added ${formData['title']}'),
          duration: const Duration(seconds: 3),
        ));
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
        actions: [
          IconButton(
              onPressed: () => submitForm(), icon: const Icon(Icons.save))
        ],
      ),
      body: awaitingResponse
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: formData['title'] as String?,
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
                        onSaved: (newValue) =>
                            formData['title'] = newValue as String,
                      ),
                      TextFormField(
                        initialValue: formData['price'] as String?,
                        focusNode: priceFocus,
                        onFieldSubmitted: (value) {
                          descriptionFocus.requestFocus();
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(labelText: 'Price'),
                        onSaved: (newValue) =>
                            formData['price'] = double.parse(newValue ?? '0'),
                        validator: (value) => StringValidationComposite(
                                validations: [IsValidPriceString()])
                            .validate(value),
                      ),
                      TextFormField(
                        initialValue: formData['description'] as String?,
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
                                      validations: [IsImageUrlString()])
                                  .validate(value),
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
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
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
