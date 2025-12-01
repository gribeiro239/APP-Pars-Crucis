import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemSelectionScreen extends StatefulWidget {
  final String category;
  final List<String>? initialSelected;

  const ItemSelectionScreen({super.key, required this.category, this.initialSelected});

  @override
  State<ItemSelectionScreen> createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  late final Set<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    // Inicializa com os itens já selecionados
    _selectedItems = widget.initialSelected != null
        ? Set<String>.from(widget.initialSelected!)
        : <String>{};
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
        return [
          'Assassinar',
          'Ataque Coordenado',
          'Ataque de Repente',
          'Ataque Imprudente',
          'Ataque Travesso',
          'Bote Longo',
          'Cobrir',
          'Corte Hemorrágico',
          'Encontrão',
          'Envencilhar',
          'Estalar',
          'Fende Corpos',
          'Finta',
          'Fura Aço',
          'Golpe Atordoante',
          'Golpe Brutal',
          'Golpe Conjunto',
          'Golpe Implosivo',
          'Guarda Ofensiva',
          'Investida',
          'Justa',
          'Luta Suja',
          'Mordhau',
          'Palma Vazia',
          'Postura de Guarda',
          'Postura Ofensiva',
          'Quebra Corpos',
          'Rasteira',
          'Redirecionar',
          'Ripostar',
          'Saque Ascendente',
        ];
      case 'Técnicas a Distância':
        return [
          'Arremesso Preciso',
          'Arremesso Empalador',
          'Carga Reforçada',
          'Disparo do Quadril',
          'Disparo Grosseiro',
          'Mira na Mosca',
          'Postura de Disparo',
          'Potência Granada',
          'Ricochete',
          'Saque Ligeiro',
          'Tensionamento',
          'Tiro Acurado',
          'Tiro Fiel',
          'Tiros Sucessivos',
        ];
      case 'Outras Técnicas':
        return [
          'Escafeder',
          'Estardalhaço',
          'Foco Disperso',
          'Foco Lento',
          'Foco Sobrenatural',
          'Força Descomunal',
          'Glória ou Fuga',
          'Grito de Guerra',
          'Imagem Residual',
          'Incógnito',
          'Obstinação',
          'Palavras de Comando',
          'Salto Múltiplo',
          'Sombra',
          'Olhos Vazios',
          'Urro Interior',
          'Vulto',
        ];
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
                        Navigator.pop(context, _selectedItems.toList());
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




