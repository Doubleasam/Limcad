import 'package:flutter/material.dart';

class LaundryCustomerCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String address;
  final String distance;
  final String paymentMethod;
  final double rating;
  final String imageUrl;

  const LaundryCustomerCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.distance,
    required this.paymentMethod,
    required this.rating,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildInfoRow('Phone: $phoneNumber'),
                    SizedBox(height: 8),
                    _buildInfoRow('Address: $address'),
                    SizedBox(height: 8),
                    _buildInfoRow('Distance: $distance'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoRow('Payment: $paymentMethod'),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.blue),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      overflow: TextOverflow.ellipsis,
    );
  }
}
