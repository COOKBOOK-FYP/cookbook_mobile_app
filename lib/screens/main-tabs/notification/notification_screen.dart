import 'package:cookbook/blocs/notification/notification_bloc.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/screens/main-tabs/notification/widgets/notification_widget.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(NotificationEventFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationStateFetching) {
          return const LoadingWidget();
        }
        if (state is NotificationStateEmpty) {
          return RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(microseconds: 500), () {
                context.read<NotificationBloc>().add(NotificationEventFetch());
              });
            },
            child: Scaffold(
              appBar: const PrimaryAppbarWidget(),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(LottieAssets.notification, repeat: true),
                  "No new notifications".text.bold.xl2.make().centered(),
                ],
              ),
            ),
          );
        }
        if (state is NotificationStateFetched) {
          return RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(microseconds: 500), () {
                context.read<NotificationBloc>().add(NotificationEventFetch());
              });
            },
            child: Scaffold(
              appBar: const PrimaryAppbarWidget(),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          notificationModel: state.notifications[index],
                        );
                      },
                      itemCount: state.notifications.length,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                  50.heightBox,
                ],
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(microseconds: 500), () {
              context.read<NotificationBloc>().add(NotificationEventFetch());
            });
          },
          child: const Scaffold(
            appBar: PrimaryAppbarWidget(),
          ),
        );
      },
    );
  }
}
