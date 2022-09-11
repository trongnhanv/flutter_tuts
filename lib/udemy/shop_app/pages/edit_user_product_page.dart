import 'package:basic_tuts/udemy/shop_app/providers/product_provider.dart';
import 'package:basic_tuts/udemy/shop_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserProductArguments {
  final String? id;

  const EditUserProductArguments({this.id});
}

class EditUserProductPage extends StatefulWidget {
  static const routeName = '/EditUserProductPage';
  final EditUserProductArguments arguments;
  const EditUserProductPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<EditUserProductPage> createState() => _EditUserProductPageState();
}

class _EditUserProductPageState extends State<EditUserProductPage> {
  bool _isInit = true;
  bool _isLoading = false;

  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imgUrlFocusNode = FocusNode();
  final TextEditingController _imgUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  ProductProvider _editProduct = ProductProvider(
      id: DateTime.now().toString(),
      title: '',
      description: '',
      price: 0,
      imageUrl: '');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      var id = widget.arguments.id;
      if (id != null) {
        _editProduct = context.read<ProductsProviderV2>().findById(id);
        _imgUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  @override
  void initState() {
    super.initState();

    _imgUrlFocusNode.addListener(_handleImageUrlListener);
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_handleImageUrlListener);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlFocusNode.dispose();

    _imgUrlController.dispose();

    super.dispose();
  }

  void _handleImageUrlListener() {
    if (!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _handleSubmit() {
    if (_form.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _form.currentState!.save();
      context
          .read<ProductsProviderV2>()
          .saveProduct(_editProduct)
          .then((value) {
        Navigator.of(context).pop();
      }).onError((error, stackTrace) async {
        var confirm = await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Error!'),
                content: const Text('Something went wrong!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(_).pop(true);
                      },
                      child: const Text('OK'))
                ],
              );
            });
        if (confirm) {
          Navigator.of(context).pop();
        }
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  String? _validateRequired(String? value,
      [String message = 'Field is required']) {
    if (value!.isEmpty) {
      return message;
    }
    return null;
  }

  String? _validateUrl(String? value) {
    if (!value!.startsWith('http') && !value.startsWith('https')) {
      return 'Please enter a valid URL';
    }
    if (!value.endsWith('.png') &&
        !value.endsWith('.jpg') &&
        !value.endsWith('.jpeg')) {
      return 'Please enter a valid image URL';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () {
                _handleSubmit();
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      initialValue: _editProduct.title,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        return _validateRequired(value);
                      },
                      onSaved: (value) {
                        _editProduct = _editProduct.copyWith(title: value);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Price'),
                      initialValue: _editProduct.price.toString(),
                      focusNode: _priceFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        var message = _validateRequired(value);
                        if (message != null) {
                          return message;
                        }
                        if (double.tryParse(value!) == null) {
                          return "Please enter a valid number";
                        }

                        if (double.parse(value) <= 0) {
                          return "Please enter a number greater than zero";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editProduct = _editProduct.copyWith(
                            price: double.tryParse(value!));
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      initialValue: _editProduct.description,
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      validator: (value) {
                        return _validateRequired(value);
                      },
                      onSaved: (value) {
                        _editProduct =
                            _editProduct.copyWith(description: value);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(border: Border.all()),
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          child: Container(
                            child: _imgUrlController.text.isEmpty ||
                                    _validateUrl(_imgUrlController.text) != null
                                ? const Center(
                                    child: Text('Enter a url'),
                                  )
                                : Image.network(
                                    _imgUrlController.text,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (_, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const Center(
                                        child: Text('Loading'),
                                      );
                                    },
                                    errorBuilder: (_, __, error) {
                                      return const Center(
                                        child: Text('Error!'),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image Url'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imgUrlController,
                          focusNode: _imgUrlFocusNode,
                          validator: (value) {
                            var message = _validateRequired(value);
                            if (message != null) {
                              return message;
                            }
                            return _validateUrl(value);
                          },
                          onSaved: (value) {
                            _editProduct =
                                _editProduct.copyWith(imageUrl: value);
                          },
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
