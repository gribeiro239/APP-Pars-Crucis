import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Estrutura para técnicas com custo de XP
class Technique {
  final String name;
  final int xpCost;

  const Technique({required this.name, required this.xpCost});
  
  // Retorna apenas o nome (sem o [XP])
  String get displayName => name;
}

// Classe para acessar catálogos de técnicas
class TechniqueCatalog {
  // Catálogo de técnicas corpo a corpo
  static const Map<String, Technique> corpoACorpoTechniques = {
    'Assassinar': Technique(name: 'Assassinar', xpCost: 2),
    'Ataque Coordenado': Technique(name: 'Ataque Coordenado', xpCost: 2),
    'Ataque de Repente': Technique(name: 'Ataque de Repente', xpCost: 2),
    'Ataque Imprudente': Technique(name: 'Ataque Imprudente', xpCost: 2),
    'Ataque Travesso': Technique(name: 'Ataque Travesso', xpCost: 2),
    'Bote Longo': Technique(name: 'Bote Longo', xpCost: 2),
    'Cobrir': Technique(name: 'Cobrir', xpCost: 2),
    'Corte Hemorrágico': Technique(name: 'Corte Hemorrágico', xpCost: 2),
    'Encontrão': Technique(name: 'Encontrão', xpCost: 2),
    'Envencilhar': Technique(name: 'Envencilhar', xpCost: 2),
    'Estalar': Technique(name: 'Estalar', xpCost: 2),
    'Fende Corpos': Technique(name: 'Fende Corpos', xpCost: 4),
    'Finta': Technique(name: 'Finta', xpCost: 2),
    'Fura Aço': Technique(name: 'Fura Aço', xpCost: 4),
    'Golpe Atordoante': Technique(name: 'Golpe Atordoante', xpCost: 2),
    'Golpe Brutal': Technique(name: 'Golpe Brutal', xpCost: 2),
    'Golpe Conjunto': Technique(name: 'Golpe Conjunto', xpCost: 2),
    'Golpe Implosivo': Technique(name: 'Golpe Implosivo', xpCost: 4),
    'Guarda Ofensiva': Technique(name: 'Guarda Ofensiva', xpCost: 2),
    'Investida': Technique(name: 'Investida', xpCost: 2),
    'Justa': Technique(name: 'Justa', xpCost: 2),
    'Luta Suja': Technique(name: 'Luta Suja', xpCost: 2),
    'Mordhau': Technique(name: 'Mordhau', xpCost: 2),
    'Palma Vazia': Technique(name: 'Palma Vazia', xpCost: 4),
    'Postura Defensiva': Technique(name: 'Postura Defensiva', xpCost: 2),
    'Postura Ofensiva': Technique(name: 'Postura Ofensiva', xpCost: 2),
    'Quebra Corpos': Technique(name: 'Quebra Corpos', xpCost: 4),
    'Rasteira': Technique(name: 'Rasteira', xpCost: 2),
    'Redirecionar': Technique(name: 'Redirecionar', xpCost: 2),
    'Ripostar': Technique(name: 'Ripostar', xpCost: 4),
    'Saque Ascendente': Technique(name: 'Saque Ascendente', xpCost: 4),
  };
  
  // Estilos de Luta
  static const Map<String, Technique> fightingStyles = {
    'Borcus': Technique(name: 'Borcus', xpCost: 2),
    'Contra Impacto': Technique(name: 'Contra Impacto', xpCost: 0), // Sem custo de XP especificado
    'Aríete': Technique(name: 'Aríete', xpCost: 4),
    'Flaiate': Technique(name: 'Flaiate', xpCost: 2),
    'Golpe Catavento': Technique(name: 'Golpe Catavento', xpCost: 2),
    'Haia': Technique(name: 'Haia', xpCost: 2),
    'Îgoie': Technique(name: 'Îgoie', xpCost: 2),
    'Selvageria': Technique(name: 'Selvageria', xpCost: 4),
    'Îpaie': Technique(name: 'Îpaie', xpCost: 2),
    'Chute Acrobático': Technique(name: 'Chute Acrobático', xpCost: 2),
    'Mokuatl': Technique(name: 'Mokuatl', xpCost: 2),
    'Riôhr': Technique(name: 'Riôhr', xpCost: 2),
  };
  
