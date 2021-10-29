import 'package:flutter/material.dart';
import 'package:new_flutter2/modules/news_app_modules/web_view_screen/web_view_screen_news.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  Function? function,
  required String text,
}) {
  return Container(
    width: width,
    height: 45.0,
    child: MaterialButton(
      onPressed: function!(),
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

TextFormField defaultFormFieldF({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData iconPrefix,
  IconData? suffix,
  FocusNode? focusNodes,
  required Function suffixPress,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  required GestureTapCallback onTab,
  bool isPassword = false,
  bool isClicked = true,
  bool autoFocused = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    enabled: isClicked,
    autofocus: autoFocused,
    focusNode: focusNodes,
    validator: validate,
    onTap: onTab,
    onChanged: onChanged,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(4.0),
      label: Text(label),
      prefixIcon: Icon(iconPrefix),
      suffix: Icon(suffix),
      suffixIcon: suffixPress(),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.blueGrey,
          width: 2.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
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

Widget buildArticleItem(article, BuildContext ctx) => InkWell(
      onTap: () {
        navigatorTo(ctx, WebViewScreen(url: article['url']));
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
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
