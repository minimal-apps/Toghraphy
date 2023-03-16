import 'package:flutter/material.dart';
import 'package:toghraphy/app/bloc/app_bloc.dart';
import 'package:toghraphy/qna/qna.dart';

List<Page> onGeneratePages(PageStatus status, List<Page<dynamic>> pages) {
  // if (PageStatus.authenticated == status)
  return [QnaFlow.page()];
  // return [Authentication.page()];
}
