import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/armament_data.dart';

class ArmamentItemSelectionScreen extends StatefulWidget {
  final String category;
  final String subcategory;
  final List<SelectedArmament>? initialSelected;

  const ArmamentItemSelectionScreen({
    super.key,
    required this.category,
    required this.subcategory,
    this.initialSelected,
  });

  @override
  State<ArmamentItemSelectionScreen> createState() => _ArmamentItemSelectionScreenState();
}

class _ArmamentItemSelectionScreenState extends State<ArmamentItemSelectionScreen> {
  late final Set<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = {};
    if (widget.initialSelected != null) {
      for (final armament in widget.initialSelected!) {
        if (armament.category == widget.category && 
            armament.subcategory == widget.subcategory) {
          _selectedItems.add(armament.item);
        }
      }
    }
  }

  List<String> get _availableItems {
    return armamentCatalog[widget.category]?[widget.subcategory] ?? [];
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
                      'SELECIONE ARMAMENTO',
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
              child: _availableItems.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum item disponível nesta categoria',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: _availableItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final item = _availableItems[index];
                        final isSelected = _selectedItems.contains(item);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedItems.remove(item);
                              } else {
                                _selectedItems.add(item);
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
                                    item,
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
            if (_selectedItems.isNotEmpty)
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
                        final selectedArmaments = _selectedItems.map((item) {
                          return SelectedArmament(
                            category: widget.category,
                            subcategory: widget.subcategory,
                            item: item,
                          );
                        }).toList();
                        Navigator.pop(context, selectedArmaments);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B0A16),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirmar (${_selectedItems.length})',
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



