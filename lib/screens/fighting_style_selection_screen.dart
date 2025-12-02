import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/fighting_style_data.dart';
import 'item_selection_screen.dart';

class FightingStyleSelectionScreen extends StatefulWidget {
  final List<SelectedFightingStyle>? initialSelected;
  final int Function()? getAvailableXP; // Função para obter XP disponível
  final bool Function(int xpCost)? canAffordXP; // Função para validar se pode gastar XP

  const FightingStyleSelectionScreen({
    super.key, 
    this.initialSelected,
    this.getAvailableXP,
    this.canAffordXP,
  });

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
        // Validar XP antes de adicionar
        final xpCost = _getXPCost(styleName);
        if (xpCost > 0 && widget.canAffordXP != null && widget.getAvailableXP != null) {
          final availableXP = widget.getAvailableXP!();
          if (!widget.canAffordXP!(xpCost)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('XP insuficiente! Necessário: $xpCost XP, Disponível: $availableXP XP (mínimo: -2 XP)'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }
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
        // Validar XP antes de adicionar
        final xpCost = _getXPCost(strike);
        if (xpCost > 0 && widget.canAffordXP != null && widget.getAvailableXP != null) {
          final availableXP = widget.getAvailableXP!();
          if (!widget.canAffordXP!(xpCost)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('XP insuficiente! Necessário: $xpCost XP, Disponível: $availableXP XP (mínimo: -2 XP)'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }
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
  
  // Calcula o XP total gasto nos estilos e golpes selecionados
  int _calculateTotalXPCost() {
    int total = 0;
    
    // XP dos estilos selecionados
    for (final styleName in _selectedStrikes.keys) {
      final technique = TechniqueCatalog.fightingStyles[styleName];
      if (technique != null) {
        total += technique.xpCost;
      }
    }
    
    // XP dos golpes selecionados
    for (final entry in _selectedStrikes.entries) {
      for (final strike in entry.value) {
        final technique = TechniqueCatalog.fightingStyles[strike];
        if (technique != null) {
          total += technique.xpCost;
        }
      }
    }
    
    return total;
  }
  
  // Obtém o custo de XP de um estilo ou golpe
  int _getXPCost(String name) {
    final technique = TechniqueCatalog.fightingStyles[name];
    return technique?.xpCost ?? 0;
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        style.name,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: isStyleSelected
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      // Mostrar custo de XP se disponível
                                      if (TechniqueCatalog.fightingStyles.containsKey(style.name))
                                        Text(
                                          'Custo: ${TechniqueCatalog.fightingStyles[style.name]!.xpCost} XP',
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                    ],
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
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  strike,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: isStrikeSelected
                                                        ? FontWeight.w600
                                                        : FontWeight.normal,
                                                  ),
                                                ),
                                                // Mostrar custo de XP se disponível
                                                if (TechniqueCatalog.fightingStyles.containsKey(strike))
                                                  Text(
                                                    'Custo: ${TechniqueCatalog.fightingStyles[strike]!.xpCost} XP',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 11,
                                                      color: Colors.grey[600],
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                              ],
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Confirmar (${_selectedStrikes.length})',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          if (_calculateTotalXPCost() > 0)
                            Text(
                              'Total: ${_calculateTotalXPCost()} XP',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                        ],
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




