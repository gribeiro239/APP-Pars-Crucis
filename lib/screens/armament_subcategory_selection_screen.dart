import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/armament_data.dart';

class ArmamentSubcategorySelectionScreen extends StatefulWidget {
  final String category;
  final List<SelectedArmament>? initialSelected;

  const ArmamentSubcategorySelectionScreen({
    super.key,
    required this.category,
    this.initialSelected,
  });

  @override
  State<ArmamentSubcategorySelectionScreen> createState() => _ArmamentSubcategorySelectionScreenState();
}

class _ArmamentSubcategorySelectionScreenState extends State<ArmamentSubcategorySelectionScreen> {
  late final Map<String, Set<String>> _selectedItems; // subcategory -> Set of selected items

  @override
  void initState() {
    super.initState();
    _selectedItems = {};
    if (widget.initialSelected != null) {
      for (final armament in widget.initialSelected!) {
        if (armament.category == widget.category) {
          if (!_selectedItems.containsKey(armament.subcategory)) {
            _selectedItems[armament.subcategory] = {};
          }
          _selectedItems[armament.subcategory]!.add(armament.item);
        }
      }
    }
  }

  void _toggleItem(String subcategory, String item) {
    setState(() {
      if (!_selectedItems.containsKey(subcategory)) {
        _selectedItems[subcategory] = {};
      }
      if (_selectedItems[subcategory]!.contains(item)) {
        _selectedItems[subcategory]!.remove(item);
      } else {
        _selectedItems[subcategory]!.add(item);
      }
    });
  }

  List<SelectedArmament> _getSelectedArmaments() {
    final List<SelectedArmament> result = [];
    _selectedItems.forEach((subcategory, items) {
      for (final item in items) {
        result.add(SelectedArmament(
          category: widget.category,
          subcategory: subcategory,
          item: item,
        ));
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final subcategories = armamentCatalog[widget.category]?.keys.toList() ?? [];

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
                      'SELECIONE ARMAMENTOS',
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
                itemCount: subcategories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final subcategory = subcategories[index];
                  final items = armamentCatalog[widget.category]?[subcategory] ?? [];
                  
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      border: Border.all(
                        color: const Color(0xFF5B0A16),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cabeçalho da subcategoria
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B0A16).withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  subcategory,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF5B0A16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Lista de itens
                        if (items.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Nenhum item disponível',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        else
                          ...items.map((item) {
                            final isSelected = _selectedItems[subcategory]?.contains(item) ?? false;
                            return GestureDetector(
                              onTap: () => _toggleItem(subcategory, item),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF5B0A16).withOpacity(0.1)
                                      : Colors.transparent,
                                  border: Border(
                                    top: BorderSide(
                                      color: const Color(0xFF5B0A16).withOpacity(0.2),
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF5B0A16),
                                        size: 20,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_selectedItems.values.any((items) => items.isNotEmpty))
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
                        Navigator.pop(context, _getSelectedArmaments());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B0A16),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirmar (${_selectedItems.values.fold<int>(0, (sum, items) => sum + items.length)})',
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

