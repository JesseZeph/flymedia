import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/src/clientdashboard/contracts/widget/contract_card.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../models/active_campaigns.dart';
import '../../../providers/campaign_provider.dart';
import '../../../utils/widgets/alert_loader.dart';
import '../../../utils/widgets/custom_text.dart';

class InfluencerContracts extends StatefulWidget {
  const InfluencerContracts(
      {super.key, required this.userType, required this.userId});
  final String userType;
  final String userId;
  @override
  State<InfluencerContracts> createState() => _InfluencerContractsState();
}

class _InfluencerContractsState extends State<InfluencerContracts> {
  late Future<List<ActiveCampaignModel>> contracts;

  @override
  void initState() {
    super.initState();
    contracts = context
        .read<CampaignsNotifier>()
        .fetchActiveCampaigns(userType: widget.userType, id: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Your Contracts',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: FutureBuilder<List<ActiveCampaignModel>>(
            future: contracts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AlertLoader(message: 'Fetching contracts');
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      var contract = snapshot.data![index];
                      return ContractCardWidget(
                        contract: contract,
                        isClient: widget.userType == 'Client',
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                    itemCount: snapshot.data?.length ?? 0);
              }
              return const Center(
                child: CustomKarlaText(
                  text: 'No ongoing contracts found',
                  size: 20,
                  weight: FontWeight.w500,
                ),
              );
            },
          )),
    );
  }
}
