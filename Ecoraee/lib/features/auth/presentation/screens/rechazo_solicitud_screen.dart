import 'package:flutter/material.dart';

class RechazoSolicitudDialog extends StatelessWidget {
  const RechazoSolicitudDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFF130E2E), // Azul muy oscuro (Ciclox dark)
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. LOGO
            Image.asset(
              'assets/imagenes/LOGO PRINCIPAL VERDE.png',
              height: 80,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.bolt,
                color: Color(0xFFB2F333),
                size: 60,
              ),
            ),
            const SizedBox(height: 30),

            // 2. TÍTULO
            const Text(
              'MOTIVO DE RECHAZO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 25),

            // 3. OPCIONES DE RECHAZO (Checkboxes)
            const _RechazoOption(label: 'xxxxxxxxxxxx'),
            const _RechazoOption(label: 'xxxxxxxxxxxx'),
            const _RechazoOption(label: 'xxxxxxxxxxxx'),
            const _RechazoOption(label: 'xxxxxxxxxxxx'),
            const SizedBox(height: 25),

            // 4. TEXTO ADICIONAL (Placeholder)
            Text(
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
                height: 1.4,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 35),

            // 5. BOTÓN ENVIAR
            SizedBox(
              width: 180,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8F2D9), // Color clarito de la imagen
                  foregroundColor: const Color(0xFF130E2E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'ENVIAR',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RechazoOption extends StatefulWidget {
  final String label;
  const _RechazoOption({required this.label});

  @override
  State<_RechazoOption> createState() => _RechazoOptionState();
}

class _RechazoOptionState extends State<_RechazoOption> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => _isSelected = !_isSelected),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                color: _isSelected ? const Color(0xFFB2F333) : Colors.transparent,
              ),
              child: _isSelected
                  ? const Icon(Icons.check, size: 16, color: Color(0xFF130E2E))
                  : null,
            ),
            const SizedBox(width: 15),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
