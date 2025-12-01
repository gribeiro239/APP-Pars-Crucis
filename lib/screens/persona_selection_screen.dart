import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonaSelectionScreen extends StatelessWidget {
  const PersonaSelectionScreen({super.key});

  static const List<String> personas = [
    'Aventureiro',
    'Itinerante',
    'Escolar',
    'Sábio',
    'Escultor',
    'Visionário',
    'Curador',
    'Protetor',
    'Vanguarda',
    'Arauto',
    'Assecla',
    'Dominador',
    'Juiz',
    'Perscrutor',
    'Herege',
    'Destruidor',
    'Mártir',
    'Zelote',
    'Ascendente',
    'Grandioso',
    'Perdulário',
    'Ermitão',
    'Usurpador',
    'Quebrado',
    'Mentecapto',
    'Miríada',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/textura_pergaminho.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                right: 16,
                bottom: 12,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SELECIONE PERSONA',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: personas.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, i) {
                  final persona = personas[i];
                  return GestureDetector(
                    onTap: () => Navigator.pop(context, persona),
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        border: Border.all(
                            color: const Color(0xFF5B0A16), width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        persona,
                        style: GoogleFonts.roboto(
                            fontSize: 16, color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


