import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _telefonoCtrl.dispose();
    _direccionCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final success = await ref
        .read(authProvider.notifier)
        .actualizarUsuario(
          nombre: _nombreCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          telefono: _telefonoCtrl.text.trim(),
          direccion: _direccionCtrl.text.trim(),
        );

    setState(() {
      _isSaving = false;
    });

    if (!mounted) return;

    if (success) {
      setState(() => _isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado'),
          backgroundColor: Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      final error = ref.read(authProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error actualizando el perfil'),
          backgroundColor: CicloxColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showChangePassword() {
    final _actualCtrl = TextEditingController();
    final _nuevaCtrl = TextEditingController();
    final _formKey2 = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CicloxColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: _formKey2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: CicloxColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Cambiar contraseña',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 20),
              _EditField(
                label: 'Contraseña actual',
                controller: _actualCtrl,
                isPassword: true,
              ),
              const SizedBox(height: 14),
              _EditField(
                label: 'Nueva contraseña',
                controller: _nuevaCtrl,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        side: const BorderSide(color: CicloxColors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey2.currentState!.validate()) {
                          final auth = ref.read(authProvider);
                          final success = await ref
                              .read(authProvider.notifier)
                              .cambiarContrasena(
                                email: auth.email!,
                                contrasenaActual: _actualCtrl.text,
                                contrasenaNueva: _nuevaCtrl.text,
                              );
                          if (success) {
                            Navigator.pop(context);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Contraseña cambiada exitosamente',
                                  ),
                                  backgroundColor: Color(0xFF4CAF50),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          } else {
                            // El error ya se maneja en el provider
                            final error = ref.read(authProvider).error;
                            if (mounted && error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: $error'),
                                  backgroundColor: CicloxColors.error,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CicloxColors.primary,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmSignOut() {
    showModalBottomSheet(
      context: context,
      backgroundColor: CicloxColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: CicloxColors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CicloxColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: CicloxColors.error,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '¿Cerrar sesión?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: CicloxColors.dark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tendrás que iniciar sesión nuevamente',
              style: TextStyle(color: CicloxColors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      side: const BorderSide(color: CicloxColors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: CicloxColors.dark),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await ref.read(authProvider.notifier).signOut();
                      if (context.mounted) context.go(AppRoutes.login);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CicloxColors.error,
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Cerrar sesión',
                      style: TextStyle(color: CicloxColors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final newNombre = auth.nombre ?? '';
    final newEmail = auth.email ?? '';
    final newTelefono = auth.telefono ?? '';
    final newDireccion = auth.direccion ?? '';

    if (!_isEditing &&
        (_nombreCtrl.text != newNombre ||
            _emailCtrl.text != newEmail ||
            _telefonoCtrl.text != newTelefono ||
            _direccionCtrl.text != newDireccion)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _isEditing) return;
        _nombreCtrl.text = newNombre;
        _emailCtrl.text = newEmail;
        _telefonoCtrl.text = newTelefono;
        _direccionCtrl.text = newDireccion;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Mi perfil',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: CicloxColors.dark,
                        ),
                      ),
                    ),
                    if (!_isEditing)
                      GestureDetector(
                        onTap: () => setState(() => _isEditing = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: CicloxColors.dark,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.edit_rounded,
                                color: CicloxColors.primary,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Editar',
                                style: TextStyle(
                                  color: CicloxColors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () => setState(() => _isEditing = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: CicloxColors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: CicloxColors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Avatar + nombre
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: CicloxColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 84,
                            height: 84,
                            decoration: BoxDecoration(
                              color: CicloxColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: CicloxColors.primary,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: CicloxColors.dark,
                              size: 48,
                            ),
                          ),
                          if (_isEditing)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: CicloxColors.dark,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: CicloxColors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: CicloxColors.primary,
                                  size: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        _nombreCtrl.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: CicloxColors.dark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _emailCtrl.text,
                        style: const TextStyle(
                          fontSize: 13,
                          color: CicloxColors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: CicloxColors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'CIUDADANO',
                          style: TextStyle(
                            color: CicloxColors.dark,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Formulario edición
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: CicloxColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información personal',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: CicloxColors.dark,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _EditField(
                          label: 'Nombre completo',
                          controller: _nombreCtrl,
                          icon: Icons.person_outline,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 14),
                        _EditField(
                          label: 'Correo electrónico',
                          controller: _emailCtrl,
                          icon: Icons.email_outlined,
                          enabled: false, // email no editable
                          hint: 'No se puede cambiar el correo',
                        ),
                        const SizedBox(height: 14),
                        _EditField(
                          label: 'Teléfono',
                          controller: _telefonoCtrl,
                          icon: Icons.phone_outlined,
                          enabled: _isEditing,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 14),
                        _EditField(
                          label: 'Dirección',
                          controller: _direccionCtrl,
                          icon: Icons.location_on_outlined,
                          enabled: _isEditing,
                        ),
                        if (_isEditing) ...[
                          const SizedBox(height: 20),
                          _isSaving
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: CicloxColors.primary,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: _saveChanges,
                                  child: const Text('Guardar cambios'),
                                ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Opciones de cuenta
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: CicloxColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cuenta',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: CicloxColors.dark,
                            ),
                          ),
                        ),
                      ),
                      _OptionTile(
                        icon: Icons.lock_outline_rounded,
                        label: 'Cambiar contraseña',
                        onTap: _showChangePassword,
                      ),
                      _OptionTile(
                        icon: Icons.notifications_outlined,
                        label: 'Notificaciones',
                        onTap: () {},
                      ),
                      _OptionTile(
                        icon: Icons.help_outline_rounded,
                        label: 'Ayuda y soporte',
                        onTap: () {},
                      ),
                      _OptionTile(
                        icon: Icons.logout_rounded,
                        label: 'Cerrar sesión',
                        onTap: _confirmSignOut,
                        isDestructive: true,
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

class _EditField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final bool isPassword;
  final IconData? icon;
  final String? hint;
  final TextInputType keyboardType;

  const _EditField({
    required this.label,
    required this.controller,
    this.enabled = true,
    this.isPassword = false,
    this.icon,
    this.hint,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<_EditField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: CicloxColors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: widget.enabled ? CicloxColors.dark : CicloxColors.grey,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    size: 18,
                    color: widget.enabled
                        ? CicloxColors.dark
                        : CicloxColors.grey,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      size: 18,
                      color: CicloxColors.grey,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
            filled: true,
            fillColor: widget.enabled
                ? const Color(0xFFF4F6F8)
                : CicloxColors.grey.withOpacity(0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: CicloxColors.primary,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool showDivider;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? CicloxColors.error : CicloxColors.dark;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: CicloxColors.grey.withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: CicloxColors.grey.withOpacity(0.1),
          ),
      ],
    );
  }
}
