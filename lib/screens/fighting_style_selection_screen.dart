import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/fighting_style_data.dart';

class FightingStyleSelectionScreen extends StatefulWidget {
  final List<SelectedFightingStyle>? initialSelected;

  const FightingStyleSelectionScreen({super.key, this.initialSelected});

  @override
  State<FightingStyleSelectionScreen> createState() => _FightingStyleSelectionScreenState();
}

class _FightingStyleSelectionScreenState extends State<FightingStyleSelectionScreen> {
  late final Map<String, Set<String>> _selectedStrikes; // styleName -> Set of selected strikes

  @override
  void initState() {
    super.initState();
    _selectedStrikes = {};
    if (widget.initialSelected != null) {
      for (final style in widget.initialSelected!) {
        _selectedStrikes[style.styleName] = Set<String>.from(style.selectedStrikes);
      }
    }
  }

  void _toggleStyle(String styleName) {
    setState(() {
      if (_selectedStrikes.containsKey(styleName)) {
        _selectedStrikes.remove(styleName);
      } else {
        _selectedStrikes[styleName] = {};
      }
    });
  }

  void _toggleStrike(String styleName, String strike) {
    setState(() {
      if (!_selectedStrikes.containsKey(styleName)) {
        _selectedStrikes[styleName] = {};
      }
      if (_selectedStrikes[styleName]!.contains(strike)) {
        _selectedStrikes[styleName]!.remove(strike);
      } else {
        _selectedStrikes[styleName]!.add(strike);
      }
    });
  }

  List<SelectedFightingStyle> _getSelectedStyles() {
    return _selectedStrikes.entries
        .map((entry) => SelectedFightingStyle(
              styleName: entry.key,
              selectedStrikes: entry.value.toList(),
            ))
        .toList();
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
                      'SELECIONE ESTILOS DE LUTA',
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
                itemCount: fightingStyleCatalog.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final style = fightingStyleCatalog.values.elementAt(index);
                  final isStyleSelected = _selectedStrikes.containsKey(style.name);
                  
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      border: Border.all(
                        color: isStyleSelected
                            ? const Color(0xFF5B0A16)
                            : const Color(0xFF5B0A16).withOpacity(0.5),
                        width: isStyleSelected ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cabeçalho do estilo
                        GestureDetector(
                          onTap: () => _toggleStyle(style.name),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    style.name,
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: isStyleSelected
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isStyleSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF5B0A16),
                                    size: 24,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        // Golpes relacionados (se houver e se o estilo estiver selecionado)
                        if (isStyleSelected && style.strikes.isNotEmpty) ...[
                          Container(
                            height: 1,
                            color: const Color(0xFF5B0A16).withOpacity(0.3),
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Golpes relacionados:',
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...style.strikes.map((strike) {
                                  final isStrikeSelected = _selectedStrikes[style.name]?.contains(strike) ?? false;
                                  return GestureDetector(
                                    onTap: () => _toggleStrike(style.name, strike),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 6),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isStrikeSelected
                                            ? const Color(0xFF5B0A16).withOpacity(0.1)
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: isStrikeSelected
                                              ? const Color(0xFF5B0A16)
                                              : const Color(0xFF5B0A16).withOpacity(0.3),
                                          width: isStrikeSelected ? 1.5 : 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              strike,
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: isStrikeSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          if (isStrikeSelected)
                                            const Icon(
                                              Icons.check,
                                              color: Color(0xFF5B0A16),
                                              size: 18,
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_selectedStrikes.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, _getSelectedStyles());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B0A16),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirmar (${_selectedStrikes.length})',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}




