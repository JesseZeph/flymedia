import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/models/response/campaign_upload_response.dart';
import 'package:flymedia_app/services/helpers/campaign_helper.dart';
import 'package:flymedia_app/src/search/widget/custom_field.dart';

import '../influencerDashboard/dashboardPages/campaignpage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(25.w),
            ),
            child: CustomField(
              controller: controller,
              onTap: () {
                setState(() {});
              },
            )),
      ),
      body: controller.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: FutureBuilder<List<CampaignUploadResponse>>(
                  future: CampaignHelper.searchCampaign(controller.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.data!.isEmpty) {
                      return const Text("No Campaign Available");
                    } else {
                      final campaigns = snapshot.data;

                      return ListView.builder(
                        itemCount: campaigns!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var campaign = campaigns[index];
                          return CampaignListTile(
                            campaign: campaign,
                          );
                        },
                      );
                    }
                  }))
          : const NoSearchResults(text: 'Start Searching...'),
    );
  }
}
