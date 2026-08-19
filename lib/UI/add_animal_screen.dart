import 'package:biotox_admin/UI/widgets/show_image_selecter.dart';
import 'package:flutter/material.dart';

/// Pantalla "Agregar Especie" de BIOTOX.
/// Usa widgets reales de formulario (TextField, DropdownButton, etc.)
/// pero SIN controllers, SIN onChanged funcional y SIN estado:
/// todo está listo para que se le agregue la lógica después.
class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({super.key});

  static const Color kBackground = Color(0xFF0B0F0A);
  static const Color kAccent = Color(0xFFCFFF3D); // verde lima
  static const Color kFieldBackground = Color(0xFF161C13);
  static const Color kFieldBorder = Color(0xFF262E1E);

  static const Color kBajoColor = Color(0xFF3DDC5B);
  static const Color kMedioColor = Color(0xFFE8A93A);
  static const Color kAltoColor = Color(0xFFE23B3B);

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('AGREGAR ESPECIE'), centerTitle: true),

      body: Center(
        child: SizedBox(
          width: screenWidth < 600 ? double.maxFinite : 600,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildPhotoUploadBox(),
                      const SizedBox(height: 24),
                      _buildFieldLabel('NOMBRE CIENTÍFICO'),
                      const SizedBox(height: 8),
                      _buildTextField(hint: 'Ej: Bothrops asper'),
                      const SizedBox(height: 20),
                      _buildFieldLabel('NOMBRE COMÚN'),
                      const SizedBox(height: 8),
                      _buildTextField(hint: 'Ej: Terciopelo'),
                      const SizedBox(height: 20),
                      _buildFieldLabel('NIVEL DE PELIGRO'),
                      const SizedBox(height: 8),
                      _buildDangerLevelSelector(),
                      const SizedBox(height: 20),
                      _buildFieldLabel('TIPO DE VENENO'),
                      const SizedBox(height: 8),
                      _buildVenomDropdown(),
                      const SizedBox(height: 20),
                      _buildFieldLabel('DISTRIBUCIÓN GEOGRÁFICA'),
                      const SizedBox(height: 8),
                      _buildTextField(hint: 'Ej: Centro y Sudamérica'),
                      const SizedBox(height: 20),
                      _buildFieldLabel('SÍNTOMAS'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hint: 'Describir síntomas de envenenamiento...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildFieldLabel('TRATAMIENTO / ANTÍDOTO'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hint: 'Protocolo de emergencia y antisuero...',
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              _buildSaveButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---- Caja de subida de foto con borde punteado ----
  Widget _buildPhotoUploadBox() {
    return CustomPaint(
      painter: _DashedBorderPainter(color: AddAnimalScreen.kAccent, radius: 16),
      child: InkWell(
        // Sin lógica: solo deja el widget listo para conectar un image picker.
        onTap: () async {
          await showImageSelecter(context);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 180,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AddAnimalScreen.kAccent.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AddAnimalScreen.kAccent,
                  size: 24,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Subir foto de la especie',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Toca para seleccionar imagen',
                style: TextStyle(color: Colors.white38, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---- Etiqueta de campo ----
  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AddAnimalScreen.kAccent,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  // ---- TextField real, sin controller ni onChanged ----
  Widget _buildTextField({required String hint, int maxLines = 1}) {
    return TextField(
      // Sin controller: listo para conectar un TextEditingController después.
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 14.5),
      cursorColor: AddAnimalScreen.kAccent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white30, fontSize: 14),
        filled: true,
        fillColor: AddAnimalScreen.kFieldBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AddAnimalScreen.kFieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AddAnimalScreen.kFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AddAnimalScreen.kAccent),
        ),
      ),
    );
  }

  // ---- Selector de nivel de peligro (3 botones tipo segmented) ----
  Widget _buildDangerLevelSelector() {
    return Row(
      children: [
        Expanded(
          child: _dangerOption(
            'BAJO',
            AddAnimalScreen.kBajoColor,
            selected: false,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _dangerOption(
            'MEDIO',
            AddAnimalScreen.kMedioColor,
            selected: false,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _dangerOption(
            'ALTO',
            AddAnimalScreen.kAltoColor,
            selected: true,
          ),
        ),
      ],
    );
  }

  Widget _dangerOption(String label, Color color, {required bool selected}) {
    return InkWell(
      // Sin lógica: listo para envolver en un StatefulWidget y manejar selección.
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? color : AddAnimalScreen.kFieldBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : AddAnimalScreen.kFieldBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ---- Dropdown real de tipo de veneno ----
  Widget _buildVenomDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AddAnimalScreen.kFieldBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AddAnimalScreen.kFieldBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'Hemotóxico',
          isExpanded: true,
          dropdownColor: AddAnimalScreen.kFieldBackground,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AddAnimalScreen.kAccent,
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14.5),
          // Sin lógica: onChanged vacío, listo para conectar un StatefulWidget.
          onChanged: (_) {},
          items: const [
            DropdownMenuItem(value: 'Hemotóxico', child: Text('Hemotóxico')),
            DropdownMenuItem(value: 'Neurotóxico', child: Text('Neurotóxico')),
            DropdownMenuItem(value: 'Citotóxico', child: Text('Citotóxico')),
            DropdownMenuItem(value: 'Miotóxico', child: Text('Miotóxico')),
          ],
        ),
      ),
    );
  }

  // ---- Botón "Guardar especie" ----
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        // Sin lógica: onPressed vacío, listo para conectar el submit del form.
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AddAnimalScreen.kAccent,
          padding: const EdgeInsets.symmetric(vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 6,
          shadowColor: AddAnimalScreen.kAccent.withOpacity(0.5),
        ),
        child: const Text(
          'GUARDAR ESPECIE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

/// Painter para dibujar un borde punteado alrededor de un contenedor.
/// Puramente visual, no contiene lógica de negocio.
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.color,
    this.radius = 12,
    this.dashWidth = 6,
    this.dashSpace = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final dashedPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        dashedPath.addPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          Offset.zero,
        );
        distance = next + dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => false;
}
