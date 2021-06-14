import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rentagreement.dart';
import '../providers/houses.dart';

class EditRentAgreementScreen extends StatefulWidget {
  static const routeName = '/edit-rentagreement';

  @override
  _EditRentAgreementScreenState createState() => _EditRentAgreementScreenState();
}

class _EditRentAgreementScreenState extends State<EditRentAgreementScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedRentAgreement = RentAgreement(
    id: null,
    investorname: '',
    rentername: '',
    houseno: '',
    location: '',
    date: '',
  );
  var _initValues = {
    'investorname': '',
    'rentername': '',
    'houseno': '',
    'location': '',
    'date': '',
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
      final rentagreementId = ModalRoute.of(context).settings.arguments as String;
      if (rentagreementId != null) {
        _editedRentAgreement =
            Provider.of<Houses>(context, listen: false).findByIda(rentagreementId);
        _initValues = {
          'investorname': _editedRentAgreement.investorname,
          'rentername': _editedRentAgreement.rentername,
          'houseno': _editedRentAgreement.houseno,
          'location': _editedRentAgreement.location,
          'date': _editedRentAgreement.date,
        };
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
    if (_editedRentAgreement.id != null) {
      // await Provider.of<Houses>(context, listen: false)
      //     .updateCancel(_editedCancel.id, _editedCancel);
    } else {
      try {
        await Provider.of<Houses>(context, listen: false)
            .addRentAgreement(_editedRentAgreement);
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
    // Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent Agreement'),
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
                      initialValue: _initValues['investorname'],
                      decoration: InputDecoration(labelText: 'Investor Names'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide Investor Names.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRentAgreement = RentAgreement(
                            investorname: value,
                            rentername: _editedRentAgreement.rentername,
                            houseno: _editedRentAgreement.houseno,
                            location: _editedRentAgreement.location,
                            date: _editedRentAgreement.date,
                            id: _editedRentAgreement.id);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['rentername'],
                      decoration: InputDecoration(labelText: 'Renter Names'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide Renter Names.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRentAgreement = RentAgreement(
                            investorname: _editedRentAgreement.investorname,
                            rentername: value,
                            houseno: _editedRentAgreement.houseno,
                            location: _editedRentAgreement.location,
                            date: _editedRentAgreement.date,
                            id: _editedRentAgreement.id);
                      },
                    ),
                    
                    TextFormField(
                      initialValue: _initValues['houseno'],
                      decoration: InputDecoration(labelText: 'House Id'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide House Id.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRentAgreement = RentAgreement(
                            investorname: _editedRentAgreement.investorname,
                            rentername: _editedRentAgreement.rentername,
                            houseno: value,
                            location: _editedRentAgreement.location,
                            date: _editedRentAgreement.date,
                            id: _editedRentAgreement.id);
                      },
                    ),
                   TextFormField(
                      initialValue: _initValues['location'],
                      decoration: InputDecoration(labelText: 'House Location'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide House Location.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedRentAgreement = RentAgreement(
                            investorname: _editedRentAgreement.investorname,
                            rentername: _editedRentAgreement.rentername,
                            houseno: _editedRentAgreement.houseno,
                            location: value,
                            date: _editedRentAgreement.date,
                            id: _editedRentAgreement.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