  // Catálogo de técnicas à distância
  static const Map<String, Technique> distanciaTechniques = {
    'Arremesso Preciso': Technique(name: 'Arremesso Preciso', xpCost: 2),
    'Arremesso Empalador': Technique(name: 'Arremesso Empalador', xpCost: 2),
    'Carga Reforçada': Technique(name: 'Carga Reforçada', xpCost: 2),
    'Disparo do Quadril': Technique(name: 'Disparo do Quadril', xpCost: 2),
    'Disparo Grosseiro': Technique(name: 'Disparo Grosseiro', xpCost: 2),
    'Mira na Mosca': Technique(name: 'Mira na Mosca', xpCost: 2),
    'Postura de Disparo': Technique(name: 'Postura de Disparo', xpCost: 2),
    'Potência Granada': Technique(name: 'Potência Granada', xpCost: 2),
    'Ricochete': Technique(name: 'Ricochete', xpCost: 2),
    'Saque Ligeiro': Technique(name: 'Saque Ligeiro', xpCost: 2),
    'Tensionamento': Technique(name: 'Tensionamento', xpCost: 2),
    'Tiro Acurado': Technique(name: 'Tiro Acurado', xpCost: 2),
    'Tiro Fiel': Technique(name: 'Tiro Fiel', xpCost: 4),
    'Tiros Sucessivos': Technique(name: 'Tiros Sucessivos', xpCost: 4),
  };
  
  // Catálogo de outras técnicas
  static const Map<String, Technique> outrasTechniques = {
    'Escafeder': Technique(name: 'Escafeder', xpCost: 2),
    'Estardalhaço': Technique(name: 'Estardalhaço', xpCost: 2),
    'Foco Disperso': Technique(name: 'Foco Disperso', xpCost: 2),
    'Foco Lento': Technique(name: 'Foco Lento', xpCost: 2),
    'Foco Sobrenatural': Technique(name: 'Foco Sobrenatural', xpCost: 2),
    'Força Descomunal': Technique(name: 'Força Descomunal', xpCost: 2),
    'Glória ou Fuga': Technique(name: 'Glória ou Fuga', xpCost: 2),
    'Grito de Guerra': Technique(name: 'Grito de Guerra', xpCost: 2),
    'Imagem Residual': Technique(name: 'Imagem Residual', xpCost: 4),
    'Incógnito': Technique(name: 'Incógnito', xpCost: 4),
    'Obstinação': Technique(name: 'Obstinação', xpCost: 4),
    'Palavras de Comando': Technique(name: 'Palavras de Comando', xpCost: 4),
    'Salto Múltiplo': Technique(name: 'Salto Múltiplo', xpCost: 4),
    'Sombra': Technique(name: 'Sombra', xpCost: 4),
    'Olhos Vazios': Technique(name: 'Olhos Vazios', xpCost: 2),
    'Urro Interior': Technique(name: 'Urro Interior', xpCost: 2),
    'Vulto': Technique(name: 'Vulto', xpCost: 4),
  };
}

class ItemSelectionScreen extends StatefulWidget {
  final String category;
  final List<String>? initialSelected;
  final int Function()? getAvailableXP; // Função para obter XP disponível
  final bool Function(int xpCost)? canAffordXP; // Função para validar se pode gastar XP

  const ItemSelectionScreen({
    super.key, 
    required this.category, 
    this.initialSelected,
    this.getAvailableXP,
    this.canAffordXP,
  });

