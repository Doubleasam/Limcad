import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:limcad/features/order/orders.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';




class PaymentWebPage extends StatefulWidget {
  const PaymentWebPage({super.key, required this.header, required this.url, required this.onConfirmPayment});
  final String header;
  final String url;
  final Function(String paymentReference) onConfirmPayment;

  @override
  State<PaymentWebPage> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentWebPage> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'PaymentChannel',
        onMessageReceived: (JavaScriptMessage message) {
          // Handle the paymentReference here
          final paymentReference = message.message;
          if (paymentReference.isNotEmpty) {
            widget.onConfirmPayment(paymentReference);
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() => _isLoading = progress < 100);
          },
          onPageStarted: (String url) {
            // Optionally handle page started
          },
          onPageFinished: (String url) {
            // Optionally handle page finished
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('paymentReference=')) {
              final Uri uri = Uri.parse(request.url);
              final paymentReference = uri.queryParameters['paymentReference'];
              if (paymentReference != null) {
                widget.onConfirmPayment(paymentReference);
                return NavigationDecision.prevent; // Prevent further navigation
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    // Optionally add JavaScript code if needed
    _controller.runJavaScript('''
    
      new URL(window.location.href).searchParams.get('paymentReference');
    ''');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * 0.75,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width - 100, child: Text(widget.header, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {

                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    onLoadStop: (_, __) => setState(() => _isLoading = false),
                    onReceivedServerTrustAuthRequest: (controller, challenge) async {
                      return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                    },
                  ),
                  if (_isLoading)
                    Positioned.fill(
                      child: Align(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


