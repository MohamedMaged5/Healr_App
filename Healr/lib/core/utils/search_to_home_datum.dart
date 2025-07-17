import 'package:healr/features/home/data/models/all_doctors_model/datum.dart'
    as home;
import 'package:healr/features/search/data/models/doctor_name_model/search_name.dart'
    as search_name;
import 'package:healr/features/search/data/models/doctor_specialization_model/search_specializtion.dart'
    as search_special;

// Converts a search model Datum (name) to a home model Datum
home.Datum convertSearchDatumToHomeDatum(search_name.SearchName s) {
  return home.Datum(
    image: s.image,
    name: s.name,
    specialization: s.specialization,
    rate: s.rate,
    id: s.id,
    nationalId: null,
    exp: s.exp,
    doctorSchedule: null,
    reviews: s.reviews,
    workingHours: null,
    createdAt: null,
    updatedAt: null,
    v: null,
  );
}

// Converts a search model Datum (specialization) to a home model Datum
home.Datum convertSpecializationDatumToHomeDatum(
    search_special.SearchSpecialization s) {
  return home.Datum(
    image: s.image,
    name: s.name,
    specialization: s.specialization,
    rate: s.rate,
    id: s.id,
    nationalId: null,
    exp: s.exp,
    doctorSchedule: null,
    reviews: s.reviews,
    workingHours: null,
    createdAt: null,
    updatedAt: null,
    v: null,
  );
}
