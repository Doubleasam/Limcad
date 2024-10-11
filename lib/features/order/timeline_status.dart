import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 100.0;

class TimelineStatusPage extends StatelessWidget {

   TimelineStatusPage({Key? key})
      : super(key: key);


  List<OrderProgress> orderProgress = <OrderProgress>[
    OrderProgress(
        title: 'Order Confirmed',
        subtitle: 'The laundry service has received your order',
        time: "Tue, 4:30pm",
        status: OrderStatus.done
    ),
    OrderProgress(
        title: 'Rider En Route',
        subtitle: 'Rider is coming to pick up your clothes',
        time: "Tue, 4:30pm",
        status: OrderStatus.done
    ),
    OrderProgress(
        title: 'Laundry Commenced',
        subtitle: 'Your clothes are being washed',
        time: "Tue, 4:30pm",
        status: OrderStatus.done
    ),
    OrderProgress(
        title: 'Packaged',
        subtitle: 'Your clothes are washed, dried, ironed and packaged',
        time: "Tue, 4:30pm",
        status: OrderStatus.done
    ),
    OrderProgress(
        title: 'Rider En Route',
        subtitle: 'Rider is coming back to deliver your clothes',
        time: "Tue, 4:30pm",
        status: OrderStatus.inProgress
    ),
    OrderProgress(
        title: 'Package Delivered',
        subtitle: 'Your package has been successfully delivered',
        time: "Tue, 4:30pm",
        status: OrderStatus.todo
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Time taken to deliver", // Title for overall status
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: grey),
          ),

          Text(
            "2 days", // Title for overall status
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          _Timeline(orderProgress: orderProgress), // Pass orderProgress list
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<OrderProgress> orderProgress;

  const _Timeline({Key? key, required this.orderProgress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          connectorTheme: ConnectorThemeData(
            thickness: 3.0,
            color: Color(0xffd3d3d3),
            //  indent: 8
          ),
          indicatorTheme: IndicatorThemeData(
            size: 15.0,

          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        builder: TimelineTileBuilder.connected(
          contentsBuilder: (_context, index) => _TimelineContent(
              orderProgress[index].title, orderProgress[index].subtitle, orderProgress[index].time, orderProgress[index].status), // Pass data from OrderProgress
          connectorBuilder: (_, index, __) {
            if (index == 0 || orderProgress[index].status == OrderStatus.done) {
              return SolidLineConnector(color: Color(0xff6ad192));
            } else {
              return SolidLineConnector();
            }
          },
          indicatorBuilder: (_, index) {
            final status = orderProgress[index].status;
            if(index == 0)
              {
                return SizedBox();
              }
            switch (status) {
              case OrderStatus.done:
                return ContainerIndicator(
                  size: 16,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(shape: BoxShape.rectangle, color: CustomColors.rpLighterGreen, borderRadius: BorderRadius.circular(3)),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10.0,
                    ),
                  ),
                );
              case OrderStatus.inProgress:
                return ContainerIndicator(
                  size: 16,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(shape: BoxShape.rectangle, color: CustomColors.iconGrey.withOpacity(0.7), borderRadius: BorderRadius.circular(3)),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10.0,
                    ),
                  ),
                );
              case OrderStatus.todo:
              default:
                return ContainerIndicator(
                  size: 16,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(shape: BoxShape.rectangle, color: CustomColors.grey500.withOpacity(0.7), borderRadius: BorderRadius.circular(3)),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10.0,
                    ),
                  ),
                );;
            }
          },
          itemExtentBuilder: (_, __) => kTileHeight,
          itemCount: orderProgress.length,
        ),
      ),
    );
  }
}

class _TimelineContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final OrderStatus progress;

  const _TimelineContent(this.title, this.subtitle, this.time, this.progress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.only(left: 10.0),
      height: kTileHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:  progress == OrderStatus.done ? CustomColors.limcadPrimary : black),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                height: 30,
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color:  progress == OrderStatus.done ? CustomColors.blackPrimary :  Colors.grey),
                ),
              ),

              Text(
                time,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Define OrderProgress model
class OrderProgress {
  final String title;
  final String subtitle;
  final String time;
  final OrderStatus status;

  OrderStatus get getStatus => status; // Getter for status

  const OrderProgress({required this.title, required this.subtitle, required this.time, required this.status});
}



class _EmptyContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Color(0xffe6e7e9),
      ),
    );
  }
}

enum OrderStatus {
  done,
  sync,
  inProgress,
  todo,
}

extension on OrderStatus {
  bool get isInProgress => this == OrderStatus.inProgress;
}

