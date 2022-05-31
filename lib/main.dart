import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preference',
      home: SharedPrefereceExample(),
    );
  }
}

class SharedPrefereceExample extends StatefulWidget {
  @override
  _SharedPreferenceExampleState createState() =>
      _SharedPreferenceExampleState();
}

class _SharedPreferenceExampleState extends State<SharedPrefereceExample> {
  int _numberPref = 0;
  bool _boolPref = false;

  static const kNumberPrefKey = 'number_pref';
  static const kBoolPrefKey = 'bool_pref';

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      .then(
        (prefs) {
          setState(() => _prefs = prefs);
          _loadBoolPref();
          _loadNumberPref();
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
      ),
      body: Column(
        children: <Widget>[
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(children: <Widget>[
                Text('Number Preference'),
                Text('${_numberPref}'),
                ElevatedButton(
                  child: Text('Increment'),
                  onPressed: () {
                    _setNumberPref(_numberPref + 1);
                  },
                ),
              ]),
              TableRow(children: <Widget>[
                Text('Boolean Preference'),
                Text('${_boolPref}'),
                ElevatedButton(
                  child: Text('Toogle'),
                  onPressed: () {
                    _setBoolPref(!_boolPref);
                  },
                ),
              ]),
            ],
          ),
          ElevatedButton(
            child: Text('Reset Data'),
            onPressed: () => _resetDataPref(),
          ),
        ],
      ),
    );
  }

  Future<void> _setNumberPref(int value) async {
    await _prefs.setInt(kNumberPrefKey, value);
    _loadNumberPref();
  }

  Future<void> _setBoolPref(bool value) async {
    await _prefs.setBool(kBoolPrefKey, value);
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      _numberPref = _prefs.getInt(kNumberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      _boolPref = _prefs.getBool(kBoolPrefKey) ?? false;
    });
  }

  Future<Null> _resetDataPref() async{
    await _prefs.remove(kNumberPrefKey);
    await _prefs.remove(kBoolPrefKey);
    _loadNumberPref();
    _loadBoolPref();
  }
}
