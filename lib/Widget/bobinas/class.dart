class BobinaData {
  final int avanceDiario;
  final String fecha;
  final int meta;
  final String np;

  BobinaData({
    required this.avanceDiario,
    required this.fecha,
    required this.meta,
    required this.np,
  });

  factory BobinaData.fromMap(Map<String, dynamic> map) {
    return BobinaData(
      avanceDiario: map['avancediario'],
      fecha: map['fecha'],
      meta: map['meta'],
      np: map['np'],
    );
  }
}

class ChartData {
  final DateTime x;
  final double y;

  ChartData({required this.x, required this.y});
}
