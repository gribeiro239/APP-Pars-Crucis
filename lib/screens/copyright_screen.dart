import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CopyrightScreen extends StatelessWidget {
  const CopyrightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Direitos Autorais',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5B0A16),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/textura_pergaminho.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildParagraph(
                  'Se você está acessando este aplicativo e o conteúdo do sistema Pars Crucis, isso significa que eu, ou o autor ou alguém próximo a nós lhe concedeu acesso direto a este material.',
                ),
                const SizedBox(height: 16),
                _buildParagraph(
                  'Antes de repassar qualquer parte deste conteúdo para outras pessoas, peço que entre em contato comigo, com o autor ou com quem lhe forneceu o material originalmente.',
                ),
                const SizedBox(height: 24),
                _buildParagraph(
                  'Este é um projeto em constante desenvolvimento. Muitas das ideias, conceitos e elementos apresentados aqui são originais e constituem propriedade intelectual de Ismael A. A. Correia.',
                ),
                const SizedBox(height: 16),
                _buildParagraph(
                  'Obtive a permissão do autor para desenvolver este aplicativo como forma de aprimorar minhas habilidades de programação.',
                ),
                const SizedBox(height: 24),
                _buildParagraph(
                  'Se você tiver interesse em saber mais sobre o sistema, o cenário ou quiser colaborar de alguma forma com o desenvolvimento, sinta-se à vontade para contatar o autor pelo e-mail indicado ao final deste aviso.',
                ),
                const SizedBox(height: 24),
                _buildParagraph(
                  'Observação: a capa e os brasões culturais são de autoria de Ismael A. A. Correia. As demais imagens utilizadas não são de minha autoria e estão presentes apenas como representação visual aproximada e podem ou não ter seus direitos autorais reservados.',
                ),
                const SizedBox(height: 24),
                _buildParagraph(
                  'Sob nenhuma circunstância esse material pode ser comercializado. Assim como publicado sem autorização.',
                ),
                const SizedBox(height: 24),
                _buildParagraph(
                  'Se você leu este aviso até aqui, agradeço pelo interesse e espero que você aproveite a experiência, o conteúdo e o mundo de Pars Crucis.',
                ),
                const SizedBox(height: 24),
                _buildParagraph(
                  'Em caso de qualquer bug ou comportamento inesperado no aplicativo, por favor, entre em contato comigo pelo e-mail abaixo.',
                ),
                const SizedBox(height: 32),
                _buildAuthorSection(),
                const SizedBox(height: 24),
                _buildSectionTitle('Desenvolvedor do Aplicativo'),
                const SizedBox(height: 8),
                _buildName('Guilherme A. M. L. Ribeiro'),
                const SizedBox(height: 4),
                _buildEmailDev('gribeiro239@gmail.com'),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 16,
        color: const Color(0xFF2F1B10),
        height: 1.6,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF5B0A16),
      ),
    );
  }

  Widget _buildName(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF2F1B10),
      ),
    );
  }

  Widget _buildEmail(String text) {
    return Text(
      'e-mail: $text',
      style: GoogleFonts.roboto(
        fontSize: 15,
        color: const Color(0xFF2F1B10),
      ),
    );
  }

  Widget _buildEmailDev(String text) {
    return Text(
      'e-mail: $text',
      style: GoogleFonts.roboto(
        fontSize: 15,
        color: const Color(0xFF2F1B10),
      ),
    );
  }

  Widget _buildAuthorSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagem circular à esquerda
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF5B0A16),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/img_isma.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 50),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Texto à direita
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Autor do sistema'),
              const SizedBox(height: 8),
              _buildName('Ismael A. A. Correia'),
              const SizedBox(height: 4),
              _buildEmail('ismaeavilacorreia@gmail.com'),
            ],
          ),
        ),
      ],
    );
  }
}

