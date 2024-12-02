import 'package:ecoparking_flutter/config/app_paths.dart';
import 'package:ecoparking_flutter/pages/ticket_details/widgets/dash_separator.dart';
import 'package:ecoparking_flutter/utils/navigation_utils.dart';
import 'package:ecoparking_flutter/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Test Page',
      onBackButtonPressed: (scaffoldContext) {
        NavigationUtils.navigateTo(
          context: scaffoldContext,
          path: AppPaths.profile,
        );
      },
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFCACACA),
                          width: 2.0,
                        ),
                        left: BorderSide(
                          color: Color(0xFFCACACA),
                          width: 2.0,
                        ),
                        right: BorderSide(
                          color: Color(0xFFCACACA),
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xFFA1A1A1),
                                    ),
                            children: const <InlineSpan>[
                              TextSpan(
                                  text: 'Scan this on the scanner machine\n'),
                              TextSpan(
                                text: 'when you are in the parking lot',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        QrImageView.withQr(
                          qr: QrCode.fromData(
                            data: 'test',
                            errorCorrectLevel: QrErrorCorrectLevel.L,
                          ),
                          version: QrVersions.max,
                          size: 200.0,
                        ),
                      ],
                    ),
                  ),
                  const DashSeparator(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFCACACA),
                      width: 2.0,
                    ),
                    left: BorderSide(
                      color: Color(0xFFCACACA),
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: Color(0xFFCACACA),
                      width: 2.0,
                    ),
                  ),
                ),
                child: GridView.count(
                  primary: false,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text("He'd have you all unravel at the"),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Heed not the rabble'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Sound of screams but the'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Who scream'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Revolution is coming...'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Revolution, they...'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
