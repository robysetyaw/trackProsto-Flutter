import 'package:flutter/material.dart';
import 'package:meat_retailer/models/company.dart';
import 'package:meat_retailer/services/company_service.dart';

class CompanyView extends StatefulWidget {
  @override
  _CompanyViewState createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  final _companyService = CompanyService();
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  late Future<List<Company>> _companyFuture;

  @override
  void initState() {
    super.initState();
    _companyFuture = _companyService.getAllCompanies();
  }

  void _showAddCompanyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Company'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _companyNameController,
                    decoration: InputDecoration(labelText: 'Company Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter company name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                  child: Text('Add'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newCompany = Company(
                        companyName: _companyNameController.text,
                        address: _addressController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneNumberController.text,
                      );

                      final success =
                          await _companyService.addCompany(newCompany);

                      if (success) {
                        Navigator.of(context).pop();
                        // Refresh data setelah menambahkan company baru
                        setState(() {
                          _companyFuture = _companyService.getAllCompanies();
                        });
                      } else {
                        // Tampilkan pesan kesalahan
                      }
                    }
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies'),
      ),
      body: FutureBuilder<List<Company>>(
        future: _companyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final company = snapshot.data![index];
                return ListTile(
                  title: Text(company.companyName),
                  subtitle: Text(company.address),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCompanyDialog,
        child: Icon(Icons.add),
        tooltip: 'Add Company',
      ),
    );
  }
}
