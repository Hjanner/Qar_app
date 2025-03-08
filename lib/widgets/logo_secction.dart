import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    './assets/imagenes/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              'Qar App',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}