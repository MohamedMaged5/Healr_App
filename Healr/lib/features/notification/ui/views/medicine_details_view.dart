import 'package:flutter/material.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/ui/views/widgets/medicine_details_view_body.dart';

class MedicineDetailsView extends StatelessWidget {
  const MedicineDetailsView({super.key, required this.meds});

  final List<MedicineModel> meds;

  @override
  Widget build(BuildContext context) {
    return MedicineDetailsViewBody(
      meds: meds,
    );
  }
}
