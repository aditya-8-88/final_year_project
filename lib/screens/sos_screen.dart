import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/sos_service.dart';
import '../config/constants.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> with TickerProviderStateMixin {
  List<SosContact> _contacts = [];
  String _message = AppConstants.sosDefaultMessage;
  bool _loading = true;
  bool _sending = false;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _load();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final contacts = await SosService.getContacts();
    final message = await SosService.getMessage();
    if (mounted) {
      setState(() {
        _contacts = contacts;
        _message = message;
        _loading = false;
      });
    }
  }

  // ── SOS button ──────────────────────────────────────────────────────────

  Future<void> _triggerSos() async {
    if (_sending) return;

    // Confirm before sending
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Send SOS Alert?'),
          ],
        ),
        content: Text(
          _contacts.isEmpty
              ? 'No emergency contacts added yet. Add contacts first.'
              : 'This will send an emergency SMS to ${_contacts.length} contact${_contacts.length > 1 ? 's' : ''} immediately.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          if (_contacts.isNotEmpty)
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Send SOS'),
            ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _sending = true);

    // Request SMS permission if on native Android and not yet granted
    if (!kIsWeb) {
      final hasPermission = await SosService.hasSmsPermission();
      if (!hasPermission) {
        await SosService.requestSmsPermission();
        // Give user a moment to respond to system dialog, then try
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    final result = await SosService.sendSos();
    if (!mounted) return;
    setState(() => _sending = false);

    switch (result) {
      case SosLaunchResult.success:
        _showSnack('Emergency SMS sent to all contacts!', Colors.green);
      case SosLaunchResult.noContacts:
        _showSnack('Add at least one emergency contact first', Colors.orange);
      case SosLaunchResult.appNotFound:
        _showSnack('Could not send SMS on this device', Colors.red);
      case SosLaunchResult.permissionDenied:
        _showSnack('SMS permission denied — please grant it in Settings', Colors.red);
      case SosLaunchResult.notSupported:
        _showSnack('SOS SMS is not supported on this device', Colors.orange);
    }
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ── Add contact dialog ──────────────────────────────────────────────────

  Future<void> _showAddContactDialog() async {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneCtrl,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+919876543210',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Enter a number';
                  final digits = v.replaceAll(RegExp(r'[^\d]'), '');
                  if (digits.length < 7) return 'Enter a valid number';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              final contact = SosContact(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
              );
              await SosService.addContact(contact);
              if (ctx.mounted) Navigator.pop(ctx);
              await _load();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // ── Edit SOS message dialog ─────────────────────────────────────────────

  Future<void> _showEditMessageDialog() async {
    final ctrl = TextEditingController(text: _message);

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit SOS Message'),
        content: TextField(
          controller: ctrl,
          maxLines: 5,
          maxLength: 320,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type your emergency message…',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await SosService.saveMessage(AppConstants.sosDefaultMessage);
              if (ctx.mounted) Navigator.pop(ctx);
              await _load();
            },
            child: const Text('Reset Default'),
          ),
          FilledButton(
            onPressed: () async {
              final msg = ctrl.text.trim();
              if (msg.isEmpty) return;
              await SosService.saveMessage(msg);
              if (ctx.mounted) Navigator.pop(ctx);
              await _load();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emergency_rounded, color: Colors.red, size: 22),
            SizedBox(width: 8),
            Text('SOS Emergency'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_ic_call_outlined),
            tooltip: 'Add emergency contact',
            onPressed: _showAddContactDialog,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Info banner ─────────────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline,
                                color: Colors.red, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Pressing SOS opens your SMS app with all emergency contacts and your message pre-filled. Tap Send once to alert everyone.',
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      // ── SOS Button ──────────────────────────────────────
                      Center(
                        child: ScaleTransition(
                          scale: _pulseAnim,
                          child: GestureDetector(
                            onTap: _triggerSos,
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.45),
                                    blurRadius: 30,
                                    spreadRadius: 6,
                                  ),
                                ],
                              ),
                              child: _sending
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.emergency_rounded,
                                          color: Colors.white,
                                          size: 52,
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          'SOS',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Tap to send emergency alert',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.red.shade400),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // ── SOS Message ─────────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SOS Message',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.edit_outlined, size: 16),
                            label: const Text('Edit'),
                            onPressed: _showEditMessageDialog,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Text(
                          _message,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Emergency Contacts ──────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Emergency Contacts (${_contacts.length})',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          FilledButton.tonal(
                            onPressed: _showAddContactDialog,
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 18),
                                SizedBox(width: 4),
                                Text('Add'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (_contacts.isEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.contacts_outlined,
                                size: 48,
                                color: theme.colorScheme.outline,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No emergency contacts yet',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Add trusted contacts — family or friends — who should receive your SOS alert.',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _contacts.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (ctx, i) {
                            final c = _contacts[i];
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: theme.colorScheme.outlineVariant,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundColor:
                                    Colors.red.withOpacity(0.12),
                                child: Text(
                                  c.name.isNotEmpty
                                      ? c.name[0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(c.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(c.phone),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                tooltip: 'Remove contact',
                                onPressed: () async {
                                  final yes = await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('Remove Contact?'),
                                      content: Text(
                                          'Remove ${c.name} from emergency contacts?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, true),
                                          child: const Text('Remove',
                                              style: TextStyle(
                                                  color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (yes == true) {
                                    await SosService.removeContact(c.id);
                                    await _load();
                                  }
                                },
                              ),
                            );
                          },
                        ),

                      const SizedBox(height: 24),

                      // ── Disclaimer ──────────────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.shield_outlined,
                                size: 18,
                                color: theme.colorScheme.onSurfaceVariant),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Privacy: All emergency contacts and your SOS message are stored only on this device. No data is sent to any server. The SOS button opens your phone\'s native SMS app — you control when to send.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
