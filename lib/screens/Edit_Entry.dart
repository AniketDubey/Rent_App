import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:rentapp/models/data/DUMDATA.dart';
import 'package:rentapp/models/skeleton/Base_Summary.dart';

class Edit_Entry extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String uID;
  Base_Summary uDetail;

  Edit_Entry(this.uID, this.uDetail);

  double nAmount = 0;

  @override
  Widget build(BuildContext context) {
    void _editDetails(String uID, double newAmount) {
      Provider.of<BSummary>(context, listen: false)
          .edit_userData(uID, newAmount);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Screen"),
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
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Aadhar Number",
                    hintText: "${uDetail.id}",
                  ),
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
                      nAmount = double.parse(value.toString());
                    },
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "${uDetail.name}",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _editDetails(uID, nAmount);
                        Navigator.of(context).pop();
                      }
                    },
                    label: Text("Edit"),
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
