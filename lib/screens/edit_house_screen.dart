import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/house.dart';
import '../providers/houses.dart';

class EditHouseScreen extends StatefulWidget {
  static const routeName = '/edit-house';

  @override
  _EditHouseScreenState createState() => _EditHouseScreenState();
}

class _EditHouseScreenState extends State<EditHouseScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedHouse = House(
    id: null,
    villagename: '',
    houseno: '',
    roomno: '',
    saloonno: '',
    tbno: '',
    kitchenno: '',
    ehouseno: '',
    houselocation: '',
    price: 0,
    housedescription: '',
    imageUrl: '',
  );
  var _initValues = {
    'villagename': '',
    'houseno': '',
    'roomno': '',
    'saloonno': '',
    'tbno': '',
    'kitchen': '',
    'ehouseno': '',
    'houselocation': '',
    'housedescription': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final houseId = ModalRoute.of(context).settings.arguments as String;
      if (houseId != null) {
        _editedHouse =
            Provider.of<Houses>(context, listen: false).findById(houseId);
        _initValues = {
          'villagename': _editedHouse.villagename,
          'houseno': _editedHouse.houseno,
          'roomno': _editedHouse.roomno,
          'saloonno': _editedHouse.saloonno,
          'tbno': _editedHouse.tbno,
          'kitchenno': _editedHouse.kitchenno,
          'ehouseno': _editedHouse.ehouseno,
          'houselocation': _editedHouse.houselocation,
          'housedescription': _editedHouse.housedescription,
          'price': _editedHouse.price.toString(),
          
          'imageUrl': '',
        };
        _imageUrlController.text = _editedHouse.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedHouse.id != null) {
      await Provider.of<Houses>(context, listen: false)
          .updateHouse(_editedHouse.id, _editedHouse);
    } else {
      try {
        await Provider.of<Houses>(context, listen: false)
            .addHouse(_editedHouse);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      }
   
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit House'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['villagename'],
                      decoration: InputDecoration(labelText: 'Village Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: value,
                            houseno: _editedHouse.houseno,
                            roomno: _editedHouse.roomno,
                            saloonno: _editedHouse.saloonno,
                            tbno: _editedHouse.tbno,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: _editedHouse.houselocation,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['houseno'],
                      decoration: InputDecoration(labelText: 'House Number'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a House Number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: value,
                            roomno: _editedHouse.roomno,
                            saloonno: _editedHouse.saloonno,
                            tbno: _editedHouse.tbno,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: _editedHouse.houselocation,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['roomno'],
                      decoration: InputDecoration(labelText: 'Number of Rooms'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Number Rooms.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: _editedHouse.houseno,
                            roomno: value,
                            saloonno: _editedHouse.saloonno,
                            tbno: _editedHouse.tbno,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: _editedHouse.houselocation,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['saloonno'],
                      decoration: InputDecoration(labelText: 'Number of Saloons'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Number Saloons.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: _editedHouse.houseno,
                            roomno: _editedHouse.roomno,
                            saloonno: value,
                            tbno: _editedHouse.tbno,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: _editedHouse.houselocation,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['tbno'],
                      decoration: InputDecoration(labelText: 'Number of Toilets and Bathroms'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Number Toilets and Bathroms.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: _editedHouse.houseno,
                            roomno: _editedHouse.roomno,
                            saloonno: _editedHouse.saloonno,
                            tbno: value,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: _editedHouse.houselocation,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['kitchenno'],
                      decoration: InputDecoration(labelText: 'Number of kitchens'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Number Kitchens.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: _editedHouse.houseno,
                            roomno: _editedHouse.roomno,
                            saloonno: _editedHouse.saloonno,
                            tbno: _editedHouse.tbno,
                            kitchenno: value,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: _editedHouse.houselocation,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['ehouseno'],
                      decoration: InputDecoration(labelText: 'Number of Extra Houses'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Number Extra Houses.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: _editedHouse.houseno,
                            roomno: _editedHouse.roomno,
                            saloonno: _editedHouse.saloonno,
                            tbno: _editedHouse.tbno,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: value,
                            houselocation: _editedHouse.houselocation,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['houselocation'],
                      decoration: InputDecoration(labelText: 'House Location'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a House Location.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: _editedHouse.houseno,
                            roomno: _editedHouse.roomno,
                            saloonno: _editedHouse.saloonno,
                            tbno: _editedHouse.tbno,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: value,
                            price: _editedHouse.price,
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                            villagename: _editedHouse.villagename,
                            houseno: _editedHouse.houseno,
                            roomno: _editedHouse.roomno,
                            saloonno: _editedHouse.saloonno,
                            tbno: _editedHouse.tbno,
                            kitchenno: _editedHouse.kitchenno,
                            ehouseno: _editedHouse.ehouseno,
                            houselocation: _editedHouse.houselocation,
                            price: double.parse(value),
                            housedescription: _editedHouse.housedescription,
                            imageUrl: _editedHouse.imageUrl,
                            id: _editedHouse.id,
                            isFavorite: _editedHouse.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['housedescription'],
                      decoration: InputDecoration(labelText: 'House Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a house description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedHouse = House(
                          villagename: _editedHouse.villagename,
                          houseno: _editedHouse.houseno,
                          roomno: _editedHouse.roomno,
                          saloonno: _editedHouse.saloonno,
                          tbno: _editedHouse.tbno,
                          kitchenno: _editedHouse.kitchenno,
                          ehouseno: _editedHouse.ehouseno,
                          houselocation: _editedHouse.houselocation,
                          price: _editedHouse.price,
                          housedescription: value,
                          imageUrl: _editedHouse.imageUrl,
                          id: _editedHouse.id,
                          isFavorite: _editedHouse.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedHouse = House(
                                villagename: _editedHouse.villagename,
                                houseno: _editedHouse.houseno,
                                roomno: _editedHouse.roomno,
                                saloonno: _editedHouse.saloonno,
                                tbno: _editedHouse.tbno,
                                kitchenno: _editedHouse.kitchenno,
                                ehouseno: _editedHouse.ehouseno,
                                houselocation: _editedHouse.houselocation,
                                price: _editedHouse.price,
                                housedescription: _editedHouse.housedescription,
                                imageUrl: value,
                                id: _editedHouse.id,
                                isFavorite: _editedHouse.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
