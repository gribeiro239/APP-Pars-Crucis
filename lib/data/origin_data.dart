const Map<String, int> kZeroModifiers = {
  'FIS': 0,
  'REF': 0,
  'EGO': 0,
  'COG': 0,
  'ESP': 0,
};

class OriginSubtype {
  final String name;
  final Map<String, int> modifiers;

  const OriginSubtype({
    required this.name,
    this.modifiers = kZeroModifiers,
  });
}

class OriginSelectionResult {
  final String origin;
  final OriginSubtype subtype;

  const OriginSelectionResult({required this.origin, required this.subtype});

  String get displayName => '$origin – ${subtype.name}';
}

const Map<String, List<OriginSubtype>> originCatalog = {
  'Humano': [
    OriginSubtype(
      name: 'Humano',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': 2,
        'COG': 0,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Originário',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': 1,
        'COG': 0,
        'ESP': 1,
      },
    ),
    OriginSubtype(
      name: 'Gene Anima',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': 2,
        'COG': 0,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Gene Célere',
      modifiers: {
        'FIS': 0,
        'REF': 1,
        'EGO': 2,
        'COG': 1,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Gene Coágulo',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': 2,
        'COG': 0,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Gene Noctis',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': 2,
        'COG': 0,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Gene Viribus',
      modifiers: {
        'FIS': 1,
        'REF': 0,
        'EGO': 2,
        'COG': 0,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Gene Vita',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': 2,
        'COG': 0,
        'ESP': 0,
      },
    ),
  ],
  'Capríaco': [
    OriginSubtype(
      name: 'Capríaco',
      modifiers: {
        'FIS': 1,
        'REF': 0,
        'EGO': 0,
        'COG': 2,
        'ESP': -2,
      },
    ),
    OriginSubtype(
      name: 'Capridomo',
      modifiers: {
        'FIS': 1,
        'REF': 0,
        'EGO': -1,
        'COG': 1,
        'ESP': -2,
      },
    ),
    OriginSubtype(
      name: 'Artiano',
      modifiers: {
        'FIS': 1,
        'REF': 0,
        'EGO': 1,
        'COG': 1,
        'ESP': -2,
      },
    ),
    OriginSubtype(
      name: 'Descornado',
      modifiers: {
        'FIS': 1,
        'REF': 0,
        'EGO': 0,
        'COG': 2,
        'ESP': -2,
      },
    ),
    OriginSubtype(
      name: 'Galhada',
      modifiers: {
        'FIS': 1,
        'REF': 0,
        'EGO': 0,
        'COG': 2,
        'ESP': -2,
      },
    ),
  ],
  'Carneador': [
    OriginSubtype(
      name: 'Carneador',
      modifiers: {
        'FIS': 2,
        'REF': 0,
        'EGO': -1,
        'COG': 0,
        'ESP': -1,
      },
    ),
    OriginSubtype(
      name: 'Carniceiro',
      modifiers: {
        'FIS': 2,
        'REF': 0,
        'EGO': -1,
        'COG': 0,
        'ESP': -1,
      },
    ),
    OriginSubtype(
      name: 'Herança Ancestral',
      modifiers: {
        'FIS': 1,
        'REF': 0,
        'EGO': -1,
        'COG': 0,
        'ESP': 1,
      },
    ),
  ],
  'Guará': [
    OriginSubtype(
      name: 'Guará',
      modifiers: {
        'FIS': -2,
        'REF': 2,
        'EGO': 1,
        'COG': -1,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Descaudado',
      modifiers: {
        'FIS': -2,
        'REF': 1,
        'EGO': 1,
        'COG': -1,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Pelo Denso',
      modifiers: {
        'FIS': -2,
        'REF': 2,
        'EGO': 1,
        'COG': -1,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Selvagem',
      modifiers: {
        'FIS': -2,
        'REF': 2,
        'EGO': 0,
        'COG': -1,
        'ESP': 0,
      },
    ),
  ],
  'Ligno': [
    OriginSubtype(
      name: 'Ligno',
      modifiers: {
        'FIS': 1,
        'REF': -1,
        'EGO': -2,
        'COG': 0,
        'ESP': 1,
      },
    ),
    OriginSubtype(
      name: 'Broto',
      modifiers: {
        'FIS': -1,
        'REF': 1,
        'EGO': -1,
        'COG': 0,
        'ESP': 1,
      },
    ),
    OriginSubtype(
      name: 'Desértico',
      modifiers: {
        'FIS': 1,
        'REF': -1,
        'EGO': -2,
        'COG': 0,
        'ESP': 1,
      },
    ),
    OriginSubtype(
      name: 'Hidrófito',
      modifiers: {
        'FIS': 1,
        'REF': -1,
        'EGO': -2,
        'COG': 0,
        'ESP': 1,
      },
    ),
    OriginSubtype(
      name: 'Invernal',
      modifiers: {
        'FIS': 1,
        'REF': -1,
        'EGO': -2,
        'COG': 0,
        'ESP': 1,
      },
    ),
    OriginSubtype(
      name: 'Primevo',
      modifiers: {
        'FIS': 4,
        'REF': -3,
        'EGO': -2,
        'COG': 0,
        'ESP': 1,
      },
    ),
  ],
  'Orcino': [
    OriginSubtype(
      name: 'Orcino',
      modifiers: {
        'FIS': -1,
        'REF': 1,
        'EGO': 0,
        'COG': 1,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Terrestre',
      modifiers: {
        'FIS': -1,
        'REF': 1,
        'EGO': 0,
        'COG': 1,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Pálido',
      modifiers: {
        'FIS': -1,
        'REF': 1,
        'EGO': 0,
        'COG': 1,
        'ESP': 0,
      },
    ),
    OriginSubtype(
      name: 'Pantanoso',
      modifiers: {
        'FIS': -1,
        'REF': 1,
        'EGO': 0,
        'COG': 1,
        'ESP': 0,
      },
    ),
  ],
  'Quezal': [
    OriginSubtype(
      name: 'Quezal',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': -1,
        'COG': -1,
        'ESP': 2,
      },
    ),
    OriginSubtype(
      name: 'Penígero',
      modifiers: {
        'FIS': 0,
        'REF': 0,
        'EGO': 1,
        'COG': -1,
        'ESP': 2,
      },
    ),
    OriginSubtype(
      name: 'Troglodita',
      modifiers: {
        'FIS': 2,
        'REF': 0,
        'EGO': -2,
        'COG': -2,
        'ESP': 1,
      },
    ),
  ],
};





