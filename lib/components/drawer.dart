import 'package:application/shared/auth/auth_controller.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DrawerDashboard extends StatelessWidget {
  final String username;
  final bool isAdmin;

  const DrawerDashboard({
    Key? key,
    required this.username,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              username,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
            accountEmail: Text(
              'email@test.com',
              style: TextStyle(
                color: Colors.blueGrey[50],
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                iconSize: 40,
                icon: (isAdmin)
                    ? const Icon(
                        Icons.engineering,
                        color: AppColors.dark,
                      )
                    : const Icon(
                        Icons.face,
                        color: AppColors.dark,
                      ),
                onPressed: () {
                  Navigator.popAndPushNamed(
                    context,
                    '/dashboard',
                    arguments: {
                      'name': username,
                      'isAdmin': isAdmin,
                    },
                  );
                },
              ),
            ),
          ),
          if (isAdmin) ...[
            ListTile(
              title: const Text('Manutenção de Pedidos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Entrega de Pedidos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ] else ...[
            ListTile(
              title: const Text('Comprar'),
              onTap: () {
                Navigator.popAndPushNamed(
                  context,
                  '/purchases-home',
                  arguments: {
                    'name': username,
                    'isAdmin': isAdmin,
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Meus Pedidos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Status de Entrega'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Metodos de pagamento'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          const Divider(
            color: AppColors.dark,
            thickness: 1.0,
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () async {
              Navigator.pop(context);
              await authController.singOut(context);
            },
          ),
        ],
      ),
    );
  }
}
