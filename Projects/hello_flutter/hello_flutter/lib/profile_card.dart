import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                child: const Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Maulish Shhah',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.location_on, size: 18, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    'Newcastle upon Tyne',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _IconAction(
                    icon: Icons.message,
                    color: Colors.blueAccent,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  _IconAction(
                    icon: Icons.call,
                    color: Colors.green,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _IconAction({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.12),
      shape: const CircleBorder(),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
        splashRadius: 28,
      ),
    );
  }
}
