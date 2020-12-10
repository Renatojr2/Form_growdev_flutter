import 'package:appform/pages/widgets/form_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _form = GlobalKey();

  void validator() {
    if (_form.currentState.validate()) {
      print('validated');
    } else {
      print('not validated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: FormWidget(_form),
                ),
              ),
              Container(
                width: double.infinity,
                child: OutlineButton(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text('Cadastrar'),
                  onPressed: validator,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
