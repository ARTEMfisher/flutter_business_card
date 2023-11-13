import 'package:flutter/material.dart';
import 'dart:io';

String? cell;
String? mail;
String? telegram;
String? vk;
String? name;

bool isCell = false;
bool isMail = false;
bool isTelegram = false;
bool isVk = false;
bool isName = false;
bool isIcon = false;

bool isCellPressed = false;
bool isMailPressed = false;
bool isTelegramPressed = false;
bool isVkPressed = false;
bool isNamePressed = false;

String vkURL = '';
String telegramURL = '';

String? path;

File? selectedImage;
File? copiedImage;
File? startImage;

void checkVk(checkedVk) {
  if (checkedVk.contains('@')) {
    checkedVk = checkedVk.replaceAll('@', '');
  }
  if (checkedVk.contains("https://vk.com/")) {
    checkedVk = checkedVk.replaceAll('https://vk.com/', '');
  }
  if (checkedVk.contains("vk.com/")) {
    checkedVk = checkedVk.replaceAll('vk.com/', '');
  }
  vk = checkedVk;
  vkURL = 'https://vk.com/' + checkedVk;
}

void checkTelegram(checkedTelegram) {
  if (checkedTelegram.contains('@')) {
    checkedTelegram = checkedTelegram.replaceAll('@', '');
  }
  if (checkedTelegram.contains('https://t.me/')) {
    checkedTelegram = checkedTelegram.replaceAll('https://t.me/', '');
  }
  if (checkedTelegram.contains('t.me/')) {
    checkedTelegram = checkedTelegram.replaceAll('t.me/', '');
  }
  telegram = '@' + checkedTelegram;
  telegramURL = 't.me/' + checkedTelegram;
}

TextStyle nameStyle =
    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
TextStyle labelText =
    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

SizedBox buttonPadding = const SizedBox(
  width: 10,
);
TextStyle buttonText =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

TextStyle aboutText = const TextStyle(fontSize: 35);

TextStyle qrText = const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
