// Dados dos armamentos corpo a corpo e suas subdivisões

class ArmamentCategory {
  final String name;
  final List<String> items;

  const ArmamentCategory({
    required this.name,
    required this.items,
  });
}

class SelectedArmament {
  final String category;
  final String subcategory;
  final String item;

  SelectedArmament({
    required this.category,
    required this.subcategory,
    required this.item,
  });

  // Converter para string para armazenamento
  String toStorageString() {
    return '$category|$subcategory|$item';
  }

  // Criar a partir de string de armazenamento
  factory SelectedArmament.fromStorageString(String str) {
    final parts = str.split('|');
    if (parts.length == 3) {
      return SelectedArmament(
        category: parts[0],
        subcategory: parts[1],
        item: parts[2],
      );
    }
    // Compatibilidade com formato antigo (apenas nome do item)
    return SelectedArmament(
      category: 'Corpo a Corpo',
      subcategory: 'Outros',
      item: str,
    );
  }
}

// Catálogo de armamentos corpo a corpo
const Map<String, Map<String, List<String>>> armamentCatalog = {
  'Corpo a Corpo': {
    'BRIGA – LUTA DESARMADA': [
      'Punhos, chutes',
      'Garras curtas',
      'Garras',
      'Garras afiadas',
      'Cabeçada (chifres)',
    ],
    'BRIGA – ARREMESSÁVEIS': [
      'Pedra',
      'Dardo',
      'Bumerangue',
      'Shuriken, Kunai',
      'Disco',
    ],
    'BRIGA – SOQUEIRAS, FACAS E ARMAS PEQUENAS': [
      'Faca',
      'Soqueira',
      'Azorrague',
      'Tonfa',
      'Nunchaku',
      'Chicote',
      'Adaga, Tanto',
      'Punhal',
      'Chakram',
      'Adaga de aparo',
      'Lâmina injetora',
      'Katar, Patas',
      'Chicote de metal',
    ],
    'ESGRIMA – ESPADAS E SIMILARES': [
      // Itens serão adicionados aqui
    ],
    'HASTA – AZAGAIAS E ARREMESSÁVEIS': [
      'Atlatl',
      'Azagaia',
      'Pilo',
    ],
    'HASTA – LANÇAS E ARMAS DE HASTE': [
      'Bastão, Cajado',
      'Tridente',
      'Forcado',
      'Bastão pesado',
      'Lança, Yari',
      'Gadanha de guerra',
      'Pique, Sarissa',
      'Lança de cavalaria',
      'Naginata',
      'Tridente pesado',
      'Alabarda',
      'Lançarma',
    ],
    'MALHA – MAÇAS, MACHADOS, MARTELOS E MANGUAIS': [
      'Clava, Porrete',
      'Machado de pedra',
      'Machadinha',
      'Macete',
      'Machado',
      'Maça, Martelo',
      'Picareta',
      'Mangual',
      'Manriki, Corrente',
      'Mangual pesado',
      'Martelo de guerra',
      'Machado longo',
      'Maça fornalha',
    ],
    'ESCUDOS': [
      'Broquel',
      'Escudo alvo',
      'Escudo oval, longo',
      'Circular',
      'Escudo ferro, Scutum',
      'Pavise',
      'Escudo dispersor',
      'Escudo parede',
      'Escudo absortivo',
    ],
  },
  'Armas à Distância': {
    'ARQUERIA – ARCOS, BESTAS E ARMAS DE TENSIONAMENTO': [
      'Estilingue',
      'Zarabatana',
      'Arco simples',
      'Funda',
      'Arco curto',
      'Arco longo',
      'Atiradeira',
      'Arco pesado',
      'Arco de precisão',
      'Arco composto',
      'Onagro',
      'Trabuco',
    ],
    'BALÍSTICA – PISTOLAS E OUTRAS ARMAS DE UMA MÃO': [
      'Besta de mão',
      'Garrucha',
      'Cano curto',
      'Pistola leve',
      'Torvelha 5 ciclos',
      'Pistola de precisão',
    ],
    'BALÍSTICA – RIFLES, ESCOPETAS E SIMILARES': [
      'Besta',
      'Arcabuz',
      'Arbalete',
      'Bacamarte',
      'Besta de ação',
      'Cano duplo',
      'Espingarda',
      'Balestra',
      'Cospe fogo',
      'Arcobalista',
      'Canhão de pulso',
      'Canhão gélido',
      'Besta repetidora',
      'Canhão portátil',
      'Rifle revolver',
      'Rifle ferrolhado',
      'Rifle de trilho',
      'Canhão',
    ],
    'MUNIÇÕES': [
      'Calhau',
      'Flecha',
      'Virote',
      'Gasóleo',
      'Flecha pesada',
      'Arpão',
      'Chumbo e pólvora',
      'Cartucho: Bagos',
      'Cartucho: Balote',
      'Bala',
      'Pelouro',
    ],
    'MUNIÇÕES ESPECIAIS': [
      'Calhau: Álgido',
      'Calhau: Cáustico',
      'Calhau: Flama',
      'Calhau: Lágrima',
      'Calhau: Voltaico',
      'Cartucho: Dragão',
      'Cartucho: Vorme',
      'Jaqueta de Metal',
      'Núcleo Dinâmico',
      'Bateria Dinâmica',
      'Pelouro: Explosivo',
      'Ponteira Explosiva',
      'Ponteira Iônica',
      'Ponteira Perfurante',
      'Ponteira Elemental',
      'Revestimento Iônico',
    ],
  },
};

