import 'package:flutter/material.dart';
import 'package:hg_sips/app/bloc/app_bloc.dart';
import 'package:hg_sips/app/view/authentication.dart';
import 'package:hg_sips/qna/qna.dart';

List<Page> onGeneratePages(PageStatus status, List<Page<dynamic>> pages) {
  if (PageStatus.authenticated == status) return [QnaFlow.page()];
  return [Authentication.page()];
}
