import 'package:flutter/material.dart';

class ActionMenuDirectOverlayWidget extends StatelessWidget {
  const ActionMenuDirectOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey[800],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionItem(Icons.bookmark_border, 'Aggiungi ai preferiti'),
          _buildActionItem(Icons.reply, 'Rispondi'),
          _buildActionItem(Icons.content_copy, 'Copia'),
          _buildActionItem(Icons.push_pin_outlined, 'Fissa'),
          _buildActionItem(Icons.flag_outlined, 'Segnala'),
          _buildActionItem(Icons.delete_outline, 'Elimina'),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
