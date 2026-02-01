import 'package:flutter/material.dart';

class BouncyCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const BouncyCard({
    Key? key, 
    required this.child, 
    required this.onPressed
  }) : super(key: key);

  @override
  _BouncyCardState createState() => _BouncyCardState();
}

class _BouncyCardState extends State<BouncyCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Al tocar, reducimos la escala al 95%
      onTapDown: (_) => setState(() => _scale = 0.95),
      
      // Al soltar o cancelar, vuelve al 100%
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        // Pequeño retardo para que se vea la animación antes de navegar
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.onPressed();
        });
      },
      onTapCancel: () => setState(() => _scale = 1.0),

      
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100), // Súper rápido
        curve: Curves.easeInOut, // Suavizado
        child: widget.child,
      ),
    );
  }
}