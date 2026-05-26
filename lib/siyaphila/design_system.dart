import 'package:flutter/material.dart';

class DemoTheme {
  static const background = Color(0xFFF3F6FB);
  static const surface = Colors.white;
  static const ink = Color(0xFF132238);
  static const secondary = Color(0xFF6C7892);
  static const blue = Color(0xFF2F6BFF);
  static const violet = Color(0xFF7A63FF);
  static const mint = Color(0xFF35C98A);
  static const amber = Color(0xFFFFB648);
  static const coral = Color(0xFFFF7A59);
}

class SurfaceCard extends StatelessWidget {
  final Widget child;
  const SurfaceCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DemoTheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 18, offset: const Offset(0,14))],
      ),
      child: child,
    );
  }
}

class GradientHeroCard extends StatelessWidget {
  final List<Color> colors;
  final Widget child;
  const GradientHeroCard({Key? key, required this.colors, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [BoxShadow(color: colors.first.withOpacity(0.24), blurRadius: 24, offset: const Offset(0,16))],
      ),
      child: child,
    );
  }
}

class StatusChip extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  const StatusChip({Key? key, required this.title, required this.color, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(24)),
      child: Row(children: [Icon(icon, size: 14, color: color), const SizedBox(width:8), Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12))]),
    );
  }
}

class ProgressRing extends StatelessWidget {
  final String title;
  final int value;
  final Color tint;
  const ProgressRing({Key? key, required this.title, required this.value, required this.tint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = (value.clamp(0,100)) / 100.0;
    return Column(children: [
      SizedBox(
        width: 102,
        height: 102,
        child: Stack(alignment: Alignment.center, children: [
          CircularProgressIndicator(value: 1.0, color: tint.withOpacity(0.14), strokeWidth: 14),
          CircularProgressIndicator(value: progress, color: tint, strokeWidth: 14),
          Column(mainAxisSize: MainAxisSize.min, children: [Text('$value%', style: const TextStyle(fontWeight: FontWeight.w700)), Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12))])
        ]),
      )
    ]);
  }
}

class MetricTile extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color tint;
  final IconData icon;
  const MetricTile({Key? key, required this.title, required this.value, required this.subtitle, required this.tint, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: tint.withOpacity(0.1), borderRadius: BorderRadius.circular(24)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, color: Colors.black54, size: 14), const SizedBox(width:8), Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54))]),
        const SizedBox(height:8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),
        const SizedBox(height:4),
        Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black45))
      ]),
    );
  }
}
