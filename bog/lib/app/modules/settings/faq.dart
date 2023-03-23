import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/expandable_faq.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
        child: GetBuilder<HomeController>(
      id: 'faq',
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: HomeBottomWidget(
            controller: controller,
            isHome: false,
            doubleNavigate: false,
          ),
          backgroundColor: AppColors.backgroundVariant2,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'FAQs'),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: Get.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'General',
                        style: AppTextStyle.headline6
                            .copyWith(color: AppColors.blue),
                      ),
                      const ExpandableFAQ(
                          question: 'What is BOG?',
                          answer:
                              'BOG is a project management platform that helps you carry out your project digitally and live tracking mode from wherever you are.'),
                      const ExpandableFAQ(
                        question: 'Who are the Service Partners?',
                        answer:
                            'These are the personnel’s that provide construction services for your project (Architect, Structural Engineers etc).',
                      ),
                      const ExpandableFAQ(
                          question: 'Who are the Product Partners?',
                          answer:
                              'These are the vendors that sells construction materials for your project (Cement, Sand etc).'),
                      const ExpandableFAQ(
                          question: 'Is BOG running 24 hours?',
                          answer:
                              'Yes, you can reach out to our customer care representatives all day round.'),
                      const ExpandableFAQ(
                          question: 'What product can I buy on BOG?',
                          answer:
                              'All building materials are available on BOG, check the shop to purchase a product.'),
                      const ExpandableFAQ(
                          question:
                              "What's the percentage accuracy of the Smart Calculator?",
                          answer:
                              'It is currently at 80% but we are working on improving it further.'),
                      const Divider(color: Colors.grey),
                      SizedBox(height: Get.height * 0.025),
                      Text('Our Services',
                          style: AppTextStyle.headline6
                              .copyWith(color: AppColors.blue)),
                      const ExpandableFAQ(
                          question: 'Why do I need a GeoTechnical Survey',
                          answer:
                              'You need a geotechnical survey to determine what is happening underground on your site, the soil type, and components as well as its solidity. It helps determine the capacity of the soil to carry your building.'),
                      const ExpandableFAQ(
                          question:
                              'How soon will my building approvals be ready?',
                          answer: 'It typically takes 3 months or more .'),
                      const ExpandableFAQ(
                          question: 'How soon do I get my buildings drawings?',
                          answer:
                              'You will start getting feedbacks on your drawings 14days after agreeing on a design.'),
                      const ExpandableFAQ(
                          question: 'How do I schedule a meeting?',
                          answer:
                              'Click on the meeting icon on your app, the BOG support team will be notified a meeting time will be agreed upon.'),
                      const ExpandableFAQ(
                          question: 'What is the cost of shipping?',
                          answer:
                              'This will be determined by the product category and the prevailing logistics rate.'),
                      const ExpandableFAQ(
                          question:
                              'Can I meet with a service or product partner one on one?',
                          answer:
                              'Yes, however, it can only be done on the in-app meeting room under the supervision of a BOG supervisor.'),
                      const Divider(color: Colors.grey),
                      SizedBox(height: Get.height * 0.025),
                      Text('Return Policy',
                          style: AppTextStyle.headline6
                              .copyWith(color: AppColors.blue)),
                      const ExpandableFAQ(
                          question: 'Can I get a refund?',
                          answer:
                              'Yes, please read more on the eligibility for a refund in the return policy to learn more.'),
                      const ExpandableFAQ(
                          question: 'Who covers the shipping fees for returns?',
                          answer:
                              'We cover the shipping fee on returns of products mistakenly packed by us. Please read return policy for more information.'),
                      const ExpandableFAQ(
                          question:
                              'Do I pay shipping fees on Products I want to return?',
                          answer:
                              'Yes, considering that your item is eligible for a return.'),
                      const ExpandableFAQ(
                          question:
                              'Can I replace or exchange an item rather than refund?',
                          answer:
                              'Yes, however this depends on the item category.'),
                      const ExpandableFAQ(
                          question: 'Can I return all products?',
                          answer:
                              'No, please see return policy to learn more.'),
                      const ExpandableFAQ(
                          question:
                              'How do I return a product or complain about a service?',
                          answer:
                              'Please call any of our helplines or send a mail to support@buildonthego.com.'),
                      const Divider(color: Colors.grey),
                      SizedBox(height: Get.height * 0.025),
                      Text('Security',
                          style: AppTextStyle.headline6
                              .copyWith(color: AppColors.blue)),
                      const ExpandableFAQ(
                          question: 'How can I change my login credentials?',
                          answer:
                              'Please call any of our helplines or send a mail to support@buildonthego.com to carry out this activity.'),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
