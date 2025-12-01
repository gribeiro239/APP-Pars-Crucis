import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/power_data.dart';

class PowerSelectionScreen extends StatefulWidget {
  final String category;
  final String dativa;
  final List<SelectedPower>? initialSelected;

  const PowerSelectionScreen({
    super.key,
    required this.category,
    required this.dativa,
    this.initialSelected,
  });

  @override
  State<PowerSelectionScreen> createState() => _PowerSelectionScreenState();
}

class _PowerSelectionScreenState extends State<PowerSelectionScreen> {
  late final Set<String> _selectedPowers;

  @override
  void initState() {
    super.initState();
    // Inicializa com os poderes já selecionados desta dádiva
    _selectedPowers = widget.initialSelected != null
        ? widget.initialSelected!
            .where((p) => p.category == widget.category && p.dativa == widget.dativa)
            .map((p) => p.power)
            .toSet()
        : <String>{};
  }

  List<String> get _availablePowers {
    final categoryData = powerCatalog[widget.category];
    if (categoryData == null) return [];

    final dativa = categoryData.dativas.firstWhere(
      (d) => d.name == widget.dativa,
      orElse: () => const PowerDativa(name: '', powers: []),
    );

    return dativa.powers;
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
                      widget.dativa.toUpperCase(),
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: _availablePowers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final power = _availablePowers[index];
                  final isSelected = _selectedPowers.contains(power);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedPowers.remove(power);
                        } else {
                          _selectedPowers.add(power);
                        }
                      });
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF5B0A16).withOpacity(0.2)
                            : Colors.white.withOpacity(0.9),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF5B0A16)
                              : const Color(0xFF5B0A16),
                          width: isSelected ? 2 : 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              power,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF5B0A16),
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_selectedPowers.isNotEmpty)
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
                        // Retorna lista de SelectedPower
                        final selected = _selectedPowers.map((power) {
                          return SelectedPower(
                            category: widget.category,
                            dativa: widget.dativa,
                            power: power,
                          );
                        }).toList();
                        Navigator.pop(context, selected);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B0A16),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirmar (${_selectedPowers.length})',
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





