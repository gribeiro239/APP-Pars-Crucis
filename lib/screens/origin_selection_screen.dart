import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/origin_data.dart';

class OriginSelectionScreen extends StatelessWidget {
  const OriginSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final origins = originCatalog.keys.toList();
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
                    'SELECIONE ORIGEM',
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
                itemCount: origins.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final origin = origins[index];
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push<OriginSelectionResult>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubtypeSelectionScreen(origin: origin),
                        ),
                      );
                      if (result != null) {
                        Navigator.pop(context, result);
                      }
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        border: Border.all(
                          color: const Color(0xFF5B0A16),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        origin,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                        ),
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

class SubtypeSelectionScreen extends StatelessWidget {
  final String origin;
  const SubtypeSelectionScreen({super.key, required this.origin});

  @override
  Widget build(BuildContext context) {
    final subtypes = originCatalog[origin] ?? const [];

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
                  Expanded(
                    child: Text(
                      '${origin.toUpperCase()} — SUBTIPOS',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: subtypes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final subtype = subtypes[index];
                  final summary = _formatModifiers(subtype.modifiers, origin);
                  return GestureDetector(
                    onTap: () => Navigator.pop(
                      context,
                      OriginSelectionResult(origin: origin, subtype: subtype),
                    ),
                    child: Container(
                      height: 72,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        border: Border.all(
                          color: const Color(0xFF5B0A16),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            subtype.name,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            summary,
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
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

String _formatModifiers(Map<String, int> modifiers, String origin) {
  final fis = _fmt(modifiers['FIS']);
  final ref = _fmt(modifiers['REF']);
  final ego = _fmt(modifiers['EGO']);
  final cog = _fmt(modifiers['COG']);
  final esp = _fmt(modifiers['ESP']);
  final mov = _getMovementByOrigin(origin);
  return 'FIS $fis / REF $ref / EGO $ego / COG $cog / ESP $esp / MOV $mov';
}

int _getMovementByOrigin(String originName) {
  switch (originName) {
    case 'Humano':
      return 3;
    case 'Capríaco':
      return 3;
    case 'Carneador':
      return 3;
    case 'Guará':
      return 4;
    case 'Ligno':
      return 3;
    case 'Orcino':
      return 3;
    case 'Quezal':
      return 3;
    default:
      return 0;
  }
}

String _fmt(int? value) {
  final val = value ?? 0;
  if (val > 0) return '+$val';
  return val.toString();
}

