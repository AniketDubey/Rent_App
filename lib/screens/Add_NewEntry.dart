import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';

class Add_NewEntry extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Map<String, Object> _savedInfo = {
    "Aadhar": "",
    "Name": "",
    "ReqAmount": 0.0,
  };

  final Function _submitNewEntry;
  Add_NewEntry(this._submitNewEntry);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Entry"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Aadhar Number",
                  ),
                  validator: RequiredValidator(errorText: "Field Required"),
                  onSaved: (value) {
                    _savedInfo["Aadhar"] = value.toString();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Amount",
                    ),
                    validator: RequiredValidator(errorText: "Field Required"),
                    onSaved: (value) {
                      _savedInfo["ReqAmount"] = double.parse(value.toString());
                    },
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  validator: RequiredValidator(errorText: "Field Required"),
                  onSaved: (value) {
                    _savedInfo["Name"] = value.toString();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _submitNewEntry(_savedInfo);
                        Navigator.of(context).pop();
                      }
                    },
                    label: Text("Keep this Entry"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
