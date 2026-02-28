class CalculationUtils {
  static const double cementBagVolumeM3 = 0.035;

  static Map<String, double> concreteMaterials({
    required double volumeM3,
    required String grade,
  }) {
    const gradeRatios = {
      'M15': [1.0, 2.0, 4.0],
      'M20': [1.0, 1.5, 3.0],
      'M25': [1.0, 1.0, 2.0],
    };

    final ratio = gradeRatios[grade] ?? gradeRatios['M20']!;
    final totalParts = ratio.reduce((a, b) => a + b);

    final dryVolume = volumeM3 * 1.54;
    final cementM3 = (ratio[0] / totalParts) * dryVolume;
    final sandM3 = (ratio[1] / totalParts) * dryVolume;
    final aggregateM3 = (ratio[2] / totalParts) * dryVolume;

    return {
      'cementBags': cementM3 / cementBagVolumeM3,
      'sandM3': sandM3,
      'aggregateM3': aggregateM3,
    };
  }

  static Map<String, double> brickMaterials({
    required double wallLengthM,
    required double wallHeightM,
    required double wallThicknessM,
    required double brickLengthM,
    required double brickWidthM,
    required double brickHeightM,
    required String mortarRatio,
  }) {
    final wallVolume = wallLengthM * wallHeightM * wallThicknessM;

    final brickVolumeWithMortar =
        (brickLengthM + 0.01) * (brickWidthM + 0.01) * (brickHeightM + 0.01);
    final bricks = wallVolume / brickVolumeWithMortar;

    final netBrickVolume = bricks * (brickLengthM * brickWidthM * brickHeightM);
    final mortarVolumeWet = wallVolume - netBrickVolume;
    final mortarVolumeDry = mortarVolumeWet * 1.33;

    final parts = mortarRatio.split(':').map((e) => double.parse(e)).toList();
    final totalParts = parts[0] + parts[1];
    final cementM3 = (parts[0] / totalParts) * mortarVolumeDry;
    final sandM3 = (parts[1] / totalParts) * mortarVolumeDry;

    return {
      'bricks': bricks,
      'cementBags': cementM3 / cementBagVolumeM3,
      'sandM3': sandM3,
    };
  }

  static double steelWeightKg({
    required double diameterMm,
    required double lengthM,
    required int bars,
  }) {
    return (diameterMm * diameterMm / 162.0) * lengthM * bars;
  }

  static Map<String, double> plasterMaterials({
    required double areaM2,
    required double thicknessMm,
    String ratio = '1:6',
  }) {
    final wetVolume = areaM2 * (thicknessMm / 1000.0);
    final dryVolume = wetVolume * 1.33;

    final parts = ratio.split(':').map((e) => double.parse(e)).toList();
    final totalParts = parts[0] + parts[1];

    final cementM3 = (parts[0] / totalParts) * dryVolume;
    final sandM3 = (parts[1] / totalParts) * dryVolume;

    return {
      'cementBags': cementM3 / cementBagVolumeM3,
      'sandM3': sandM3,
    };
  }

  static int tileCount({
    required double floorLengthM,
    required double floorWidthM,
    required double tileLengthM,
    required double tileWidthM,
    double wastagePercent = 10,
  }) {
    final floorArea = floorLengthM * floorWidthM;
    final tileArea = tileLengthM * tileWidthM;
    final rawCount = floorArea / tileArea;
    return (rawCount * (1 + wastagePercent / 100)).ceil();
  }
}
