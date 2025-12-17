import 'package:equatable/equatable.dart';

/// Region entity - represents a region in the domain layer
class Region extends Equatable {
  final String id;
  final String name;
  final String currencyCode;
  final List<Country> countries;
  final DateTime createdAt;

  const Region({
    required this.id,
    required this.name,
    required this.currencyCode,
    this.countries = const [],
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, currencyCode, countries, createdAt];
}

/// Country entity
class Country extends Equatable {
  final String iso2;
  final String iso3;
  final String name;
  final String displayName;

  const Country({required this.iso2, required this.iso3, required this.name, required this.displayName});

  @override
  List<Object?> get props => [iso2, iso3, name, displayName];
}

/// Regions list with pagination info
class RegionsList extends Equatable {
  final List<Region> regions;
  final int count;
  final int offset;
  final int limit;

  const RegionsList({required this.regions, required this.count, required this.offset, required this.limit});

  @override
  List<Object?> get props => [regions, count, offset, limit];
}
