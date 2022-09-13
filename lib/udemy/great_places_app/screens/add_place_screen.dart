import 'dart:io';

import 'package:basic_tuts/udemy/common/noti_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';
import '../models/place_model.dart';
import '../providers/places_provider.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatelessWidget {
  static const routeName = 'add-place-screen';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a New Place')),
      body: const PlaceForm(),
    );
  }
}

class PlaceForm extends StatefulWidget with NotiWidget {
  const PlaceForm({Key? key}) : super(key: key);

  @override
  State<PlaceForm> createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  final GlobalKey<FormState> _form = GlobalKey();
  PlaceModel _place =
      const PlaceModel(id: '', title: '', location: null, image: null);

  void _submit() {
    if (!_form.currentState!.validate()) {
      return;
    }
    if (_place.image == null) {
      widget.showAlertDialog(context,
          title: 'Error!', content: 'Please select an image');
    }
    _form.currentState!.save();
    context.read<PlacesProvider>().store(_place).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _place = _place.copyWith(title: value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ImageInput(onSelectImage: (File image) {
                    _place = _place.copyWith(image: image);
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  const LocationInput()
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.add),
              label: const Text('Add New'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            )
          ]),
    );
  }
}
