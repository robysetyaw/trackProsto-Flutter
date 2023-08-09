import 'package:flutter/material.dart';
import 'package:meat_retailer/models/company.dart';
import 'package:meat_retailer/services/company_service.dart';

class CompanyView extends StatefulWidget {
  @override
  _CompanyViewState createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  final _companyService = CompanyService();
  late Future<List<Company>> _companyFuture;

  @override
  void initState() {
    super.initState();
    _companyFuture = _companyService.getAllCompanies();
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
    );
  }
}
