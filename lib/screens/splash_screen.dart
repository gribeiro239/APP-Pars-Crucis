import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Widget _bigCardButton({
    required BuildContext context,
    required String imageAsset,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageAsset),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black45,
                BlendMode.darken,
              ),
            ),
          ),
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          child: Text(
            label,
            textAlign: TextAlign.right,
            maxLines: 2,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlineButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) {
    final width = MediaQuery.of(context).size.width * 0.6;
    return SizedBox(
      width: width,
      height: 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF5B0A16), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xFF5B0A16),
          ),
        ),
      ),
    );
  }

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Pars Crucis',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: 48,
                        color: const Color(0xFF5B0A16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Planifase',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: const Color(0xFF5B0A16),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _bigCardButton(
                      context: context,
                      imageAsset: 'assets/images/ilustra_novo.png',
                      label: 'NOVO\nPERSONAGEM',
                      onTap: () => Navigator.pushNamed(context, '/novo'),
                    ),
                    const SizedBox(height: 16),
                    _bigCardButton(
                      context: context,
                      imageAsset: 'assets/images/ilustra_carregar.png',
                      label: 'CARREGAR\nPERSONAGEM',
                      onTap: () => Navigator.pushNamed(context, '/carregar'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    _outlineButton(
                      context: context,
                      text: 'Versão 2.11.3',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    _outlineButton(
                      context: context,
                      text: 'Direitos Autorais',
                      onPressed: () => Navigator.pushNamed(context, '/config'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


