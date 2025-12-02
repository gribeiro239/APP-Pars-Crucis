// Dados dos itens e suas categorias

class ItemCategory {
  final String name;
  final List<String> items;

  const ItemCategory({
    required this.name,
    required this.items,
  });
}

class SelectedItem {
  final String category;
  final String item;
  int quantity;

  SelectedItem({
    required this.category,
    required this.item,
    this.quantity = 1,
  });

  // Converter para string para armazenamento
  String toStorageString() {
    return '$category|$item|$quantity';
  }

  // Criar a partir de string de armazenamento
  factory SelectedItem.fromStorageString(String str) {
    final parts = str.split('|');
    if (parts.length >= 3) {
      return SelectedItem(
        category: parts[0],
        item: parts[1],
        quantity: int.tryParse(parts[2]) ?? 1,
      );
    } else if (parts.length == 2) {
      return SelectedItem(
        category: parts[0],
        item: parts[1],
        quantity: 1,
      );
    }
    
    return SelectedItem(
      category: 'Outros',
      item: str,
      quantity: 1,
    );
  }
}

// Catálogo de itens por categoria
const Map<String, List<String>> itemCatalog = {
  'ALQUÍMICOS': [
    'Accelerato',
    'Acidum',
    'Actio Glutinum',
    'Alta-Gelida',
    'Antídoto',
    'Arbor',
    'Bomba Cáustica',
    'Citotoxina',
    'Coquetel de Mutação',
    'Ebrius',
    'Essentia',
    'Firme',
    'Fortis Acidum',
    'Fortis Vita',
    'Gasóleo',
    'Gélida',
    'Glutinum',
    'Herbicida',
    'Ignis',
    'Illuminatio',
    'Impius Ignis',
    'Ius Anima',
    'Ius Vita',
    'Ius Vivifica',
    'Lumen',
    'Mortífico',
    'Noctis',
    'Reagente Filtrador',
    'Sanguis',
    'Spiritus Aqua',
    'Toxina final',
    'Toxina Mercurial',
    'Viribus',
    'Vis Vita',
    'Vita',
  ],
  'ARTEFATOS BÉLICOS': [
    'Bomba Concussiva',
    'Bomba de Fumaça',
    'Bomba de Prata-Viva',
    'Bombinhas',
    'Explode Mão',
    'Fiat Lux',
    'Fragmentadora',
    'Gora',
    'PEM',
    'Repulsora',
    'Sinalizador',
  ],
  'CANALIZADORES': [
    'Pedra Essencial',
    'Cristal de Lágrima',
    'Lágrima de Sangue',
  ],
  'HERBAIS': [
    'Alma Vive',
    'Analgésico',
    'Angélica',
    'Bálsamo',
    'Batracotoxina',
    'Cálamo',
    'Curare',
    'Flucto Virtus',
    'Ginseng',
    'Gramen Vita',
    'Hemotoxina',
    'Incido Fluctus',
    'Luna Tenebris',
    'Mandrágora',
    'Mendax',
    'Minuere',
    'Neurotoxina',
    'Neutralizadora',
    'Oblivis',
    'Punhado Aromático',
    'Repelente',
    'Termogênicos',
    'Toxina Pirógena',
    'Toxiveneno',
    'Vapores Soníferos',
  ],
};

