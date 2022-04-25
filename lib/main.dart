import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/login_screen/login_screen.dart';
import 'package:socialapp/shared/bloc/bloc_observer.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/bloc/state.dart';
import 'package:socialapp/shared/components/compenents.dart';
import 'package:socialapp/shared/components/constantes.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';
import 'package:socialapp/shared/style/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
   print('on Background Messaging');
   print(message.data.toString());
   showToast(text: 'on background message', state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token=FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on Message opened app');
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  await CashHelper.init();
  Widget widget;
  uId = CashHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..userGetData()..getPosts()
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
