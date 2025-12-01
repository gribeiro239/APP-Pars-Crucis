import 'dart:io';

class CharacterData {
  // Informações básicas
  String name;
  String xp;
  String pts;
  String origin;
  String culture;
  String persona;
  String maleficios;
  String beneficios;
  int malefSum;
  int benefSum;
  
  // Atributos
  int fis;
  int refx;
  int ego;
  int cog;
  int esp;
  
  // Perícias
  Map<String, int> skillRanks;
  Map<String, int> skillModifiers;
  
  // Inventário
  List<String> armamentos;
  List<String> vestimentas;
  List<String> itens;
  
  // Habilidades
  List<String> tecnicasCorpoACorpo;
  List<String> tecnicasDistancia;
  List<String> tecnicasOutras;
  List<String> estilosLuta; // Armazenado como strings (SelectedFightingStyle.toStorageString())
  List<String> poderes;
  
  // Biografia
  String idade;
  String nasc;
  String altura;
  String peso;
  String aparencia;
  String comportamento;
  String objetivos;
  String biografia;
  
  // Imagem
  String? imagePath;
  
  // Data de criação/modificação
  DateTime createdAt;
  DateTime updatedAt;
  
  CharacterData({
    this.name = '',
    this.xp = '',
    this.pts = '',
    this.origin = '',
    this.culture = '',
    this.persona = '',
    this.maleficios = '',
    this.beneficios = '',
    this.malefSum = 0,
    this.benefSum = 0,
    this.fis = 0,
    this.refx = 0,
    this.ego = 0,
    this.cog = 0,
    this.esp = 0,
    Map<String, int>? skillRanks,
    Map<String, int>? skillModifiers,
    List<String>? armamentos,
    List<String>? vestimentas,
    List<String>? itens,
    List<String>? tecnicasCorpoACorpo,
    List<String>? tecnicasDistancia,
    List<String>? tecnicasOutras,
    List<String>? estilosLuta,
    List<String>? poderes,
    this.idade = '',
    this.nasc = '',
    this.altura = '',
    this.peso = '',
    this.aparencia = '',
    this.comportamento = '',
    this.objetivos = '',
    this.biografia = '',
    this.imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : skillRanks = skillRanks ?? {},
        skillModifiers = skillModifiers ?? {},
        armamentos = armamentos ?? [],
        vestimentas = vestimentas ?? [],
        itens = itens ?? [],
        tecnicasCorpoACorpo = tecnicasCorpoACorpo ?? [],
        tecnicasDistancia = tecnicasDistancia ?? [],
        tecnicasOutras = tecnicasOutras ?? [],
        estilosLuta = estilosLuta ?? [],
        poderes = poderes ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
  
  // Converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'xp': xp,
      'pts': pts,
      'origin': origin,
      'culture': culture,
      'persona': persona,
      'maleficios': maleficios,
      'beneficios': beneficios,
      'malefSum': malefSum,
      'benefSum': benefSum,
      'fis': fis,
      'refx': refx,
      'ego': ego,
      'cog': cog,
      'esp': esp,
      'skillRanks': skillRanks,
      'skillModifiers': skillModifiers,
      'armamentos': armamentos,
      'vestimentas': vestimentas,
      'itens': itens,
      'tecnicasCorpoACorpo': tecnicasCorpoACorpo,
      'tecnicasDistancia': tecnicasDistancia,
      'tecnicasOutras': tecnicasOutras,
      'estilosLuta': estilosLuta,
      'poderes': poderes,
      'idade': idade,
      'nasc': nasc,
      'altura': altura,
      'peso': peso,
      'aparencia': aparencia,
      'comportamento': comportamento,
      'objetivos': objetivos,
      'biografia': biografia,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  // Criar a partir de JSON
  factory CharacterData.fromJson(Map<String, dynamic> json) {
    return CharacterData(
      name: json['name'] ?? '',
      xp: json['xp'] ?? '',
      pts: json['pts'] ?? '',
      origin: json['origin'] ?? '',
      culture: json['culture'] ?? '',
      persona: json['persona'] ?? '',
      maleficios: json['maleficios'] ?? '',
      beneficios: json['beneficios'] ?? '',
      malefSum: json['malefSum'] ?? 0,
      benefSum: json['benefSum'] ?? 0,
      fis: json['fis'] ?? 0,
      refx: json['refx'] ?? 0,
      ego: json['ego'] ?? 0,
      cog: json['cog'] ?? 0,
      esp: json['esp'] ?? 0,
      skillRanks: Map<String, int>.from(json['skillRanks'] ?? {}),
      skillModifiers: Map<String, int>.from(json['skillModifiers'] ?? {}),
      armamentos: List<String>.from(json['armamentos'] ?? []),
      vestimentas: List<String>.from(json['vestimentas'] ?? []),
      itens: List<String>.from(json['itens'] ?? []),
      tecnicasCorpoACorpo: List<String>.from(json['tecnicasCorpoACorpo'] ?? json['tecnicas'] ?? []), // Compatibilidade com versão antiga
      tecnicasDistancia: List<String>.from(json['tecnicasDistancia'] ?? []),
      tecnicasOutras: List<String>.from(json['tecnicasOutras'] ?? []),
      estilosLuta: List<String>.from(json['estilosLuta'] ?? []),
      poderes: List<String>.from(json['poderes'] ?? []),
      idade: json['idade'] ?? '',
      nasc: json['nasc'] ?? '',
      altura: json['altura'] ?? '',
      peso: json['peso'] ?? '',
      aparencia: json['aparencia'] ?? '',
      comportamento: json['comportamento'] ?? '',
      objetivos: json['objetivos'] ?? '',
      biografia: json['biografia'] ?? '',
      imagePath: json['imagePath'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}



