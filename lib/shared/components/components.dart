import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_flutter2/layout/news_app/cubit/cubit.dart';

//import 'package:new_flutter2/modules/news_app/web_view_screen/web_view_screen_news.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double height = 45.0,
  bool isUpperCase = true,
  double radius = 10.0,
  VoidCallback? function,
  required String text,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: background,
    ),
  );
}

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

TextFormField defaultFormFieldF({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String>? validate,
  required String label,
  String? text,
  IconData? iconPrefix,
  IconData? suffix,
  FocusNode? focusNodes,
  Widget? suffixIcon,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  required GestureTapCallback onTab,
  bool isPassword = false,
  bool isClicked = true,
  bool autoFocused = false,
  EdgeInsetsGeometry? contentPadding = const EdgeInsets.all(4.0),
  double radiusEnable = 25.0,
  double radiusBorder = 25.0,
  int maxLinesL = 1,
  Color colorE = Colors.blueGrey,
  double radiusWidth = 2.0,
  TextAlignVertical? textAlignVertical = TextAlignVertical.top,
}) {
  return TextFormField(
    maxLines: maxLinesL,
    controller: controller,
    keyboardType: type,
    enabled: isClicked,
    textAlignVertical: textAlignVertical,
    autofocus: autoFocused,
    focusNode: focusNodes,
    validator: validate,
    onTap: onTab,
    onChanged: onChanged,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      contentPadding: contentPadding,
      label: Text(label),
      hintText: text,
      prefixIcon: Icon(iconPrefix),
      suffix: Icon(suffix),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusEnable),
        borderSide: BorderSide(
          color: colorE,
          width: radiusWidth,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusBorder),
        borderSide: const BorderSide(
          color: Colors.deepOrange,
        ),
      ),
    ),
  );
}

Widget listTasksItem(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.blue,
              child: Text('${model['time']}'),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archived', id: model['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );

Widget buildArticleItem(article, BuildContext ctx, int index) => Container(
      color: NewsCubit.get(ctx).selectItemColorBusinessIndex == index &&
          NewsCubit.get(ctx).isDesktop
          ? Colors.grey[200]
          : Colors.white,
      child: InkWell(
        onTap: () {
          NewsCubit.get(ctx).selectItemBusinessColor(index);
          //navigatorTo(ctx, WebViewScreen(url: article['url']));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: SizedBox(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${article['title']}',
                          style: Theme.of(ctx).textTheme.bodyText2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          '${article['publishedAt']}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget myDivider({
  double paddingH = 15.0,
  double paddingV = 15.0,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingH,
        vertical: paddingV,
      ),
      child: Container(
        color: Colors.grey[400],
        height: 1.0,
        width: double.infinity,
      ),
    );

void navigatorTo(BuildContext ctx, Widget widget) => Navigator.push(
      ctx,
      MaterialPageRoute(builder: (ctx) => widget),
    );

void navigateAndFinish(BuildContext ctx, Widget widget) =>
    Navigator.pushAndRemoveUntil(
      ctx,
      MaterialPageRoute(builder: (ctx) => widget),
      (route) => false,
    );

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: chooseToastState(state),
      textColor: Colors.white,
      fontSize: 20.0,
    );

enum ToastState { success, failed, warned }

Color chooseToastState(ToastState state) {
  switch (state) {
    case ToastState.success:
      return Colors.green;
    case ToastState.failed:
      return Colors.red;
    case ToastState.warned:
      return Colors.yellow;
  }
}
