import 'package:flutter/material.dart';
import 'package:healr/features/notification/data/models/medicine_model.dart';
import 'package:healr/features/notification/ui/views/widgets/medicine_view_body.dart';

class MedicineView extends StatelessWidget {
  final List<MedicineModel> med;

  const MedicineView({super.key, required this.med});

  @override
  Widget build(BuildContext context) {
    return MedicineViewBody(
      med: med,
    );
  }
}
