import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeneficiosSelectionScreen extends StatefulWidget {
  final List<String>? initialSelected;
  
  const BeneficiosSelectionScreen({super.key, this.initialSelected});

  static const Map<String, int> beneficios = {
    'Abundância': 2,
    'Analgesia': 2,
    'Arremessador': 1,
    'Aura Forte': 3,
    'Boa Aparência': 2,
    'Boa Memória': 1,
    'Boa Mira': 2,
    'Boa Saúde': 2,
    'Carregador': 1,
    'Cogni': 3,
    'Convergência': 2,
    'Colheita': 1,
    'Descanso Eficiente': 2,
    'Desperto': 2,
    'Destemido': 2,
    'Desteridade': 4,
    'Distinção Real': 2,
    'Duro de Matar': 2,
    'Escalador': 1,
    'Estômago de Ferro': 2,
    'Força Física': 4,
    'Herança': 3,
    'Identidade Extra': 2,
    'Item Oculto': 2,
    'Leitura Labial': 2,
    'Masoquismo': 3,
    'Memória Eidética': 2,
    'Moral Incontestável': 3,
    'Nadador': 1,
    'Ninguém': 2,
    'Noções Táticas': 2,
    'Norte': 1,
    'Percepção Sagaz': 2,
    'Poder Espiritual': 4,
    'Porta da Morte': 2,
    'Proficiência Defensiva': 3,
    'Rancor': 2,
    'Rede de Contatos': 2,
    'Reflexos Afiados': 3,
    'Robusto': 3,
    'Sangue Frio': 2,
    'Sorte Extra': 3,
    'Tolerância Química': 2,
    'Valentia': 3,
    'Vitalidade': 2,
  };

  @override
  State<BeneficiosSelectionScreen> createState() => _BeneficiosSelectionScreenState();
}

class _BeneficiosSelectionScreenState extends State<BeneficiosSelectionScreen> {
  late final Set<String> _selected;
  final TextEditingController _searchController = TextEditingController();
  String _sortBy = 'nome'; // 'nome' ou 'pontos'
  int? _filterPoints; // null = todos, ou valor específico

  @override
  void initState() {
    super.initState();
    // Inicializa com os itens já selecionados, extraindo apenas o nome
    _selected = {};
    if (widget.initialSelected != null) {
      for (var item in widget.initialSelected!) {
        // Remove o formato "[↓XPTS]" para obter apenas o nome
        final name = item.replaceAll(RegExp(r'\s*\[↓\d+PTS\]'), '');
        if (name.isNotEmpty) {
          _selected.add(name);
        }
      }
    }
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MapEntry<String, int>> _getFilteredAndSortedEntries() {
    var entries = BeneficiosSelectionScreen.beneficios.entries.toList();
    
    // Filtro por busca de texto
    final searchText = _searchController.text.toLowerCase();
    if (searchText.isNotEmpty) {
      entries = entries.where((e) => 
        e.key.toLowerCase().contains(searchText) ||
        e.value.toString().contains(searchText)
      ).toList();
    }
    
    // Filtro por pontos
    if (_filterPoints != null) {
      entries = entries.where((e) => e.value == _filterPoints).toList();
    }
    
    // Ordenação
    if (_sortBy == 'nome') {
      entries.sort((a, b) => a.key.compareTo(b.key));
    } else if (_sortBy == 'pontos') {
      entries.sort((a, b) {
        final pointsCompare = a.value.compareTo(b.value);
        if (pointsCompare != 0) return pointsCompare;
        return a.key.compareTo(b.key);
      });
    }
    
    return entries;
  }

  void _onDone() {
    final result = _selected
        .map((nome) => '$nome [↓${BeneficiosSelectionScreen.beneficios[nome]}PTS]')
        .toList();
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final entries = _getFilteredAndSortedEntries();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Selecione Benefícios',
          style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: _onDone,
            child: Text('OK', style: GoogleFonts.roboto(color: Colors.white)),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/textura_pergaminho.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Barra de busca e filtros
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: Border(
                  bottom: BorderSide(color: const Color(0xFF5B0A16).withOpacity(0.3), width: 1),
                ),
              ),
              child: Column(
                children: [
                  // Campo de busca
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _searchController,
                      builder: (context, value, child) {
                        return TextField(
                          controller: _searchController,
                          style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Buscar por nome ou pontos...',
                            hintStyle: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
                            prefixIcon: Icon(Icons.search, color: const Color(0xFF5B0A16)),
                            suffixIcon: value.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear, color: const Color(0xFF5B0A16)),
                                    onPressed: () {
                                      _searchController.clear();
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filtros de ordenação e pontos
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: _sortBy,
                            style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Ordenar por',
                              labelStyle: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[700]),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            dropdownColor: Colors.white,
                            items: [
                              DropdownMenuItem(
                                value: 'nome',
                                child: Text('Nome (A-Z)', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                              DropdownMenuItem(
                                value: 'pontos',
                                child: Text('Pontos', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _sortBy = value);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<int?>(
                            value: _filterPoints,
                            style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Filtrar por pontos',
                              labelStyle: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[700]),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            dropdownColor: Colors.white,
                            items: [
                              DropdownMenuItem<int?>(
                                value: null,
                                child: Text('Todos', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                              DropdownMenuItem<int?>(
                                value: 1,
                                child: Text('1 PTS', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                              DropdownMenuItem<int?>(
                                value: 2,
                                child: Text('2 PTS', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                              DropdownMenuItem<int?>(
                                value: 3,
                                child: Text('3 PTS', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                              DropdownMenuItem<int?>(
                                value: 4,
                                child: Text('4 PTS', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                              DropdownMenuItem<int?>(
                                value: 5,
                                child: Text('5 PTS', style: GoogleFonts.roboto(fontSize: 14)),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() => _filterPoints = value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Lista de itens
            Expanded(
              child: entries.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum benefício encontrado',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: entries.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (ctx, i) {
                        final nome = entries[i].key;
                        final pts = entries[i].value;
                        final checked = _selected.contains(nome);
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CheckboxListTile(
                            title: Text(
                              '$nome [↓${pts}PTS]',
                              style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                            ),
                            value: checked,
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: const Color(0xFF5B0A16),
                            onChanged: (v) => setState(() {
                              if (v == true) {
                                _selected.add(nome);
                              } else {
                                _selected.remove(nome);
                              }
                            }),
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





