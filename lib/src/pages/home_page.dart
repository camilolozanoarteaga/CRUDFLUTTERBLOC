import 'package:flutter/material.dart';
import 'package:form_validator/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('home Page'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('email: ${bloc.email}'),
            Divider(),
            Text('pass: ${bloc.password}'),
          ],
        ),
      ),
    );
  }
}