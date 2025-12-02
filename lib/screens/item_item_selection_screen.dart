import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/item_data.dart';

class ItemItemSelectionScreen extends StatefulWidget {
  final String category;
  final List<SelectedItem>? initialSelected;

  const ItemItemSelectionScreen({
    super.key,
    required this.category,
    this.initialSelected,
  });

  @override
  State<ItemItemSelectionScreen> createState() => _ItemItemSelectionScreenState();
}

class _ItemItemSelectionScreenState extends State<ItemItemSelectionScreen> {
  late final Map<String, int> _selectedItems; // item -> quantidade

  @override
  void initState() {
    super.initState();
    // Inicializa com os itens já selecionados desta categoria
    _selectedItems = {};
    if (widget.initialSelected != null) {
      for (final item in widget.initialSelected!) {
        if (item.category == widget.category) {
          _selectedItems[item.item] = item.quantity;
        }
      }
    }
  }

  List<String> get _availableItems {
    return itemCatalog[widget.category] ?? [];
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
                      widget.category.toUpperCase(),
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
                itemCount: _availableItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final item = _availableItems[index];
                  final isSelected = _selectedItems.containsKey(item);
                  final quantity = _selectedItems[item] ?? 1;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedItems.remove(item);
                        } else {
                          _selectedItems[item] = 1;
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
                          if (isSelected) ...[
                            // Controles de quantidade
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    _selectedItems[item] = quantity - 1;
                                  }
                                });
                              },
                              color: const Color(0xFF5B0A16),
                              iconSize: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                              ),
                              child: Text(
                                quantity.toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF5B0A16),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  _selectedItems[item] = quantity + 1;
                                });
                              },
                              color: const Color(0xFF5B0A16),
                              iconSize: 20,
                            ),
                          ] else
                            const Icon(
                              Icons.check_circle_outline,
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
                        // Retorna lista de SelectedItem com quantidades
                        final selected = _selectedItems.entries.map((entry) {
                          return SelectedItem(
                            category: widget.category,
                            item: entry.key,
                            quantity: entry.value,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Confirmar (${_selectedItems.length} itens)',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          if (_selectedItems.values.fold<int>(0, (sum, qty) => sum + qty) > _selectedItems.length)
                            Text(
                              'Total: ${_selectedItems.values.fold<int>(0, (sum, qty) => sum + qty)} unidades',
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

