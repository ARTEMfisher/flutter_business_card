import 'package:business_card/main.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:business_card/const.dart';
import 'package:business_card/about.dart';

//Icons.alternate_email

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void setCell(value) async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      data.setString('cell', value);
    });
  }

  void getCellReplace() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      cell = data.getString('cell');
    });
    if (cell != null) {
      setState(() {
        isCell = true;
      });
    }
  }

  void setMail(value) async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      data.setString('mail', value);
    });
  }

  void getMailReplace() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      mail = data.getString('mail');
    });
    if (mail != null) {
      setState(() {
        isMail = true;
      });
    }
  }

  void setTelegram(value) async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      data.setString('telegram', value);
    });
  }

  void getTelegramReplace() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      telegram = data.getString('telegram');
    });
    if (telegram != null) {
      setState(() {
        isTelegram = true;
      });
      checkTelegram(telegram);
    }
  }

  void setVk(value) async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      data.setString('vk', value);
    });
  }

  void getVkReplace() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      vk = data.getString('vk');
    });
    if (vk != null) {
      setState(() {
        isVk = true;
      });
      checkVk(vk);
    }
  }

  void clearData() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    data.clear();
  }

  void setName(value) async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      data.setString('name', value);
    });
  }

  void getNameReplace() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      name = data.getString('name');
    });
    if (data.getString('name') != null) {
      setState(() {
        isName = true;
      });
    } else {
      setState(() {
        isName = false;
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          TextButton(
              onPressed: () {
                getCellReplace();
                getMailReplace();
                getTelegramReplace();
                getVkReplace();
                getNameReplace();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MyHomePage()));
              },
              child: const Icon(Icons.arrow_back)),
          const SizedBox(
            width: 10,
          ),
          const Text('Settings'),
        ],
      )),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Dark theme', style: labelText),
                    const SizedBox(width: 10),
                    Switch(
                      value: AdaptiveTheme.of(context).mode.isDark,
                      onChanged: (value) {
                        if (value) {
                          AdaptiveTheme.of(context).setDark();
                        } else {
                          AdaptiveTheme.of(context).setLight();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Form(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Name'),
                      onChanged: (value) {
                        setName(value);
                      },
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Cell'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setCell(value);
                      },
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setMail(value);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'eMail'),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setTelegram(value);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Telegram ID'),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setVk(value);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          labelText: 'Vk ID'),
                    ),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          clearData();
                        },
                        child: const Text('Clear Data'))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const About()));
                        },
                        child: const Text('About'))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
