import 'package:flutter/material.dart';

abstract class MovieItem{

  Widget buildHeader(BuildContext context);

  Widget buildBody(BuildContext context);

  Widget buildFooter(BuildContext context);

}