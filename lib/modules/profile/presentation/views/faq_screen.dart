import 'package:analogue_shifts_mobile/app/styles/app_colors.dart';
import 'package:analogue_shifts_mobile/app/widgets/app_bar_two.dart';
import 'package:analogue_shifts_mobile/modules/profile/presentation/widgets/faq_item.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PaylonyAppBarTwo(title: "FAQ"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10,
        ),
        child: ListView(
          children: [
            Text(
              "Having Problems? Contact us.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xffFFFCF3): const Color(0xff000000).withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  QAItem(title: Text("How does Analogue shifts work?", textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600
                    
                  ),), children: [
                    Text("Analog shifts entail transitioning from manual recruitment methods to digital solutions, optimizing processes for efficiency. This transition involves adopting online job boards & so much more. It aims to streamline hiring, enhance candidate experience, and improve overall recruitment outcomes.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.6) : AppColors.white.withOpacity(0.6)
                    )
                    )
                  ]),
                  QAItem(title: Text("What are some common digital tools used in talent acquisition?", textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600
                    
                  ),), children: [
                    Text("Analog shifts entail transitioning from manual recruitment methods to digital solutions, optimizing processes for efficiency. This transition involves adopting online job boards & so much more. It aims to streamline hiring, enhance candidate experience, and improve overall recruitment outcomes.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.6) : AppColors.white.withOpacity(0.6)
                    )
                    )
                  ]),
                  QAItem(title: Text("How do Analogshifts benefit both employers and job seekers?", textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600
                    
                  ),), children: [
                    Text("Analog shifts entail transitioning from manual recruitment methods to digital solutions, optimizing processes for efficiency. This transition involves adopting online job boards & so much more. It aims to streamline hiring, enhance candidate experience, and improve overall recruitment outcomes.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.6) : AppColors.white.withOpacity(0.6)
                    )
                    )
                  ]),
                  QAItem(title: Text("Role of data analytics?", textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600
                    
                  ),), children: [
                    Text("Analog shifts entail transitioning from manual recruitment methods to digital solutions, optimizing processes for efficiency. This transition involves adopting online job boards & so much more. It aims to streamline hiring, enhance candidate experience, and improve overall recruitment outcomes.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.6) : AppColors.white.withOpacity(0.6)
                    )
                    )
                  ]),
                  QAItem(title: Text("How do analog shifts impact traditional HR roles and responsibilities", textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600
                    
                  ),), children: [
                    Text("Analog shifts entail transitioning from manual recruitment methods to digital solutions, optimizing processes for efficiency. This transition involves adopting online job boards & so much more. It aims to streamline hiring, enhance candidate experience, and improve overall recruitment outcomes.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.6) : AppColors.white.withOpacity(0.6)
                    )
                    )
                  ]),
                  QAItem(title: Text("Industry best practices?", textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600
                    
                  ),), children: [
                    Text("Analog shifts entail transitioning from manual recruitment methods to digital solutions, optimizing processes for efficiency. This transition involves adopting online job boards & so much more. It aims to streamline hiring, enhance candidate experience, and improve overall recruitment outcomes.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness == Brightness.light ? const Color(0xff000000).withOpacity(0.6) : AppColors.white.withOpacity(0.6)
                    )
                    )
                  ]),
                ],
              ),
            )
          ],
        ),
        ),
    );
  }
}