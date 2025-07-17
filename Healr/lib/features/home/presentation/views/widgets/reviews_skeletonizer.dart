import 'package:flutter/material.dart';
import 'package:healr/features/home/data/models/all_doctors_model/review.dart';
import 'package:healr/features/home/presentation/views/widgets/review_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReviewsSkeletonizer extends StatelessWidget {
  const ReviewsSkeletonizer({super.key, this.review});
  final Review? review;
  @override
  Widget build(BuildContext context) {
    // Create a mock review for skeleton display to avoid null/empty image issues
    final mockReview = Review(
      userName: "Loading User...",
      userImage: "", // This will now be handled safely by ReviewCard
      rating: 5,
      reviewText: "Loading review comment...",
      createdAt: DateTime.now(),
    );

    return Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ReviewCard(
              review: mockReview,
            );
          },
        ));
  }
}
