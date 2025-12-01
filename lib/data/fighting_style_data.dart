// Dados dos estilos de luta e seus golpes relacionados

class FightingStyle {
  final String name;
  final List<String> strikes;

  const FightingStyle({
    required this.name,
    required this.strikes,
  });
}

class SelectedFightingStyle {
  final String styleName;
  final List<String> selectedStrikes;

  SelectedFightingStyle({
    required this.styleName,
    required this.selectedStrikes,
  });

  // Converter para string para armazenamento
  String toStorageString() {
    if (selectedStrikes.isEmpty) {
      return styleName;
    }
    return '$styleName|${selectedStrikes.join(',')}';
  }

  // Criar a partir de string de armazenamento
  factory SelectedFightingStyle.fromStorageString(String str) {
    final parts = str.split('|');
    final styleName = parts[0];
    final strikes = parts.length > 1 
        ? List<String>.from(parts[1].split(',')) 
        : <String>[];
    return SelectedFightingStyle(
      styleName: styleName,
      selectedStrikes: strikes,
    );
  }
}

// Catálogo de estilos de luta
const Map<String, FightingStyle> fightingStyleCatalog = {
  'Borcus': FightingStyle(
    name: 'Borcus',
    strikes: ['Contra Impacto', 'Aríete'],
  ),
  'Flaiate': FightingStyle(
    name: 'Flaiate',
    strikes: ['Golpe Catavento'],
  ),
  'Haia': FightingStyle(
    name: 'Haia',
    strikes: [],
  ),
  'Îgoie': FightingStyle(
    name: 'Îgoie',
    strikes: ['Selvageria'],
  ),
  'Îpaie': FightingStyle(
    name: 'Îpaie',
    strikes: ['Chute Acrobático'],
  ),
  'Mokuatl': FightingStyle(
    name: 'Mokuatl',
    strikes: [],
  ),
  'Riôhr': FightingStyle(
    name: 'Riôhr',
    strikes: [],
  ),
};