  @override
  State<ItemSelectionScreen> createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  late final Set<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    // Inicializa com os itens já selecionados
    // Se vierem no formato "Nome [XP]", extrai apenas o nome
    _selectedItems = widget.initialSelected != null
        ? Set<String>.from(widget.initialSelected!.map((item) => _extractTechniqueName(item)))
        : <String>{};
  }
  
  // Extrai o nome da técnica (agora não há mais [XP] no nome)
  String _extractTechniqueName(String item) {
    // Remove o formato antigo "[XP]" se existir (compatibilidade)
    final match = RegExp(r'^(.+?)\s*\[\d+\s*XP\]$').firstMatch(item);
    return match != null ? match.group(1)!.trim() : item;
  }
  
  // Obtém o custo de XP de uma técnica
  int _getTechniqueXPCost(String techniqueName) {
    if (widget.category == 'Técnicas Corpo a Corpo') {
      final technique = TechniqueCatalog.corpoACorpoTechniques[techniqueName];
      return technique?.xpCost ?? 0;
    } else if (widget.category == 'Técnicas a Distância') {
      final technique = TechniqueCatalog.distanciaTechniques[techniqueName];
      return technique?.xpCost ?? 0;
    } else if (widget.category == 'Outras Técnicas') {
      final technique = TechniqueCatalog.outrasTechniques[techniqueName];
      return technique?.xpCost ?? 0;
    }
    return 0;
  }
  
  // Calcula o XP total gasto nas técnicas selecionadas
  int _calculateTotalXPCost() {
    int total = 0;
    for (final item in _selectedItems) {
      total += _getTechniqueXPCost(item);
    }
    return total;
  }

  // Placeholder - você pode substituir por dados reais depois
  List<String> get _availableItems {
    switch (widget.category) {
      case 'Armamentos':
        return [
          'Espada Longa',
          'Machado de Batalha',
          'Arco Longo',
          'Adaga',
          'Cajado',
          'Martelo de Guerra',
        ];
      case 'Vestimentas':
        return [
          'Roupa de folhas',
          'Roupa de pano',
          'Camadas de folhas',
          'Veste cerimonial',
          'Veste reforçada',
          'Veste remendada',
          'Gibão',
          'Manto de penas',
          'Malha cinética',
          'Veste de couro',
          'Malha sucateada',
          'Manto de pele',
          'Folhas trançadas',
          'Manto cerimonial',
          'Veste tática',
          'Couro tachonado',
          'Camadas de penas',
          'Couraça de ossos',
          'Veste metatérmica',
          'Malha tática',
          'Camadas de couro',
          'Couro enrijecido',
          'Veste célere',
          'Couraça de linho',
          'Cota de malha',
          'Couraça sucateada',
          'Pele pesada',
          'Couraça de placas',
          'Couraça cerimonial',
          'Malha escamada',
          'Couraça articulada',
          'Couraça tática',
          'Laminar de madeira',
          'Couraça vegetal',
          'Couraça laminar',
          'Couraça com peles',
          'Couraça legionária',
          'Armadura Epífita',
        ];
      case 'Itens':
        return [
          'Poção de Cura',
          'Poção de Mana',
          'Corda',
          'Tocha',
          'Kit de Primeiros Socorros',
          'Mapa',
        ];
      case 'Técnicas Corpo a Corpo':
        return TechniqueCatalog.corpoACorpoTechniques.values.map((t) => t.displayName).toList();
      case 'Técnicas a Distância':
        return TechniqueCatalog.distanciaTechniques.values.map((t) => t.displayName).toList();
      case 'Outras Técnicas':
        return TechniqueCatalog.outrasTechniques.values.map((t) => t.displayName).toList();
      case 'Poderes':
        return [
          // Adicione aqui os poderes
          'Poder 1',
          'Poder 2',
          'Poder 3',
        ];
      default:
        return [];
    }
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
                      'SELECIONE ${widget.category.toUpperCase()}',
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
                itemCount: _availableItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final itemDisplay = _availableItems[index];
                  // Extrai o nome da técnica do formato "Nome [XP]"
                  final itemName = _extractTechniqueName(itemDisplay);
                  final isSelected = _selectedItems.contains(itemName);
                  final xpCost = _getTechniqueXPCost(itemName);
                  final availableXP = widget.getAvailableXP?.call() ?? 999999;
                  final canAfford = widget.canAffordXP?.call(xpCost) ?? true;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedItems.remove(itemName);
                        } else {
                          // Validar XP antes de adicionar
                          if (canAfford || widget.canAffordXP == null) {
                            _selectedItems.add(itemName);
                          } else {
                            // Mostrar mensagem de erro
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('XP insuficiente! Necessário: $xpCost XP, Disponível: $availableXP XP (mínimo: -2 XP)'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  itemDisplay,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (xpCost > 0 && widget.category.contains('Técnicas'))
                                  Text(
                                    'Custo: $xpCost XP',
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: canAfford || isSelected
                                          ? Colors.grey[600]
                                          : Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
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
                        // Retorna os nomes das técnicas (sem o [XP])
                        final result = _selectedItems.toList();
                        Navigator.pop(context, result);
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
                            'Confirmar (${_selectedItems.length})',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          if (widget.category.contains('Técnicas') && _calculateTotalXPCost() > 0)
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




