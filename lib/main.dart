import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:business_card/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:business_card/const.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:restart_app/restart_app.dart';

// https://free-images.com
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: const Color.fromARGB(255, 5, 46, 196),
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color.fromARGB(255, 5, 46, 196),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Visit Card',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getCell();
    getMail();
    getTelegram();
    getVk();
    getName();
    getImage();
    super.initState();
  }

  void getCell() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      cell = data.getString('cell');
      if (cell != null) {
        isCell = true;
      } else {
        isCell = false;
      }
    });
  }

  void getMail() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      mail = data.getString('mail');
    });
    if (mail != null) {
      isMail = true;
    } else {
      isMail = false;
    }
  }

  void getTelegram() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      telegram = data.getString('telegram');
    });
    if (telegram != null) {
      setState(() {
        isTelegram = true;
      });
      checkTelegram(telegram);
    } else {
      isTelegram = false;
    }
  }

  void getVk() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      vk = data.getString('vk');
    });
    if (vk != null) {
      isVk = true;
      checkVk(vk);
    } else {
      isVk = false;
    }
  }

  void getName() async {
    final SharedPreferences data = await SharedPreferences.getInstance();
    setState(() {
      name = data.getString('name');
      if (name != null) {
        isName = true;
      }
    });
  }

  void copyImage() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    path = appDir.path;
    if (isIcon == true) {
      setState(() {
        File('$path/image.jpeg').delete();
      });
    }
    copiedImage = await selectedImage!.copy('$path/image.jpeg');
    setState(() {
      copiedImage;
      isIcon = true;
    });
    Restart.restartApp();
  }

  void getImage() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    path = appDir.path;
    if (File('$path/image.jpeg').existsSync() == false) return;

    setState(() {
      copiedImage = File('$path/image.jpeg');
      isIcon = true;
    });
  }

  void deleteImage() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    path = appDir.path;
    if (isIcon == true) {
      setState(() {
        isIcon = false;
        File('$path/image.jpeg').delete();
      });
    }
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });
    copyImage();
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
    copyImage();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            child: const Icon(CupertinoIcons.gear_solid),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          )
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: SizedBox(
                                      width: size / 2,
                                      height: size / 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                pickImageFromCamera();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  const FaIcon(
                                                      FontAwesomeIcons.camera),
                                                  buttonPadding,
                                                  Text('Take photo',
                                                      style: buttonText)
                                                ],
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                pickImageFromGallery();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  const FaIcon(FontAwesomeIcons
                                                      .photoFilm),
                                                  buttonPadding,
                                                  Text('Change photo',
                                                      style: buttonText)
                                                ],
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                deleteImage();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  const FaIcon(
                                                      FontAwesomeIcons.trash),
                                                  buttonPadding,
                                                  Text('Delete photo',
                                                      style: buttonText)
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: Column(children: <Widget>[
                          isIcon
                              ? CircleAvatar(
                                  radius: size / 4,
                                  foregroundImage: FileImage(copiedImage!),
                                )
                              : CircleAvatar(
                                  radius: size / 4,
                                  foregroundImage: const AssetImage(
                                      'images/startAvatar.jpg'),
                                ),
                        ]))
                  ],
                ),
                if (isName == false &&
                    isCell == false &&
                    isMail == false &&
                    isTelegram == false &&
                    isVk == false)
                  Text(
                    'Enter your details in settings',
                    style: nameStyle,
                  ),
                if (isName == true)
                  Text(
                    '$name',
                    style: nameStyle,
                  ),
              ],
            ),
            if (isCell)
              Card(
                child: Container(
                  constraints: BoxConstraints(maxWidth: size),
                  child: ListTile(
                      leading: const FaIcon(FontAwesomeIcons.phone),
                      title: Text('$cell'),
                      onLongPress: () {
                        setState(() {
                          isCellPressed = true;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isCellPressed = false;
                          });
                        });
                      },
                      trailing: isCellPressed
                          ? TextButton(
                              onPressed: () async {
                                final SharedPreferences data =
                                    await SharedPreferences.getInstance();

                                setState(() {
                                  data.remove('cell');
                                  isCell = false;
                                });
                              },
                              child: Container(
                                width: size / 5,
                                height: size / 9,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                    child: FaIcon(FontAwesomeIcons.trash)),
                              ),
                            )
                          : null),
                ),
              ),
            if (isMail)
              Card(
                child: Container(
                  constraints: BoxConstraints(maxWidth: size),
                  child: ListTile(
                    leading: const FaIcon(FontAwesomeIcons.at),
                    title: Text('$mail'),
                    onLongPress: () {
                      setState(() {
                        isMailPressed = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          isMailPressed = false;
                        });
                      });
                    },
                    trailing: isMailPressed
                        ? TextButton(
                            onPressed: () async {
                              final SharedPreferences data =
                                  await SharedPreferences.getInstance();

                              setState(() {
                                data.remove('mail');
                                isMail = false;
                              });
                            },
                            child: Container(
                              width: size / 5,
                              height: size / 9,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: FaIcon(FontAwesomeIcons.trash)),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            if (isTelegram)
              Card(
                child: Container(
                  constraints: BoxConstraints(maxWidth: size),
                  child: ListTile(
                    leading: const FaIcon(FontAwesomeIcons.telegram),
                    title: Text('$telegram'),
                    onLongPress: () {
                      setState(() {
                        isTelegramPressed = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          isTelegramPressed = false;
                        });
                      });
                    },
                    trailing: isTelegramPressed
                        ? TextButton(
                            onPressed: () async {
                              final SharedPreferences data =
                                  await SharedPreferences.getInstance();

                              setState(() {
                                data.remove('telegram');
                                isTelegram = false;
                              });
                            },
                            child: Container(
                              width: size / 5,
                              height: size / 9,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: FaIcon(FontAwesomeIcons.trash)),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            if (isVk)
              Card(
                child: Container(
                  constraints: BoxConstraints(maxWidth: size),
                  child: ListTile(
                    leading: const FaIcon(FontAwesomeIcons.vk),
                    title: Text('$vk'),
                    onLongPress: () {
                      setState(() {
                        isVkPressed = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          isVkPressed = false;
                        });
                      });
                    },
                    trailing: isVkPressed
                        ? TextButton(
                            onPressed: () async {
                              final SharedPreferences data =
                                  await SharedPreferences.getInstance();

                              setState(() {
                                data.remove('vk');
                                isVk = false;
                              });
                            },
                            child: Container(
                              width: size / 5,
                              height: size / 9,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: FaIcon(FontAwesomeIcons.trash)),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (isTelegram)
                  Column(
                    children: <Widget>[
                      Text('Telegram', style: qrText),
                      TextButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: SizedBox(
                                      width: size / 1.2,
                                      height: size / 1.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            child: QrImageView(
                                              data: telegramURL,
                                              version: QrVersions.auto,
                                              size: size / 1.5,
                                            ),
                                          ),
                                          Text('Telegram', style: nameStyle)
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: QrImageView(
                          data: telegramURL,
                          version: QrVersions.auto,
                          size: size / 2.75,
                          backgroundColor:
                              const Color.fromARGB(255, 236, 227, 227),
                        ),
                      )
                    ],
                  ),
                if (isVk)
                  Column(
                    children: <Widget>[
                      Text('Vk', style: qrText),
                      TextButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      content: SizedBox(
                                    width: size / 1.2,
                                    height: size / 1.2,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            child: QrImageView(
                                              data: vkURL,
                                              version: QrVersions.auto,
                                              size: size / 1.5,
                                            ),
                                          ),
                                          Text(
                                            'VK',
                                            style: nameStyle,
                                          )
                                        ]),
                                  )));
                        },
                        child: QrImageView(
                          data: vkURL,
                          version: QrVersions.auto,
                          size: size / 2.75,
                          backgroundColor:
                              const Color.fromARGB(255, 236, 227, 227),
                        ),
                      ),
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
