import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/armament_data.dart';
import '../data/fighting_style_data.dart';
import '../data/item_data.dart';
import '../data/origin_data.dart';
import '../data/power_data.dart';
import '../models/character_data.dart';
import '../services/character_storage.dart';
import 'armament_category_selection_screen.dart';
import 'armament_item_selection_screen.dart';
import 'armament_subcategory_selection_screen.dart';
import 'item_category_selection_screen.dart';
import 'item_item_selection_screen.dart';
import 'beneficios_selection_screen.dart';
import 'culture_selection_screen.dart';
import 'fighting_style_selection_screen.dart';
import 'item_selection_screen.dart' show ItemSelectionScreen, TechniqueCatalog;
import 'maleficios_selection_screen.dart';
import 'origin_selection_screen.dart';
import 'persona_selection_screen.dart';
import 'power_category_selection_screen.dart';
import 'power_dativa_selection_screen.dart';
import 'power_selection_screen.dart';
import 'technique_category_selection_screen.dart';

/// Representa os valores de uma perícia (XP, N, M).
class SkillValue {
  final int xp;
  final int n;
  final int m;

  const SkillValue({
    this.xp = 0,
    this.n = 0,
    this.m = 0,
  });
}

/// Tabela de custos de XP para perícias
class XPCostTable {
  // XP necessário para alcançar cada nível (acumulado)
  // [nível] = XP total acumulado
  static const Map<int, int> commonXPCumulative = {
    1: 1,
    2: 3,
    3: 6,
    4: 10,
    5: 15,
    6: 21,
    7: 28,
    8: 36,
    9: 45,
    10: 55,
  };
  
  static const Map<int, int> commonFavoredXPCumulative = {
    1: 0,
    2: 1,
    3: 3,
    4: 6,
    5: 10,
    6: 15,
    7: 21,
    8: 28,
    9: 36,
    10: 45,
  };
  
  static const Map<int, int> difficultXPCumulative = {
    1: 2,
    2: 5,
    3: 9,
    4: 14,
    5: 20,
    6: 27,
    7: 35,
    8: 44,
    9: 54,
    10: 65,
  };
  
  static const Map<int, int> difficultFavoredXPCumulative = {
    1: 1,
    2: 3,
    3: 6,
    4: 10,
    5: 15,
    6: 21,
    7: 28,
    8: 36,
    9: 45,
    10: 55,
  };
  
  // XP necessário para avançar PARA um nível específico (incremental - valores entre parênteses na tabela)
  static const Map<int, int> commonXPPerLevel = {
    1: 1,   // N1: (1)
    2: 2,   // N2: (2) - 3-1
    3: 3,   // N3: (3) - 6-3
    4: 4,   // N4: (4) - 10-6
    5: 5,   // N5: (5) - 15-10
    6: 6,   // N6: (6) - 21-15
    7: 7,   // N7: (7) - 28-21
    8: 8,   // N8: (8) - 36-28
    9: 9,   // N9: (9) - 45-36
    10: 10, // N10: (10) - 55-45
  };
  
  static const Map<int, int> commonFavoredXPPerLevel = {
    1: 0,   // N1: (0)
    2: 1,   // N2: (1) - 1-0
    3: 2,   // N3: (2) - 3-1
    4: 3,   // N4: (3) - 6-3
    5: 4,   // N5: (4) - 10-6
    6: 5,   // N6: (5) - 15-10
    7: 6,   // N7: (6) - 21-15
    8: 7,   // N8: (7) - 28-21
    9: 8,   // N9: (8) - 36-28
    10: 9,  // N10: (9) - 45-36
  };
  
  static const Map<int, int> difficultXPPerLevel = {
    1: 2,   // N1: (2)
    2: 3,   // N2: (3) - 5-2
    3: 4,   // N3: (4) - 9-5
    4: 5,   // N4: (5) - 14-9
    5: 6,   // N5: (6) - 20-14
    6: 7,   // N6: (7) - 27-20
    7: 8,   // N7: (8) - 35-27
    8: 9,   // N8: (9) - 44-35
    9: 10,  // N9: (10) - 54-44
    10: 11, // N10: (11) - 65-54
  };
  
  static const Map<int, int> difficultFavoredXPPerLevel = {
    1: 1,   // N1: (1)
    2: 2,   // N2: (2) - 3-1
    3: 3,   // N3: (3) - 6-3
    4: 4,   // N4: (4) - 10-6
    5: 5,   // N5: (5) - 15-10
    6: 6,   // N6: (6) - 21-15
    7: 7,   // N7: (7) - 28-21
    8: 8,   // N8: (8) - 36-28
    9: 9,   // N9: (9) - 45-36
    10: 10, // N10: (10) - 55-45
  };
  
  // Para níveis acima de 10, o custo é fixo
  static const int xpPerLevelAbove10 = 20;
  static const int favoredXPPerLevelAbove10 = 15;
  
  /// Calcula o custo de XP para aumentar uma perícia de um nível para outro
  /// Retorna o custo incremental (não acumulado)
  static int getXPCost(int fromLevel, int toLevel, bool isDifficult, bool isFavored) {
    if (fromLevel >= toLevel || toLevel < 1) return 0;
    if (fromLevel < 0) fromLevel = 0;
    
    int totalCost = 0;
    
    // Calcular custo para cada nível entre fromLevel e toLevel
    for (int level = fromLevel + 1; level <= toLevel; level++) {
      int levelCost;
      
      if (level > 10) {
        // Níveis acima de 10
        levelCost = isFavored ? favoredXPPerLevelAbove10 : xpPerLevelAbove10;
      } else {
        // Níveis de 1 a 10
        if (isDifficult) {
          levelCost = isFavored 
              ? (difficultFavoredXPPerLevel[level] ?? 0)
              : (difficultXPPerLevel[level] ?? 0);
        } else {
          levelCost = isFavored 
              ? (commonFavoredXPPerLevel[level] ?? 0)
              : (commonXPPerLevel[level] ?? 0);
        }
      }
      
      totalCost += levelCost;
    }
    
    return totalCost;
  }
  
  /// Calcula o custo total de XP para alcançar um nível específico (acumulado)
  static int getTotalXPCost(int level, bool isDifficult, bool isFavored) {
    if (level <= 0) return 0;
    if (level > 10) {
      // Para níveis acima de 10, calcular: custo até 10 + (nível - 10) * custo por nível
      int costTo10 = getTotalXPCost(10, isDifficult, isFavored);
      int levelsAbove10 = level - 10;
      int costPerLevel = isFavored ? favoredXPPerLevelAbove10 : xpPerLevelAbove10;
      return costTo10 + (levelsAbove10 * costPerLevel);
    }
    
    if (isDifficult) {
      return isFavored 
          ? (difficultFavoredXPCumulative[level] ?? 0)
          : (difficultXPCumulative[level] ?? 0);
    } else {
      return isFavored 
          ? (commonFavoredXPCumulative[level] ?? 0)
          : (commonXPCumulative[level] ?? 0);
    }
  }
}

class SkillDefinition {
  final String name;
  final String attr;
  final double divisor;
  final bool isDifficult;

  const SkillDefinition({
    required this.name,
    required this.attr,
    this.divisor = 1,
    this.isDifficult = false,
  });

  String get attrLabel =>
      divisor == 1 ? attr : '$attr/${divisor.toInt()}';
}

const Map<String, List<SkillDefinition>> skillCatalog = {
  'Corporais': [
    SkillDefinition(name: 'Atletismo', attr: 'FIS'),
    SkillDefinition(name: 'Briga', attr: 'REF'),
    SkillDefinition(name: 'Esgrima', attr: 'REF'),
    SkillDefinition(name: 'Hasta', attr: 'REF'),
    SkillDefinition(name: 'Malha', attr: 'FIS'),
    SkillDefinition(
      name: 'Resistência',
      attr: 'FIS',
      divisor: 2,
      isDifficult: true,
    ),
  ],
  'Subterfúgios': [
    SkillDefinition(name: 'Agilidade', attr: 'REF'),
    SkillDefinition(name: 'Arqueria', attr: 'REF', divisor: 2),
    SkillDefinition(name: 'Balística', attr: 'REF', divisor: 2),
    SkillDefinition(name: 'Percepção', attr: 'REF'),
    SkillDefinition(name: 'Furtividade', attr: 'REF'),
    SkillDefinition(name: 'Ladinagem', attr: 'REF'),
  ],
  'Conhecimentos': [
    SkillDefinition(name: 'Arcanismo', attr: 'COG', isDifficult: true),
    SkillDefinition(name: 'Erudição', attr: 'COG'),
    SkillDefinition(name: 'Orientação', attr: 'COG'),
    SkillDefinition(name: 'Cronociência', attr: 'COG', isDifficult: true),
    SkillDefinition(name: 'Medicina', attr: 'COG'),
    SkillDefinition(name: 'Sobrevivência', attr: 'COG', divisor: 2),
  ],
  'Ofícios': [
    SkillDefinition(name: 'Alquimia', attr: 'COG', isDifficult: true),
    SkillDefinition(name: 'Artesão', attr: 'FIS'),
    SkillDefinition(name: 'Engenharia', attr: 'COG', isDifficult: true),
    SkillDefinition(name: 'Armeiro', attr: 'FIS', isDifficult: true),
    SkillDefinition(name: 'Condução', attr: 'FIS'),
    SkillDefinition(name: 'Extração', attr: 'FIS'),
  ],
  'Sociais': [
    SkillDefinition(name: 'Artimanha', attr: 'EGO'),
    SkillDefinition(name: 'Domar', attr: 'EGO'),
    SkillDefinition(name: 'Imposição', attr: 'EGO'),
    SkillDefinition(name: 'Bardismo', attr: 'EGO', isDifficult: true),
    SkillDefinition(name: 'Expressão', attr: 'EGO'),
    SkillDefinition(name: 'Sedução', attr: 'EGO'),
  ],
  'Espirituais': [
    SkillDefinition(name: 'Âmago', attr: 'ESP', divisor: 2, isDifficult: true),
    SkillDefinition(name: 'Druidismo', attr: 'ESP', isDifficult: true),
    SkillDefinition(name: 'Ontologia', attr: 'ESP', divisor: 2),
    SkillDefinition(name: 'Aoísmo', attr: 'ESP', isDifficult: true),
    SkillDefinition(name: 'Elementalismo', attr: 'ESP', isDifficult: true),
    SkillDefinition(name: 'Sabaksismo', attr: 'ESP', isDifficult: true),
  ],
};

class CharacterScreen extends StatefulWidget {
  final String defaultTitle;
  final CharacterData? characterData;
  const CharacterScreen({
    super.key,
    this.defaultTitle = 'Unknown Persona',
    this.characterData,
  });

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final _nameController = TextEditingController();
  final _xpController = TextEditingController();
  final _ptsController = TextEditingController();
  final _malefController = TextEditingController();
  final _benefController = TextEditingController();

  // Biografia
  final _idadeController = TextEditingController();
  final _nascController = TextEditingController();
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();
  final _aparenciaController = TextEditingController();
  final _comportamentoController = TextEditingController();
  final _objetivosController = TextEditingController();
  final _biografiaController = TextEditingController();

  String _origin = '';
  String _culture = '';
  String _persona = '';
  int _malefSum = 0;
  int _benefSum = 0;
  OriginSelectionResult? _originSelection;

  int fis = 0;
  int refx = 0;
  int ego = 0;
  int cog = 0;
  int esp = 0;
  
  // Movimentação baseada na origem
  int _baseMovement = 0;

  final Map<String, int> _skillRanks = {};
  final Map<String, int> _skillModifiers = {};
  final Set<String> _favoredSkills = {}; // Perícias favorecidas

  // Inventário
  final List<SelectedArmament> _armamentos = [];
  final List<String> _vestimentas = [];
  final List<SelectedItem> _itens = [];

  // Habilidades
  // Técnicas divididas por categoria
  final List<String> _tecnicasCorpoACorpo = [];
  final List<String> _tecnicasDistancia = [];
  final List<String> _tecnicasOutras = [];
  final List<SelectedFightingStyle> _estilosLuta = [];
  final List<SelectedPower> _poderes = [];

  // Imagem do personagem
  File? _characterImage;

  // Storage
  final CharacterStorage _storage = CharacterStorage();

  // PDF Fonts
  pw.Font? _pdfFontRegular;
  pw.Font? _pdfFontBold;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    
    // Inicializar XP com valor padrão de 50 se não houver dados carregados
    if (widget.characterData == null && _xpController.text.isEmpty) {
      _xpController.text = '50';
    }
    
    // Carregar dados se characterData foi fornecido
    if (widget.characterData != null) {
      _loadCharacterData(widget.characterData!);
    }
    _loadPdfFonts(); // Carregar fontes para PDF
  }

  // Carregar fontes para PDF
  Future<void> _loadPdfFonts() async {
    try {
      final fontDataRegular = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
      final fontDataBold = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
      _pdfFontRegular = pw.Font.ttf(fontDataRegular);
      _pdfFontBold = pw.Font.ttf(fontDataBold);
    } catch (e) {
      print('Erro ao carregar fontes PDF: $e');
    }
  }

  void _loadCharacterData(CharacterData data) {
    _nameController.text = data.name;
    // Se o XP salvo estiver vazio, usar 50 como padrão
    _xpController.text = data.xp.isEmpty ? '50' : data.xp;
    _ptsController.text = data.pts;
    _origin = data.origin;
    _culture = data.culture;
    _persona = data.persona;
    _malefController.text = data.maleficios;
    _benefController.text = data.beneficios;
    _malefSum = data.malefSum;
    _benefSum = data.benefSum;
    
    fis = data.fis;
    refx = data.refx;
    ego = data.ego;
    cog = data.cog;
    esp = data.esp;
    
    _skillRanks.clear();
    _skillRanks.addAll(data.skillRanks);
    _skillModifiers.clear();
    _skillModifiers.addAll(data.skillModifiers);
    _favoredSkills.clear();
    _favoredSkills.addAll(data.favoredSkills);
    
    _armamentos.clear();
    // Converter strings para SelectedArmament
    _armamentos.addAll(data.armamentos.map((a) => SelectedArmament.fromStorageString(a)));
    _vestimentas.clear();
    _vestimentas.addAll(data.vestimentas);
    _itens.clear();
    // Converter strings para SelectedItem
    _itens.addAll(data.itens.map((i) => SelectedItem.fromStorageString(i)));
    
    _tecnicasCorpoACorpo.clear();
    _tecnicasCorpoACorpo.addAll(data.tecnicasCorpoACorpo);
    _tecnicasDistancia.clear();
    _tecnicasDistancia.addAll(data.tecnicasDistancia);
    _tecnicasOutras.clear();
    _tecnicasOutras.addAll(data.tecnicasOutras);
    _estilosLuta.clear();
    // Converter strings para SelectedFightingStyle
    _estilosLuta.addAll(data.estilosLuta.map((e) => SelectedFightingStyle.fromStorageString(e)));
    _poderes.clear();
    // Converter strings para SelectedPower
    _poderes.addAll(data.poderes.map((p) => SelectedPower.fromStorageString(p)));
    
    _idadeController.text = data.idade;
    _nascController.text = data.nasc;
    _alturaController.text = data.altura;
    _pesoController.text = data.peso;
    _aparenciaController.text = data.aparencia;
    _comportamentoController.text = data.comportamento;
    _objetivosController.text = data.objetivos;
    _biografiaController.text = data.biografia;
    
    if (data.imagePath != null) {
      final imageFile = File(data.imagePath!);
      if (imageFile.existsSync()) {
        _characterImage = imageFile;
      }
    }
    
    // Carregar origem se necessário (sem aplicar modificadores, pois já estão salvos)
    if (data.origin.isNotEmpty) {
      for (final entry in originCatalog.entries) {
        for (final subtype in entry.value) {
          if (data.origin.contains(subtype.name)) {
            _originSelection = OriginSelectionResult(
              origin: entry.key,
              subtype: subtype,
            );
            // Definir movimentação baseada na origem carregada
            _baseMovement = _getMovementByOrigin(entry.key);
            break;
          }
        }
      }
    }
    
    setState(() {}); // Atualizar UI após carregar dados
  }

  Future<void> _saveCharacter() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira um nome para o personagem'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final character = CharacterData(
      name: _nameController.text.trim(),
      xp: _xpController.text,
      pts: _ptsController.text,
      origin: _origin,
      culture: _culture,
      persona: _persona,
      maleficios: _malefController.text,
      beneficios: _benefController.text,
      malefSum: _malefSum,
      benefSum: _benefSum,
      fis: fis,
      refx: refx,
      ego: ego,
      cog: cog,
      esp: esp,
      skillRanks: Map<String, int>.from(_skillRanks),
      skillModifiers: Map<String, int>.from(_skillModifiers),
      favoredSkills: Set<String>.from(_favoredSkills),
      armamentos: _armamentos.map((a) => a.toStorageString()).toList(),
      vestimentas: List<String>.from(_vestimentas),
      itens: _itens.map((i) => i.toStorageString()).toList(),
      tecnicasCorpoACorpo: List<String>.from(_tecnicasCorpoACorpo),
      tecnicasDistancia: List<String>.from(_tecnicasDistancia),
      tecnicasOutras: List<String>.from(_tecnicasOutras),
      estilosLuta: _estilosLuta.map((e) => e.toStorageString()).toList(),
      poderes: _poderes.map((p) => p.toStorageString()).toList(),
      idade: _idadeController.text,
      nasc: _nascController.text,
      altura: _alturaController.text,
      peso: _pesoController.text,
      aparencia: _aparenciaController.text,
      comportamento: _comportamentoController.text,
      objetivos: _objetivosController.text,
      biografia: _biografiaController.text,
      imagePath: _characterImage?.path,
      createdAt: widget.characterData?.createdAt ?? DateTime.now(),
    );

    final saved = await _storage.saveCharacter(character);
    if (saved) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Personagem salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar personagem'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Função para normalizar texto e evitar caracteres Unicode problemáticos
  String _normalizeText(String text) {
    return text
        .replaceAll('–', '-') // En-dash para hífen
        .replaceAll('—', '-') // Em-dash para hífen
        .replaceAll('"', '"') // Aspas curvas para retas
        .replaceAll('"', '"')
        .replaceAll(''', "'") // Aspas simples curvas
        .replaceAll(''', "'");
  }

  Future<void> _exportToPdf() async {
    try {
      // Aguardar carregamento das fontes se ainda não foram carregadas
      if (_pdfFontRegular == null || _pdfFontBold == null) {
        await _loadPdfFonts();
      }

      // Obter bytes da imagem se existir
      Uint8List? imageBytes;
      if (_characterImage != null && File(_characterImage!.path).existsSync()) {
        try {
          imageBytes = Uint8List.fromList(File(_characterImage!.path).readAsBytesSync());
        } catch (e) {
          print('Erro ao carregar imagem para PDF: $e');
          imageBytes = null;
        }
      }

      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          theme: _pdfFontRegular != null && _pdfFontBold != null
              ? pw.ThemeData.withFont(
                  base: _pdfFontRegular!,
                  bold: _pdfFontBold!,
                )
              : null,
          build: (context) {
            return [
              _buildPdfHeaderNew(imageBytes),
              pw.SizedBox(height: 12),
              _buildPdfNameAndBackground(),
              pw.SizedBox(height: 12),
              _buildPdfAttributesAndStatus(),
              pw.SizedBox(height: 12),
              _buildPdfSkillsBlock(),
              pw.SizedBox(height: 12),
              _buildPdfAbilitiesSection(),
              pw.SizedBox(height: 12),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: _buildPdfWeaponsSection(),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Expanded(
                    flex: 2,
                    child: _buildPdfInventorySectionNew(),
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              _buildPdfPassivesSection(),
            ];
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF gerado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Cabeçalho "Pars Crucis" + "Ficha de personagem"
  pw.Widget _buildPdfHeaderNew(Uint8List? imageBytes) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey200,
        border: pw.Border.all(width: 1.5),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          // Título centralizado
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                _normalizeText('Pars Crucis'),
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                _normalizeText('Ficha de personagem'),
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bloco: Nome, raça, cultura, persona e fundo histórico
  pw.Widget _buildPdfNameAndBackground() {
    final nome = _normalizeText(_nameController.text.isEmpty ? 'Sem nome' : _nameController.text);
    final raca = _normalizeText(_origin.isEmpty ? 'Sem origem' : _origin);
    final cultura = _normalizeText(_culture.isEmpty ? 'Sem cultura' : _culture);
    final persona = _normalizeText(_persona.isEmpty ? 'Sem persona' : _persona);
    final fundoHistorico = _normalizeText(_biografiaController.text.isEmpty ? 'Sem fundo histórico' : _biografiaController.text);
    final xp = _normalizeText(_xpController.text.isEmpty ? '0' : _xpController.text);

    // Obter bytes da imagem se existir
    Uint8List? imageBytes;
    if (_characterImage != null && File(_characterImage!.path).existsSync()) {
      try {
        imageBytes = Uint8List.fromList(File(_characterImage!.path).readAsBytesSync());
      } catch (e) {
        print('Erro ao carregar imagem para PDF: $e');
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(width: 1.5),
            borderRadius: pw.BorderRadius.circular(4),
            color: PdfColors.grey100,
          ),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              // Imagem do personagem à esquerda (se disponível)
              if (imageBytes != null)
                pw.Container(
                  width: 70,
                  height: 70,
                  margin: const pw.EdgeInsets.only(right: 12),
                  decoration: pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    border: pw.Border.all(width: 2, color: PdfColors.black),
                  ),
                  child: pw.ClipOval(
                    child: pw.Image(
                      pw.MemoryImage(imageBytes),
                      fit: pw.BoxFit.cover,
                    ),
                  ),
                ),
              // Informações do personagem centralizadas
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      nome,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 4),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Raça: $raca',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(width: 12),
                        pw.Text(
                          'Cultura: $cultura',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(width: 12),
                        pw.Text(
                          'Persona: $persona',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey300,
                  borderRadius: pw.BorderRadius.circular(4),
                  border: pw.Border.all(width: 1),
                ),
                child: pw.Text(
                  'XP: $xp',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Bloco dos atributos - Layout conforme imagem
  pw.Widget _buildPdfAttributesAndStatus() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.5),
        borderRadius: pw.BorderRadius.circular(4),
        color: PdfColors.grey100,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              borderRadius: pw.BorderRadius.circular(2),
            ),
            child: pw.Text(
              'ATRIBUTOS',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildPdfAttributeColumn('FIS', _attrValue('FIS')),
              _buildPdfAttributeColumn('REF', _attrValue('REF')),
              _buildPdfAttributeColumn('EGO', _attrValue('EGO')),
              _buildPdfAttributeColumn('COG', _attrValue('COG')),
              _buildPdfAttributeColumn('ESP', _attrValue('ESP')),
            ],
          ),
        ],
      ),
    );
  }

  // Coluna individual de atributo conforme imagem
  pw.Widget _buildPdfAttributeColumn(String attrAbbr, int attrValue) {
    // Modificador do atributo (por enquanto sempre 0, pode ser expandido depois)
    final modifier = 0;
    // Soma: 10 + atributo
    final sum = 10 + attrValue;
    
    return pw.Container(
      width: 50,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          // Abreviação no topo
          pw.Text(
            attrAbbr,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
          pw.SizedBox(height: 4),
          // Container com número grande e números pequenos à direita
          pw.Container(
            padding: const pw.EdgeInsets.all(4),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              border: pw.Border.all(width: 0.5, color: PdfColors.black),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Número grande (valor do atributo)
                pw.Text(
                  attrValue.toString(),
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(width: 4),
                // Dois números pequenos à direita
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    // Modificador (topo)
                    pw.Text(
                      modifier >= 0 ? '+$modifier' : '$modifier',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontStyle: pw.FontStyle.italic,
                        color: PdfColors.black,
                      ),
                    ),
                    // Soma 10 + atributo (abaixo)
                    pw.Text(
                      sum.toString(),
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontStyle: pw.FontStyle.italic,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.TableRow _buildPdfAttrRowHeader() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(
        color: PdfColors.grey300,
      ),
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            'Atributo',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            'Valor',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            'Max',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            'Atual',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  pw.TableRow _buildPdfAttrRow(String name, int value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            name,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(
              value.toString(),
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            value.toString(),
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            value.toString(),
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPdfMiniStatBox(String label, String value, PdfColor? backgroundColor) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1),
        borderRadius: pw.BorderRadius.circular(3),
        color: backgroundColor ?? PdfColors.white,
      ),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            '$label: ',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Seção de Armamentos
  pw.Widget _buildPdfWeaponsSection() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.5),
        borderRadius: pw.BorderRadius.circular(4),
        color: PdfColors.grey100,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              borderRadius: pw.BorderRadius.circular(2),
            ),
            child: pw.Text(
              'ARMAMENTOS',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(width: 1, color: PdfColors.black),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(1.5),
              3: const pw.FlexColumnWidth(1.5),
              4: const pw.FlexColumnWidth(2),
              5: const pw.FlexColumnWidth(1.5),
              6: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                children: [
                  _buildPdfTableHeader('Arma'),
                  _buildPdfTableHeader('Perícia'),
                  _buildPdfTableHeader('Ação'),
                  _buildPdfTableHeader('M'),
                  _buildPdfTableHeader('Danos'),
                  _buildPdfTableHeader('Alc'),
                  _buildPdfTableHeader('Anotações'),
                ],
              ),
              // Preencher com armamentos se houver
              ...(_armamentos.isEmpty
                  ? List.generate(
                      4,
                      (_) => pw.TableRow(
                        children: List.generate(
                          7,
                          (_) => pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text(''),
                          ),
                        ),
                      ),
                    )
                  : _armamentos.take(4).map((arma) {
                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text(
                              _normalizeText(arma.item),
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text('', style: const pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text('', style: const pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text('', style: const pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text('', style: const pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text('', style: const pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text('', style: const pw.TextStyle(fontSize: 8)),
                          ),
                        ],
                      );
                    }).toList()),
            ],
          ),
        ],
      ),
    );
  }

  // Bloco de perícias completo - 3 colunas
  pw.Widget _buildPdfSkillsBlock() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.5),
        borderRadius: pw.BorderRadius.circular(4),
        color: PdfColors.grey100,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              borderRadius: pw.BorderRadius.circular(2),
            ),
            child: pw.Text(
              'PERÍCIAS',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          // Layout em 3 colunas
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Coluna 1: Corporais e Conhecimentos
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfSkillCategoryCompact(
                      title: 'CORPORAIS',
                      skills: [
                        ['Atletismo', 'FIS', false, 1.0],
                        ['Briga', 'REF', false, 1.0],
                        ['Esgrima', 'REF', false, 1.0],
                        ['Hasta', 'REF', false, 1.0],
                        ['Malha', 'FIS', false, 1.0],
                        ['Resistência', 'FIS', true, 0.5],
                      ],
                    ),
                    _buildPdfSkillCategoryCompact(
                      title: 'CONHECIMENTOS',
                      skills: [
                        ['Arcanismo', 'COG', true, 1.0],
                        ['Cronociência', 'COG', true, 1.0],
                        ['Erudição', 'COG', false, 1.0],
                        ['Medicina', 'COG', false, 1.0],
                        ['Orientação', 'COG', false, 1.0],
                        ['Sobrevivência', 'COG', false, 0.5],
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 4),
              // Coluna 2: Sociais e Subterfúgios
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfSkillCategoryCompact(
                      title: 'SOCIAIS',
                      skills: [
                        ['Artimanha', 'EGO', false, 1.0],
                        ['Bardismo', 'EGO', true, 1.0],
                        ['Domar', 'EGO', false, 1.0],
                        ['Expressão', 'EGO', false, 1.0],
                        ['Imposição', 'EGO', false, 1.0],
                        ['Sedução', 'EGO', false, 1.0],
                      ],
                    ),
                    _buildPdfSkillCategoryCompact(
                      title: 'SUBTERFÚGIOS',
                      skills: [
                        ['Agilidade', 'REF', false, 1.0],
                        ['Arqueria', 'REF', false, 0.5],
                        ['Balística', 'REF', false, 0.5],
                        ['Furtividade', 'REF', false, 1.0],
                        ['Ladinagem', 'REF', false, 1.0],
                        ['Percepção', 'REF', false, 1.0],
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 4),
              // Coluna 3: Ofícios e Espirituais
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildPdfSkillCategoryCompact(
                      title: 'OFÍCIOS',
                      skills: [
                        ['Alquimia', 'COG', true, 1.0],
                        ['Armeiro', 'FIS', true, 1.0],
                        ['Artesão', 'FIS', false, 1.0],
                        ['Condução', 'FIS', false, 1.0],
                        ['Engenharia', 'COG', true, 1.0],
                        ['Extração', 'FIS', false, 1.0],
                      ],
                    ),
                    _buildPdfSkillCategoryCompact(
                      title: 'ESPIRITUAIS',
                      skills: [
                        ['Âmago', 'ESP', true, 0.5],
                        ['Aoísmo', 'ESP', true, 1.0],
                        ['Druidismo', 'ESP', true, 1.0],
                        ['Elementalismo', 'ESP', true, 1.0],
                        ['Ontologia', 'ESP', false, 0.5],
                        ['Sabaksismo', 'ESP', true, 1.0],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Versão compacta da categoria de perícias - Layout conforme imagem
  pw.Widget _buildPdfSkillCategoryCompact({
    required String title,
    required List<List<dynamic>> skills, // [nome, atributo, isDifficult, divisor]
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      margin: const pw.EdgeInsets.only(bottom: 6),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1, color: PdfColors.black),
        borderRadius: pw.BorderRadius.circular(2),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Cabeçalho: Título à esquerda, N e M centralizados à direita
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Row(
                children: [
                  // Coluna N
                  pw.Container(
                    width: 20,
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'N',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  // Coluna M
                  pw.Container(
                    width: 20,
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'M',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Linha separadora
          pw.Container(
            height: 0.5,
            color: PdfColors.black,
            margin: const pw.EdgeInsets.symmetric(vertical: 2),
          ),
        // Lista de perícias
        ...skills.map((skillData) {
          final skillName = skillData[0] as String;
          final attr = skillData[1] as String;
          final isDifficult = skillData[2] as bool;
          final divisor = skillData[3] as double;
          
          final n = _skillRanks[skillName] ?? 0; // Nível
          final m = _skillModifiers[skillName] ?? 0; // Modificador
          
          // Montar atributo abreviado
          String attrLabel = divisor == 1.0 ? attr : '$attr/${divisor.toInt()}';
          
          // Formato do modificador
          String modifierDisplay = m >= 0 ? '+$m' : '$m';
          
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 2),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Lado esquerdo: Nome da perícia
                pw.Expanded(
                  child: pw.Text(
                    _normalizeText(skillName.toUpperCase()),
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                // Lado direito: Atributo próximo ao N, depois N e M em colunas separadas
                pw.Row(
                  children: [
                    // Atributo próximo ao N
                    pw.Text(
                      attrLabel,
                      style: const pw.TextStyle(fontSize: 7),
                    ),
                    pw.SizedBox(width: 4),
                    // Coluna N
                    pw.Container(
                      width: 20,
                      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey200,
                        border: pw.Border.all(width: 0.5, color: PdfColors.black),
                      ),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        n.toString(),
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 2),
                    // Coluna M
                    pw.Container(
                      width: 20,
                      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey200,
                        border: pw.Border.all(width: 0.5, color: PdfColors.black),
                      ),
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        modifierDisplay,
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
        ],
      ),
    );
  }

  // Seção de Inventário
  pw.Widget _buildPdfInventorySectionNew() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.5),
        borderRadius: pw.BorderRadius.circular(4),
        color: PdfColors.grey100,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              borderRadius: pw.BorderRadius.circular(2),
            ),
            child: pw.Text(
              'INVENTÁRIO',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(width: 1, color: PdfColors.black),
            columnWidths: {
              0: const pw.FlexColumnWidth(5),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                children: [
                  _buildPdfTableHeader('Item / Observações'),
                  _buildPdfTableHeader('Quantia'),
                ],
              ),
              // Combinar todos os itens do inventário
              ..._buildPdfInventoryRows(),
            ],
          ),
        ],
      ),
    );
  }

  List<pw.TableRow> _buildPdfInventoryRows() {
    final allItems = <String>[];
    allItems.addAll(_armamentos.map((a) => 'Armamento: ${a.item}'));
    allItems.addAll(_vestimentas.map((v) => 'Vestimenta: $v'));
    allItems.addAll(_itens.map((i) => 'Item: ${i.item}'));

    if (allItems.isEmpty) {
      return List.generate(
        6,
        (_) => pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(''),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(''),
            ),
          ],
        ),
      );
    }

    return allItems.take(6).map((item) {
      return pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              _normalizeText(item),
              style: const pw.TextStyle(fontSize: 8),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text('', style: const pw.TextStyle(fontSize: 8)),
          ),
        ],
      );
    }).toList();
  }

  // Seção de Habilidades (Técnicas e Poderes) - Layout similar às Perícias
  pw.Widget _buildPdfAbilitiesSection() {
    final hasTecnicas = _tecnicasCorpoACorpo.isNotEmpty ||
        _tecnicasDistancia.isNotEmpty ||
        _tecnicasOutras.isNotEmpty ||
        _estilosLuta.isNotEmpty;
    final hasPoderes = _poderes.isNotEmpty;
    
    if (!hasTecnicas && !hasPoderes) {
      return pw.SizedBox.shrink();
    }
    
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.5),
        borderRadius: pw.BorderRadius.circular(4),
        color: PdfColors.grey100,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              borderRadius: pw.BorderRadius.circular(2),
            ),
            child: pw.Text(
              'HABILIDADES',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          // Layout em 3 colunas similar às perícias
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Coluna 1
              pw.Expanded(
                child: _buildPdfAbilitiesColumn1(),
              ),
              pw.SizedBox(width: 4),
              // Coluna 2
              pw.Expanded(
                child: _buildPdfAbilitiesColumn2(),
              ),
              pw.SizedBox(width: 4),
              // Coluna 3
              pw.Expanded(
                child: _buildPdfAbilitiesColumn3(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Coluna 1: Estilos de Luta, Técnicas Corpo a Corpo e A Distância (se houver), depois poderes
  pw.Widget _buildPdfAbilitiesColumn1() {
    final List<pw.Widget> widgets = [];
    
    // Estilos de Luta
    if (_estilosLuta.isNotEmpty) {
      for (final style in _estilosLuta) {
        final strikes = style.selectedStrikes;
        widgets.add(_buildPdfFightingStyle(style.styleName, strikes));
      }
    }
    
    if (_tecnicasCorpoACorpo.isNotEmpty) {
      widgets.add(_buildPdfTechniqueCategory('CORPO A CORPO', _tecnicasCorpoACorpo));
    }
    if (_tecnicasDistancia.isNotEmpty) {
      widgets.add(_buildPdfTechniqueCategory('A DISTÂNCIA', _tecnicasDistancia));
    }
    
    // Adicionar poderes se ainda houver espaço
    final powerWidgets = _buildPdfPowerCategories();
    if (powerWidgets.isNotEmpty) {
      widgets.addAll(powerWidgets.take(2)); // Máximo 2 categorias de poderes na coluna 1
    }
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: widgets,
    );
  }

  // Coluna 2: Outras Técnicas (se houver), depois poderes
  pw.Widget _buildPdfAbilitiesColumn2() {
    final List<pw.Widget> widgets = [];
    
    if (_tecnicasOutras.isNotEmpty) {
      widgets.add(_buildPdfTechniqueCategory('OUTRAS', _tecnicasOutras));
    }
    
    // Adicionar poderes
    final powerWidgets = _buildPdfPowerCategories();
    final startIndex = _tecnicasCorpoACorpo.isNotEmpty || _tecnicasDistancia.isNotEmpty ? 2 : 0;
    if (powerWidgets.length > startIndex) {
      widgets.addAll(powerWidgets.skip(startIndex).take(3)); // Próximas 3 categorias
    }
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: widgets,
    );
  }

  // Coluna 3: Resto dos poderes
  pw.Widget _buildPdfAbilitiesColumn3() {
    final List<pw.Widget> widgets = [];
    
    // Adicionar poderes restantes
    final powerWidgets = _buildPdfPowerCategories();
    final startIndex = _tecnicasCorpoACorpo.isNotEmpty || _tecnicasDistancia.isNotEmpty ? 5 : 3;
    if (powerWidgets.length > startIndex) {
      widgets.addAll(powerWidgets.skip(startIndex));
    }
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: widgets,
    );
  }

  // Estilo de luta no PDF
  pw.Widget _buildPdfFightingStyle(String styleName, List<String> strikes) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      margin: const pw.EdgeInsets.only(bottom: 6),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1, color: PdfColors.black),
        borderRadius: pw.BorderRadius.circular(2),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            _normalizeText(styleName),
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          if (strikes.isNotEmpty) ...[
            pw.Container(
              height: 0.5,
              color: PdfColors.black,
              margin: const pw.EdgeInsets.symmetric(vertical: 2),
            ),
            ...strikes.map((strike) {
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 2),
                child: pw.Text(
                  _normalizeText(strike.toUpperCase()),
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  // Categoria de técnica (similar ao formato de perícias)
  pw.Widget _buildPdfTechniqueCategory(String title, List<String> tecnicas) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      margin: const pw.EdgeInsets.only(bottom: 6),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1, color: PdfColors.black),
        borderRadius: pw.BorderRadius.circular(2),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            _normalizeText(title),
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Container(
            height: 0.5,
            color: PdfColors.black,
            margin: const pw.EdgeInsets.symmetric(vertical: 2),
          ),
          ...tecnicas.map((tecnica) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 2),
              child: pw.Text(
                _normalizeText(tecnica.toUpperCase()),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Lista de categorias de poderes (cada uma com subdivisão)
  List<pw.Widget> _buildPdfPowerCategories() {
    // Agrupar poderes por categoria e depois por subdivisão
    final Map<String, Map<String, List<SelectedPower>>> grouped = {};
    
    for (final power in _poderes) {
      if (!grouped.containsKey(power.category)) {
        grouped[power.category] = {};
      }
      if (!grouped[power.category]!.containsKey(power.dativa)) {
        grouped[power.category]![power.dativa] = [];
      }
      grouped[power.category]![power.dativa]!.add(power);
    }
    
    final List<pw.Widget> widgets = [];
    
    grouped.forEach((category, dativas) {
      dativas.forEach((dativa, powers) {
        widgets.add(
          pw.Container(
            padding: const pw.EdgeInsets.all(4),
            margin: const pw.EdgeInsets.only(bottom: 6),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1, color: PdfColors.black),
              borderRadius: pw.BorderRadius.circular(2),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  _normalizeText(dativa.toUpperCase()),
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Container(
                  height: 0.5,
                  color: PdfColors.black,
                  margin: const pw.EdgeInsets.symmetric(vertical: 2),
                ),
                pw.Text(
                  _normalizeText(category.toUpperCase()),
                  style: pw.TextStyle(
                    fontSize: 7,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
                ...powers.map((power) {
                  return pw.Container(
                    margin: const pw.EdgeInsets.only(bottom: 2),
                    child: pw.Text(
                      _normalizeText(power.power.toUpperCase()),
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      });
    });
    
    return widgets;
  }

  pw.Widget _buildPdfPassivesSection() {
    // Combinar benefícios e malefícios
    final allPassives = <String>[];
    
    if (_benefController.text.isNotEmpty) {
      final beneficios = _benefController.text.split('\n');
      allPassives.addAll(beneficios.map((b) => _normalizeText(b)));
    }
    
    if (_malefController.text.isNotEmpty) {
      final maleficios = _malefController.text.split('\n');
      allPassives.addAll(maleficios.map((m) => _normalizeText(m)));
    }

    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.5),
        borderRadius: pw.BorderRadius.circular(4),
        color: PdfColors.grey100,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              borderRadius: pw.BorderRadius.circular(2),
            ),
            child: pw.Text(
              'PASSIVAS',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(width: 1, color: PdfColors.black),
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(6),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                children: [
                  _buildPdfTableHeader('PT'),
                  _buildPdfTableHeader('Descrição e observações'),
                ],
              ),
              ...(allPassives.isEmpty
                  ? List.generate(
                      6,
                      (_) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text(''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text(''),
                          ),
                        ],
                      ),
                    )
                  : allPassives.take(6).map((passive) {
                      // Extrair pontos se houver [↑XPTS] ou [↓XPTS]
                      final regex = RegExp(r'\[([↑↓])(\d+)PTS\]');
                      final match = regex.firstMatch(passive);
                      final pts = match != null ? match.group(2) : '';
                      final desc = passive.replaceAll(RegExp(r'\s*\[[↑↓]\d+PTS\]'), '');

                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text(
                              pts ?? '',
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.Text(
                              desc,
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ),
                        ],
                      );
                    }).toList()),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfTableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(2),
      child: pw.Text(
        _normalizeText(text),
        style: pw.TextStyle(
          fontSize: 8,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  int _calculateMV() {
    // Movimentação é fixa e definida apenas pela origem
    return _baseMovement;
  }

  int _calculateDEF() {
    final ref = _attrValue('REF');
    return ref;
  }

  int _calculateRET() {
    final fis = _attrValue('FIS');
    final ego = _attrValue('EGO');
    return ((fis + ego) / 2).floor();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _xpController.dispose();
    _ptsController.dispose();
    _malefController.dispose();
    _benefController.dispose();
    _idadeController.dispose();
    _nascController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    _aparenciaController.dispose();
    _comportamentoController.dispose();
    _objetivosController.dispose();
    _biografiaController.dispose();
    super.dispose();
  }

  void _applyOriginModifiers(Map<String, int> modifiers, String originName) {
    // Primeiro reseta todos os atributos para 0
    fis = 0;
    refx = 0;
    ego = 0;
    cog = 0;
    esp = 0;
    
    // Depois aplica os modificadores da origem
    fis = modifiers['FIS'] ?? 0;
    refx = modifiers['REF'] ?? 0;
    ego = modifiers['EGO'] ?? 0;
    cog = modifiers['COG'] ?? 0;
    esp = modifiers['ESP'] ?? 0;
    
    // Define movimentação baseada na origem
    _baseMovement = _getMovementByOrigin(originName);
  }
  
  // Retorna a movimentação baseada na origem
  int _getMovementByOrigin(String originName) {
    switch (originName) {
      case 'Humano':
        return 3;
      case 'Capríaco':
        return 3;
      case 'Carneador':
        return 3;
      case 'Guará':
        return 4;
      case 'Ligno':
        return 3;
      case 'Orcino':
        return 3;
      case 'Quezal':
        return 3;
      default:
        return 0;
    }
  }

  // Retorna o valor base do atributo (da origem)
  int _getBaseAttrValue(String abbr) {
    switch (abbr.toUpperCase()) {
      case 'FIS':
        return fis;
      case 'REF':
        return refx;
      case 'EGO':
        return ego;
      case 'COG':
        return cog;
      case 'ESP':
        return esp;
      default:
        return 0;
    }
  }

  // Retorna o maior valor de atributo gerado por perícias (considerando divisor)
  int _getMaxSkillLevelForAttr(String attrAbbr) {
    int maxAttrValue = 0;
    for (final entry in skillCatalog.entries) {
      for (final skill in entry.value) {
        if (skill.attr == attrAbbr) {
          final level = _skillRanks[skill.name] ?? 0;
          // Se a perícia tem divisor, o valor do atributo é o nível dividido pelo divisor (arredondado para cima)
          // Se não tem divisor, o valor do atributo é o próprio nível
          final attrValue = skill.divisor > 1 
              ? (level / skill.divisor).ceil()
              : level;
          if (attrValue > maxAttrValue) {
            maxAttrValue = attrValue;
          }
        }
      }
    }
    return maxAttrValue;
  }

  // Retorna o valor final do atributo (maior entre origem e maior nível de perícia)
  int _attrValue(String abbr) {
    final baseValue = _getBaseAttrValue(abbr);
    final maxSkillLevel = _getMaxSkillLevelForAttr(abbr);
    return baseValue > maxSkillLevel ? baseValue : maxSkillLevel;
  }

  // Retorna o nível de uma perícia específica
  int _getSkillLevel(String skillName) {
    return _skillRanks[skillName] ?? 0;
  }
  
  // Encontra a definição de uma perícia pelo nome
  SkillDefinition? _getSkillDefinition(String skillName) {
    for (final entry in skillCatalog.entries) {
      for (final skill in entry.value) {
        if (skill.name == skillName) {
          return skill;
        }
      }
    }
    return null;
  }
  
  // Calcula o XP total gasto em todas as perícias
  int _calculateTotalXPSpent() {
    int totalSpent = 0;
    for (final entry in skillCatalog.entries) {
      for (final skill in entry.value) {
        final level = _skillRanks[skill.name] ?? 0;
        if (level > 0) {
          final isFavored = _favoredSkills.contains(skill.name);
          totalSpent += XPCostTable.getTotalXPCost(level, skill.isDifficult, isFavored);
        }
      }
    }
    
    // Adicionar XP gasto em técnicas corpo a corpo
    for (final techniqueName in _tecnicasCorpoACorpo) {
      final technique = TechniqueCatalog.corpoACorpoTechniques[techniqueName];
      if (technique != null) {
        totalSpent += technique.xpCost;
      }
    }
    
    // Adicionar XP gasto em técnicas à distância
    for (final techniqueName in _tecnicasDistancia) {
      final technique = TechniqueCatalog.distanciaTechniques[techniqueName];
      if (technique != null) {
        totalSpent += technique.xpCost;
      }
    }
    
    // Adicionar XP gasto em estilos de luta e seus golpes
    for (final style in _estilosLuta) {
      // XP do estilo
      final styleTechnique = TechniqueCatalog.fightingStyles[style.styleName];
      if (styleTechnique != null) {
        totalSpent += styleTechnique.xpCost;
      }
      // XP dos golpes selecionados
      for (final strike in style.selectedStrikes) {
        final strikeTechnique = TechniqueCatalog.fightingStyles[strike];
        if (strikeTechnique != null) {
          totalSpent += strikeTechnique.xpCost;
        }
      }
    }
    
    // Adicionar XP gasto em outras técnicas
    for (final techniqueName in _tecnicasOutras) {
      final technique = TechniqueCatalog.outrasTechniques[techniqueName];
      if (technique != null) {
        totalSpent += technique.xpCost;
      }
    }
    
    // Adicionar XP gasto em poderes
    for (final power in _poderes) {
      totalSpent += PowerXPCatalog.getPowerXPCost(power.category, power.dativa, power.power);
    }
    
    return totalSpent;
  }
  
  // Calcula o XP disponível (XP total - XP gasto)
  // Permite XP negativo até -2
  int _getAvailableXP() {
    final xpText = _xpController.text.trim();
    if (xpText.isEmpty) return 50; // Valor padrão
    final totalXP = int.tryParse(xpText) ?? 50;
    final spentXP = _calculateTotalXPSpent();
    final available = totalXP - spentXP;
    // Permite XP negativo até -2
    return available;
  }
  
  // Verifica se pode gastar uma quantidade de XP (permite até -2)
  bool _canAffordXP(int xpCost, int currentAvailableXP) {
    final newAvailable = currentAvailableXP - xpCost;
    return newAvailable >= -2; // Permite até -2 de XP negativo
  }
  
  // Atualiza o campo XP mostrando o disponível
  void _updateXPDisplay() {
    // Não alteramos o valor do campo XP, apenas atualizamos a UI se necessário
    setState(() {});
  }

  // Calcula Pontos de Vida (PV)
  int _calculatePV() {
    final fis = _attrValue('FIS');
    final ego = _attrValue('EGO');
    final resistenciaLevel = _getSkillLevel('Resistência');
    return 25 + (2 * fis) + ego + (2 * resistenciaLevel);
  }

  // Calcula Pontos de Essência (PE)
  int _calculatePE() {
    final cog = _attrValue('COG');
    final esp = _attrValue('ESP');
    final amagoLevel = _getSkillLevel('Âmago');
    return 25 + cog + (2 * esp) + (2 * amagoLevel);
  }

  // Calcula Saúde
  int _calculateSaude() {
    final fis = _attrValue('FIS');
    final ego = _attrValue('EGO');
    return ((fis + ego) / 2).floor();
  }

  // Calcula Esperteza
  int _calculateEsperteza() {
    final ref = _attrValue('REF');
    final cog = _attrValue('COG');
    return ((ref + cog) / 2).floor();
  }

  // Calcula Vontade
  int _calculateVontade() {
    final ego = _attrValue('EGO');
    final esp = _attrValue('ESP');
    return ((ego + esp) / 2).floor();
  }

  @override
  Widget build(BuildContext context) {
    final headerText =
        _nameController.text.isEmpty ? widget.defaultTitle : _nameController.text;

    const double whiteLineHeight = 1,
        topSpacing = 8,
        tabBarHeight = 32,
        bottomSpacing = 16;
    final bottomHeight =
        whiteLineHeight + topSpacing + tabBarHeight + bottomSpacing + whiteLineHeight;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          title: Text(headerText,
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
              onPressed: _exportToPdf,
              tooltip: 'Exportar PDF',
            ),
            IconButton(
              icon: const Icon(Icons.save, color: Colors.white),
              onPressed: _saveCharacter,
              tooltip: 'Salvar Personagem',
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(bottomHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: whiteLineHeight, color: Colors.white),
                const SizedBox(height: topSpacing),
                SizedBox(
                  height: tabBarHeight,
                  child: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    labelStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700, fontSize: 12, height: 1.0),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: const Color(0xFF5B0A16),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tabs: const [
                      Tab(text: 'SOBRE'),
                      Tab(text: 'ATRIBUTOS'),
                      Tab(text: 'PERÍCIAS'),
                      Tab(text: 'INVENTÁRIO'),
                      Tab(text: 'HABILIDADES'),
                      Tab(text: 'BIOGRAFIA'),
                    ],
                  ),
                ),
                const SizedBox(height: bottomSpacing),
                Container(height: whiteLineHeight, color: Colors.white),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/textura_pergaminho.png'),
                fit: BoxFit.cover),
          ),
          child: TabBarView(
            children: [
              _sobreTab(),
              _atributosTab(),
              _periciasTab(),
              _inventarioTab(),
              _habilidadesTab(),
              _biografiaTab(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        // Copiar imagem para diretório permanente
        final appDir = await getApplicationDocumentsDirectory();
        final imagesDir = Directory('${appDir.path}/characters/images');
        if (!await imagesDir.exists()) {
          await imagesDir.create(recursive: true);
        }
        
        // Gerar nome único para a imagem baseado no timestamp
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final imageFileName = 'character_image_$timestamp.jpg';
        final destImagePath = '${imagesDir.path}/$imageFileName';
        
        // Copiar arquivo
        final sourceFile = File(image.path);
        await sourceFile.copy(destImagePath);
        
        // Atualizar com o caminho permanente
        setState(() {
          _characterImage = File(destImagePath);
        });
      } catch (e) {
        print('Erro ao copiar imagem: $e');
        // Se falhar, usar o caminho original
        setState(() {
          _characterImage = File(image.path);
        });
      }
    }
  }

  Widget _sobreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Sobre',
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87)),
          const SizedBox(height: 12),
          // Row com XP/Pontos empilhados à esquerda e imagem à direita
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coluna esquerda: XP em cima, Pontos embaixo
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    _buildInlineField(
                        controller: _xpController,
                        icon: Icons.emoji_events,
                        label: 'Experiência (XP)',
                        numbersOnly: true),
                    // Mostrar XP disponível
                    Builder(
                      builder: (context) {
                        final availableXP = _getAvailableXP();
                        final isNegative = availableXP < 0;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: isNegative 
                                ? (availableXP >= -2 ? Colors.orange.shade50 : Colors.red.shade50)
                                : const Color(0xFFF2E7D6),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isNegative 
                                  ? (availableXP >= -2 ? Colors.orange : Colors.red)
                                  : const Color(0xFF5B0A16), 
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isNegative ? Icons.warning_amber_rounded : Icons.info_outline, 
                                size: 16, 
                                color: isNegative 
                                    ? (availableXP >= -2 ? Colors.orange.shade900 : Colors.red.shade900)
                                    : Colors.grey[700],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'XP Disponível: $availableXP${isNegative ? " (negativo permitido até -2)" : ""}',
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isNegative 
                                        ? (availableXP >= -2 ? Colors.orange.shade900 : Colors.red.shade900)
                                        : Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16), // Aumentado o espaçamento vertical
                    _buildInlineField(
                        controller: _ptsController, icon: Icons.score, label: 'Pontos (PTS)'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Coluna direita: Campo de imagem (altura cobre ambos os campos, largura até o limite)
              Expanded(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 120, // Altura dos dois campos (52 + 16 + 52)
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2E7D6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                    ),
                    child: _characterImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _characterImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                size: 32,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Adicionar Foto',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Seção Informações Básicas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2E7D6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
            ),
            child: Text(
              'INFORMAÇÕES BÁSICAS',
              style: GoogleFonts.cinzel(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: const Color(0xFF412B1D),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _buildLabeledField(
                controller: _nameController, icon: Icons.badge, label: 'Nome da Personagem'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _buildSelectField(
              value: _origin,
              icon: Icons.nature_people,
              label: 'Origem',
              onTap: () async {
                final result = await Navigator.push<OriginSelectionResult>(
                  context,
                  MaterialPageRoute(builder: (_) => const OriginSelectionScreen()),
                );
                if (result != null) {
                  setState(() {
                    _originSelection = result;
                    _origin = result.displayName;
                    _applyOriginModifiers(result.subtype.modifiers, result.origin);
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _buildSelectField(
              value: _culture,
              icon: Icons.public,
              label: 'Cultura',
              onTap: () async {
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (_) => const CultureSelectionScreen()),
                );
                if (result != null) setState(() => _culture = result);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _buildSelectField(
              value: _persona,
              icon: Icons.emoji_emotions,
              label: 'Persona',
              onTap: () async {
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (_) => const PersonaSelectionScreen()),
                );
                if (result != null) {
                  setState(() {
                    _persona = result;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          // Seção Passivas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2E7D6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
            ),
            child: Text(
              'PASSIVAS',
              style: GoogleFonts.cinzel(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: const Color(0xFF412B1D),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: GestureDetector(
              onTap: () async {
                // Extrai os itens já selecionados do controller
                final currentSelected = _malefController.text.isNotEmpty
                    ? _malefController.text.split('\n')
                    : <String>[];
                
                final List<String>? sel = await Navigator.push<List<String>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MaleficiosSelectionScreen(
                      initialSelected: currentSelected,
                    ),
                  ),
                );
                if (sel != null) {
                  final regex = RegExp(r'\[↑(\d+)PTS\]');
                  var sum = 0;
                  for (var item in sel) {
                    final m = regex.firstMatch(item);
                    if (m != null) sum += int.parse(m.group(1)!);
                  }
                  setState(() {
                    _malefController.text = sel.join('\n');
                    _malefSum = sum;
                    _ptsController.text = (_malefSum + _benefSum).toString();
                  });
                }
              },
              child: _buildSelectDisplay(
                label: 'Malefícios',
                icon: Icons.flash_on,
                content: _malefController.text,
                suffix: '+$_malefSum',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: GestureDetector(
              onTap: () async {
                // Extrai os itens já selecionados do controller
                final currentSelected = _benefController.text.isNotEmpty
                    ? _benefController.text.split('\n')
                    : <String>[];
                
                final List<String>? sel = await Navigator.push<List<String>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BeneficiosSelectionScreen(
                      initialSelected: currentSelected,
                    ),
                  ),
                );
                if (sel != null) {
                  final regex = RegExp(r'\[↓(\d+)PTS\]');
                  var sum = 0;
                  for (var item in sel) {
                    final m = regex.firstMatch(item);
                    if (m != null) sum -= int.parse(m.group(1)!);
                  }
                  setState(() {
                    _benefController.text = sel.join('\n');
                    _benefSum = sum;
                    _ptsController.text = (_malefSum + _benefSum).toString();
                  });
                }
              },
              child: _buildSelectDisplay(
                label: 'Benefícios',
                icon: Icons.healing,
                content: _benefController.text,
                suffix: '($_benefSum)',
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _atributosTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAttributeCard('Físico', 'FIS', _attrValue('FIS')),
          const SizedBox(height: 12),
          _buildAttributeCard('Reflexo', 'REF', _attrValue('REF')),
          const SizedBox(height: 12),
          _buildAttributeCard('Ego', 'EGO', _attrValue('EGO')),
          const SizedBox(height: 12),
          _buildAttributeCard('Cognição', 'COG', _attrValue('COG')),
          const SizedBox(height: 12),
          _buildAttributeCard('Espírito', 'ESP', _attrValue('ESP')),
          const SizedBox(height: 30),
          Text(
            'Sub-Atributos',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5B0A16),
            ),
          ),
          const SizedBox(height: 16),
          _buildSubAttributeCard('Pontos de Vida', 'PV', _calculatePV()),
          const SizedBox(height: 12),
          _buildSubAttributeCard('Pontos de Essência', 'PE', _calculatePE()),
          const SizedBox(height: 12),
          _buildSubAttributeCard('Movimentação', null, _calculateMV()),
          const SizedBox(height: 12),
          _buildSubAttributeCard('Saúde', null, _calculateSaude()),
          const SizedBox(height: 12),
          _buildSubAttributeCard('Esperteza', null, _calculateEsperteza()),
          const SizedBox(height: 12),
          _buildSubAttributeCard('Vontade', null, _calculateVontade()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAttributeCard(String full, String abbr, int value) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFF5B0A16)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  full,
                  style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF5B0A16)),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  abbr,
                  style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF5B0A16)),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Container()),
          Text(
            value.toString(),
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSubAttributeCard(String full, String? abbr, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              abbr != null ? '$full ($abbr)' : full,
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
          Text(
            value.toString(),
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _periciasTab() {
    const double nmColWidth = 48;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Perícias',
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87)),
          const SizedBox(height: 12),
          for (final entry in skillCatalog.entries) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF2E7D6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.key.toUpperCase(),
                      style: GoogleFonts.cinzel(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: const Color(0xFF412B1D),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: nmColWidth,
                      child: Text('N',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: nmColWidth,
                      child: Text('M',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700])),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                for (final skill in entry.value)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _buildSkillRow(
                      skill,
                      nmColWidth: nmColWidth,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _inventarioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Inventário',
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87)),
          const SizedBox(height: 12),
          // Seção Armamentos
          _buildInventorySectionHeader(
            'ARMAMENTOS',
            onAdd: () => _navigateToItemSelection(context, 'Armamentos'),
          ),
          if (_armamentos.isNotEmpty) ...[
            const SizedBox(height: 8),
            // Agrupar armamentos por categoria e subcategoria
            ..._buildArmamentGroups(),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 10),
          // Seção Vestimentas
          _buildInventorySectionHeader(
            'VESTIMENTAS',
            onAdd: () => _navigateToItemSelection(context, 'Vestimentas'),
          ),
          if (_vestimentas.isNotEmpty) ...[
            const SizedBox(height: 8),
            ..._buildVestimentasList(_vestimentas),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 10),
          // Seção Itens
          _buildInventorySectionHeader(
            'ITENS',
            onAdd: () => _navigateToItemSelection(context, 'Itens'),
          ),
          if (_itens.isNotEmpty) ...[
            const SizedBox(height: 8),
            ..._buildItemGroups(),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInventorySectionHeader(String title, {required VoidCallback onAdd}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF2E7D6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.cinzel(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: const Color(0xFF412B1D),
              ),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add,
                size: 20,
                color: Color(0xFF5B0A16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Constrói lista de vestimentas
  List<Widget> _buildVestimentasList(List<String> vestimentas) {
    return vestimentas.map((item) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.88),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2F1B10),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  vestimentas.remove(item);
                });
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.red, width: 1),
                ),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
  
  // Constrói lista de itens agrupados por categoria (similar aos armamentos)
  List<Widget> _buildItemGroups() {
    // Agrupar itens por categoria
    final Map<String, List<SelectedItem>> grouped = {};
    
    for (final item in _itens) {
      if (!grouped.containsKey(item.category)) {
        grouped[item.category] = [];
      }
      grouped[item.category]!.add(item);
    }

    final List<Widget> widgets = [];
    
    grouped.forEach((category, items) {
      // Cabeçalho da categoria
      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 6, top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF5B0A16).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
          ),
          child: Text(
            category,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5B0A16),
            ),
          ),
        ),
      );

      // Lista de itens da categoria
      items.forEach((item) {
        widgets.add(
          Container(
            margin: const EdgeInsets.only(bottom: 4, left: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.88),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.item,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2F1B10),
                    ),
                  ),
                ),
                // Botões de quantidade
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      if (item.quantity > 1) {
                        item.quantity--;
                      }
                    });
                  },
                  color: const Color(0xFF5B0A16),
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                  ),
                  child: Text(
                    item.quantity.toString(),
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF5B0A16),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      item.quantity++;
                    });
                  },
                  color: const Color(0xFF5B0A16),
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _itens.remove(item);
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red, width: 1),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });

    return widgets;
  }

  List<Widget> _buildArmamentGroups() {
    // Agrupar armamentos por categoria e subcategoria
    final Map<String, Map<String, List<SelectedArmament>>> grouped = {};
    
    for (final armament in _armamentos) {
      if (!grouped.containsKey(armament.category)) {
        grouped[armament.category] = {};
      }
      if (!grouped[armament.category]!.containsKey(armament.subcategory)) {
        grouped[armament.category]![armament.subcategory] = [];
      }
      grouped[armament.category]![armament.subcategory]!.add(armament);
    }

    final List<Widget> widgets = [];
    
    grouped.forEach((category, subcategories) {
      // Cabeçalho da categoria
      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 6, top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF5B0A16).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
          ),
          child: Text(
            category,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5B0A16),
            ),
          ),
        ),
      );

      subcategories.forEach((subcategory, armaments) {
        // Cabeçalho da subcategoria
        widgets.add(
          Container(
            margin: const EdgeInsets.only(bottom: 4, left: 12, top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF5B0A16), width: 1),
            ),
            child: Text(
              subcategory,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        );

        // Itens da subcategoria
        for (final armament in armaments) {
          widgets.add(
            Container(
              margin: const EdgeInsets.only(bottom: 4, left: 24),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF5B0A16), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      armament.item,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _armamentos.remove(armament);
                      });
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    });

    return widgets;
  }

  Widget _buildInventoryItem(String item, VoidCallback onRemove) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: const Icon(
                Icons.close,
                size: 18,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToItemSelection(BuildContext context, String category) {
    // Armamentos usam navegação hierárquica
    if (category == 'Armamentos') {
      _navigateToArmamentSelection(context);
      return;
    }
    
    // Itens usam navegação hierárquica
    if (category == 'Itens') {
      _navigateToItemHierarchicalSelection(context);
      return;
    }

    // Obtém a lista inicial de itens já selecionados
    List<String>? initialSelected;
    switch (category) {
      case 'Vestimentas':
        initialSelected = _vestimentas;
        break;
      case 'Técnicas Corpo a Corpo':
        initialSelected = _tecnicasCorpoACorpo;
        break;
      case 'Técnicas a Distância':
        initialSelected = _tecnicasDistancia;
        break;
      case 'Outras Técnicas':
        initialSelected = _tecnicasOutras;
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemSelectionScreen(
          category: category,
          initialSelected: initialSelected,
          getAvailableXP: _getAvailableXP,
          canAffordXP: (xpCost) => _canAffordXP(xpCost, _getAvailableXP()),
        ),
      ),
    ).then((selectedItems) {
      if (selectedItems != null && selectedItems is List<String>) {
        setState(() {
          switch (category) {
            case 'Vestimentas':
              _vestimentas.clear();
              _vestimentas.addAll(selectedItems);
              break;
            case 'Técnicas Corpo a Corpo':
              _tecnicasCorpoACorpo.clear();
              _tecnicasCorpoACorpo.addAll(selectedItems);
              break;
            case 'Técnicas a Distância':
              _tecnicasDistancia.clear();
              _tecnicasDistancia.addAll(selectedItems);
              break;
            case 'Outras Técnicas':
              _tecnicasOutras.clear();
              _tecnicasOutras.addAll(selectedItems);
              break;
          }
          _updateXPDisplay();
        });
      }
    });
  }

  void _navigateToArmamentSelection(BuildContext context) async {
    // Primeiro, seleciona a categoria (Corpo a Corpo, etc.)
    final category = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const ArmamentCategorySelectionScreen(),
      ),
    );

    if (category == null) return;

    // Seleciona subcategorias e itens diretamente (todos de uma vez)
    final selectedArmaments = await Navigator.push<List<SelectedArmament>>(
      context,
      MaterialPageRoute(
        builder: (_) => ArmamentSubcategorySelectionScreen(
          category: category,
          initialSelected: _armamentos,
        ),
      ),
    );

    if (selectedArmaments != null) {
      setState(() {
        // Remove armamentos antigos da mesma categoria
        _armamentos.removeWhere((a) => a.category == category);
        // Adiciona os novos
        _armamentos.addAll(selectedArmaments);
      });
    }
  }
  
  void _navigateToItemHierarchicalSelection(BuildContext context) async {
    // Primeiro, seleciona a categoria de item
    final category = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const ItemCategorySelectionScreen(),
      ),
    );

    if (category == null) return;

    // Seleciona os itens da categoria
    final selectedItems = await Navigator.push<List<SelectedItem>>(
      context,
      MaterialPageRoute(
        builder: (_) => ItemItemSelectionScreen(
          category: category,
          initialSelected: _itens,
        ),
      ),
    );

    if (selectedItems != null) {
      setState(() {
        // Remove itens antigos da mesma categoria
        _itens.removeWhere((i) => i.category == category);
        // Adiciona os novos
        _itens.addAll(selectedItems);
      });
    }
  }

  Widget _habilidadesTab() {
    final hasAnyTechnique = _tecnicasCorpoACorpo.isNotEmpty ||
        _tecnicasDistancia.isNotEmpty ||
        _tecnicasOutras.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Habilidades',
              style: GoogleFonts.roboto(
                  fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87)),
          const SizedBox(height: 12),
          // Seção Técnicas (único campo)
          _buildInventorySectionHeader(
            'TÉCNICAS',
            onAdd: () => _navigateToTechniqueCategory(context),
          ),
          // Exibir técnicas organizadas por categoria se houver alguma selecionada
          if (hasAnyTechnique || _estilosLuta.isNotEmpty) ...[
            const SizedBox(height: 8),
            // Corpo a Corpo
            if (_tecnicasCorpoACorpo.isNotEmpty || _estilosLuta.isNotEmpty) ...[
              _buildTechniqueCategoryHeader('Corpo a Corpo'),
              const SizedBox(height: 4),
              // Estilos de Luta
              if (_estilosLuta.isNotEmpty) ...[
                ..._estilosLuta.map((style) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                style.styleName,
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              color: const Color(0xFF5B0A16),
                              onPressed: () {
                                setState(() {
                                  _estilosLuta.remove(style);
                                });
                              },
                            ),
                          ],
                        ),
                        if (style.selectedStrikes.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          ...style.selectedStrikes.map((strike) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 12, top: 2),
                              child: Text(
                                '• $strike',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 4),
              ],
              // Técnicas Corpo a Corpo
              if (_tecnicasCorpoACorpo.isNotEmpty) ...[
                ..._tecnicasCorpoACorpo.map((item) => _buildInventoryItem(item, () {
                  setState(() {
                    _tecnicasCorpoACorpo.remove(item);
                  });
                })),
              ],
              const SizedBox(height: 8),
            ],
            // Distância
            if (_tecnicasDistancia.isNotEmpty) ...[
              _buildTechniqueCategoryHeader('Distância'),
              const SizedBox(height: 4),
              ..._tecnicasDistancia.map((item) => _buildInventoryItem(item, () {
                setState(() {
                  _tecnicasDistancia.remove(item);
                });
              })),
              const SizedBox(height: 8),
            ],
            // Outras Técnicas
            if (_tecnicasOutras.isNotEmpty) ...[
              _buildTechniqueCategoryHeader('Outras Técnicas'),
              const SizedBox(height: 4),
              ..._tecnicasOutras.map((item) => _buildInventoryItem(item, () {
                setState(() {
                  _tecnicasOutras.remove(item);
                });
              })),
              const SizedBox(height: 8),
            ],
          ],
          const SizedBox(height: 10),
          // Seção Poderes (único campo)
          _buildInventorySectionHeader(
            'PODERES',
            onAdd: () => _navigateToPowerCategory(context),
          ),
          // Exibir poderes selecionados organizados por categoria e dádiva
          if (_poderes.isNotEmpty) ...[
            const SizedBox(height: 8),
            ..._buildPowerHierarchy(),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTechniqueCategoryHeader(String categoryName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF5B0A16).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF5B0A16).withOpacity(0.3), width: 1),
      ),
      child: Text(
        categoryName,
        style: GoogleFonts.roboto(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF5B0A16),
        ),
      ),
    );
  }

  void _navigateToPowerCategory(BuildContext context) async {
    // Primeiro, mostra a tela de seleção de categoria
    final category = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const PowerCategorySelectionScreen(),
      ),
    );

    if (!mounted || category == null) return;

    // Depois, mostra a tela de seleção de dádivas
    final dativa = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => PowerDativaSelectionScreen(category: category),
      ),
    );

    if (!mounted || dativa == null) return;

    // Por fim, mostra a tela de seleção de poderes
    final selectedPowers = await Navigator.push<List<SelectedPower>>(
      context,
      MaterialPageRoute(
        builder: (_) => PowerSelectionScreen(
          category: category,
          dativa: dativa,
          initialSelected: _poderes,
          getAvailableXP: _getAvailableXP,
          canAffordXP: (xpCost) => _canAffordXP(xpCost, _getAvailableXP()),
        ),
      ),
    );

    if (!mounted || selectedPowers == null) return;

    setState(() {
      // Remove poderes antigos desta dádiva
      _poderes.removeWhere((p) => p.category == category && p.dativa == dativa);
      // Adiciona os novos poderes selecionados
      _poderes.addAll(selectedPowers);
      _updateXPDisplay();
    });
  }

  List<Widget> _buildPowerHierarchy() {
    // Agrupa poderes por categoria e depois por dádiva
    final Map<String, Map<String, List<SelectedPower>>> grouped = {};

    for (final power in _poderes) {
      if (!grouped.containsKey(power.category)) {
        grouped[power.category] = {};
      }
      if (!grouped[power.category]!.containsKey(power.dativa)) {
        grouped[power.category]![power.dativa] = [];
      }
      grouped[power.category]![power.dativa]!.add(power);
    }

    final List<Widget> widgets = [];

    grouped.forEach((category, dativas) {
      // Cabeçalho da categoria
      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(bottom: 4, top: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF5B0A16).withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
          ),
          child: Text(
            category,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5B0A16),
            ),
          ),
        ),
      );

      dativas.forEach((dativa, powers) {
        // Cabeçalho da dádiva
        widgets.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(bottom: 4, left: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF5B0A16).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF5B0A16).withOpacity(0.3), width: 1),
            ),
            child: Text(
              dativa,
              style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF5B0A16),
              ),
            ),
          ),
        );

        // Lista de poderes
        for (final power in powers) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: _buildInventoryItem(power.power, () {
                setState(() {
                  _poderes.remove(power);
                });
              }),
            ),
          );
        }
      });
    });

    return widgets;
  }

  void _navigateToTechniqueCategory(BuildContext context) async {
    // Primeiro, mostra a tela de seleção de categoria
    final category = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const TechniqueCategorySelectionScreen(),
      ),
    );

    if (category != null) {
      // Se for "Corpo a Corpo", mostra opção para Técnicas ou Estilos de Luta
      if (category == 'Corpo a Corpo') {
        // Mostra diálogo ou navega para escolher entre Técnicas e Estilos
        final choice = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Corpo a Corpo',
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Técnicas Corpo a Corpo'),
                  onTap: () => Navigator.pop(context, 'tecnicas'),
                ),
                ListTile(
                  title: const Text('Estilos de Luta'),
                  onTap: () => Navigator.pop(context, 'estilos'),
                ),
              ],
            ),
          ),
        );
        
        if (choice == 'tecnicas') {
          _navigateToItemSelection(context, 'Técnicas Corpo a Corpo');
        } else if (choice == 'estilos') {
          final selectedStyles = await Navigator.push<List<SelectedFightingStyle>>(
            context,
            MaterialPageRoute(
              builder: (_) => FightingStyleSelectionScreen(
                initialSelected: _estilosLuta,
                getAvailableXP: _getAvailableXP,
                canAffordXP: (xpCost) => _canAffordXP(xpCost, _getAvailableXP()),
              ),
            ),
          );
          if (selectedStyles != null) {
            setState(() {
              _estilosLuta.clear();
              _estilosLuta.addAll(selectedStyles);
              _updateXPDisplay();
            });
          }
        }
      } else {
        // Mapeia a categoria selecionada para o nome usado no ItemSelectionScreen
        String categoryKey;
        switch (category) {
          case 'Distância':
            categoryKey = 'Técnicas a Distância';
            break;
          case 'Outras Técnicas':
            categoryKey = 'Outras Técnicas';
            break;
          default:
            return;
        }

        // Navega para a seleção de itens da categoria escolhida
        _navigateToItemSelection(context, categoryKey);
      }
    }
  }

  Widget _biografiaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coluna Esquerda
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Informações Básicas
                _buildBiographyField(
                  controller: _idadeController,
                  label: 'Idade:',
                ),
                const SizedBox(height: 12),
                _buildBiographyField(
                  controller: _nascController,
                  label: 'Nasc.:',
                ),
                const SizedBox(height: 12),
                _buildBiographyField(
                  controller: _alturaController,
                  label: 'Altura:',
                ),
                const SizedBox(height: 12),
                _buildBiographyField(
                  controller: _pesoController,
                  label: 'Peso:',
                ),
                const SizedBox(height: 20),
                // Aparência
                _buildBiographySection(
                  title: 'Aparência',
                  controller: _aparenciaController,
                ),
                const SizedBox(height: 20),
                // Comportamento
                _buildBiographySection(
                  title: 'Comportamento',
                  controller: _comportamentoController,
                ),
                const SizedBox(height: 20),
                // Objetivos
                _buildBiographySection(
                  title: 'Objetivos',
                  controller: _objetivosController,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Coluna Direita - Biografia
          Expanded(
            flex: 1,
            child: _buildBiographySection(
              title: 'Biografia',
              controller: _biografiaController,
              isLarge: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiographyField({
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiographySection({
    required String title,
    required TextEditingController controller,
    bool isLarge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Container(
          height: 2,
          margin: const EdgeInsets.only(bottom: 8),
          color: const Color(0xFF5B0A16),
        ),
        Container(
          height: isLarge ? 600 : 150,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillRow(
    SkillDefinition skill, {
    required double nmColWidth,
  }) {
    final rank = _skillRanks[skill.name] ?? 0;
    final isFavored = _favoredSkills.contains(skill.name);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isFavored 
            ? const Color(0xFFFFF8DC).withOpacity(0.95) // Cor mais clara para perícias favorecidas
            : Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isFavored 
              ? const Color(0xFFDAA520) // Borda dourada para perícias favorecidas
              : const Color(0xFF5B0A16), 
          width: isFavored ? 2.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Checkbox para marcar como favorecida
          GestureDetector(
            onTap: () {
              setState(() {
                if (isFavored) {
                  _favoredSkills.remove(skill.name);
                } else {
                  _favoredSkills.add(skill.name);
                }
              });
            },
            child: Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isFavored ? const Color(0xFFDAA520) : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isFavored ? const Color(0xFFB8860B) : const Color(0xFF5B0A16),
                  width: 1.5,
                ),
              ),
              child: isFavored
                  ? const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      skill.name.toUpperCase(),
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: const Color(0xFF2F1B10),
                      ),
                    ),
                    if (isFavored) ...[
                      const SizedBox(width: 6),
                      Text(
                        '(Favorecida)',
                        style: GoogleFonts.roboto(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFFB8860B),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (skill.isDifficult)
                Text('Difícil',
                    style: GoogleFonts.roboto(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7C1C24))),
              Text(
                skill.attrLabel,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4A2C1A),
                ),
              ),
            ],
          ),
          _buildLevelBadge(rank, skill.name, width: nmColWidth),
          _buildModifierBadge(skill.name, width: nmColWidth),
        ],
      ),
    );
  }

  String _formatModifier(int value) {
    if (value >= 0) {
      return '+$value';
    }
    return value.toString();
  }

  Widget _buildLevelBadge(int rank, String skillName, {required double width}) {
    return GestureDetector(
      onTap: () => _showLevelSelector(context, skillName, rank),
      child: Container(
        width: width,
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        ),
        child: Text(
          rank.toString(),
          style: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2E1B11),
          ),
        ),
      ),
    );
  }

  void _showLevelSelector(BuildContext context, String skillName, int currentRank) {
    final skillDef = _getSkillDefinition(skillName);
    if (skillDef == null) return;
    
    final isFavored = _favoredSkills.contains(skillName);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedValue = currentRank;
        final scrollController = FixedExtentScrollController(initialItem: currentRank);
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Calcular XP necessário para o nível selecionado
            final xpCost = XPCostTable.getXPCost(currentRank, selectedValue, skillDef.isDifficult, isFavored);
            final availableXP = _getAvailableXP();
            // Permite XP negativo até -2
            final canAfford = selectedValue <= currentRank || _canAffordXP(xpCost, availableXP);
            
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Selecione o Nível',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF5B0A16),
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      skillName,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (skillDef.isDifficult)
                      Text(
                        'Difícil',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7C1C24),
                        ),
                      ),
                    if (isFavored)
                      Text(
                        'Favorecida',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFB8860B),
                        ),
                      ),
                    const SizedBox(height: 10),
                    // Mostrar custo de XP
                    if (selectedValue != currentRank)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: canAfford 
                              ? (availableXP - xpCost >= 0 ? Colors.green.shade50 : Colors.orange.shade50)
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: canAfford 
                                ? (availableXP - xpCost >= 0 ? Colors.green : Colors.orange)
                                : Colors.red,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          selectedValue > currentRank
                              ? 'Custo: $xpCost XP (Disponível: $availableXP XP${availableXP - xpCost < 0 ? ", ficará: ${availableXP - xpCost} XP" : ""})'
                              : 'Reembolso: ${-xpCost} XP',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: canAfford 
                                ? (availableXP - xpCost >= 0 ? Colors.green.shade900 : Colors.orange.shade900)
                                : Colors.red.shade900,
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setDialogState(() {
                              selectedValue = (selectedValue - 1).clamp(0, 20);
                              scrollController.animateToItem(
                                selectedValue,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            });
                          },
                          color: const Color(0xFF5B0A16),
                        ),
                        Container(
                          width: 60,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            selectedValue.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2E1B11),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: canAfford || selectedValue < currentRank
                              ? () {
                                  setDialogState(() {
                                    selectedValue = (selectedValue + 1).clamp(0, 20);
                                    scrollController.animateToItem(
                                      selectedValue,
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeOut,
                                    );
                                  });
                                }
                              : null,
                          color: canAfford || selectedValue < currentRank
                              ? const Color(0xFF5B0A16)
                              : Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 40,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setDialogState(() {
                            selectedValue = index;
                          });
                        },
                        controller: scrollController,
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            final isSelected = index == selectedValue;
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                index.toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: isSelected ? 24 : 18,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                                  color: isSelected ? const Color(0xFF5B0A16) : Colors.grey[600],
                                ),
                              ),
                            );
                          },
                          childCount: 21,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    scrollController.dispose();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: GoogleFonts.roboto(color: Colors.grey[700]),
                  ),
                ),
                TextButton(
                  onPressed: canAfford || selectedValue <= currentRank
                      ? () {
                          // Validar XP antes de confirmar (permite até -2)
                          final xpCost = XPCostTable.getXPCost(currentRank, selectedValue, skillDef.isDifficult, isFavored);
                          final availableXP = _getAvailableXP();
                          
                          if (selectedValue > currentRank && !_canAffordXP(xpCost, availableXP)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('XP insuficiente! Necessário: $xpCost XP, Disponível: $availableXP XP (mínimo: -2 XP)'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          
                          setState(() {
                            _skillRanks[skillName] = selectedValue;
                            _updateXPDisplay();
                          });
                          scrollController.dispose();
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Text(
                    'Confirmar',
                    style: GoogleFonts.roboto(
                      color: (canAfford || selectedValue <= currentRank)
                          ? const Color(0xFF5B0A16)
                          : Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildModifierBadge(String skillName, {required double width}) {
    final modifier = _skillModifiers[skillName] ?? 0;
    return GestureDetector(
      onTap: () => _showModifierSelector(context, skillName, modifier),
      child: Container(
        width: width,
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        ),
        child: Text(
          _formatModifier(modifier),
          style: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2E1B11),
          ),
        ),
      ),
    );
  }

  void _showModifierSelector(BuildContext context, String skillName, int currentModifier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedValue = currentModifier;
        final scrollController = FixedExtentScrollController(initialItem: currentModifier + 20);
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Selecione o Modificador',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF5B0A16),
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      skillName,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setDialogState(() {
                              selectedValue = (selectedValue - 1).clamp(-20, 20);
                              scrollController.animateToItem(
                                selectedValue + 20,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            });
                          },
                          color: const Color(0xFF5B0A16),
                        ),
                        Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _formatModifier(selectedValue),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2E1B11),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            setDialogState(() {
                              selectedValue = (selectedValue + 1).clamp(-20, 20);
                              scrollController.animateToItem(
                                selectedValue + 20,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            });
                          },
                          color: const Color(0xFF5B0A16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 40,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setDialogState(() {
                            selectedValue = index - 20; // -20 to +20
                          });
                        },
                        controller: scrollController,
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            final value = index - 20; // -20 to +20
                            final isSelected = value == selectedValue;
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                _formatModifier(value),
                                style: GoogleFonts.roboto(
                                  fontSize: isSelected ? 24 : 18,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                                  color: isSelected ? const Color(0xFF5B0A16) : Colors.grey[600],
                                ),
                              ),
                            );
                          },
                          childCount: 41, // -20 to +20 = 41 values
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    scrollController.dispose();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: GoogleFonts.roboto(color: Colors.grey[700]),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _skillModifiers[skillName] = selectedValue;
                    });
                    scrollController.dispose();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirmar',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF5B0A16),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSelectDisplay({
    required String label,
    required IconData icon,
    required String content,
    required String suffix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey[700])),
              const SizedBox(height: 4),
              Text(content, style: GoogleFonts.roboto(fontSize: 14, color: Colors.black), softWrap: true),
            ]),
          ),
          const SizedBox(width: 8),
          Text(suffix, style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildLabeledField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[700])),
          const SizedBox(height: 4),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.zero, border: InputBorder.none),
              style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    bool numbersOnly = false,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey[700])),
          const SizedBox(height: 2),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: numbersOnly ? TextInputType.number : TextInputType.text,
              inputFormatters: numbersOnly 
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.zero, border: InputBorder.none),
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectField({
    required String value,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.88),
          border: Border.all(color: const Color(0xFF5B0A16), width: 1.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[700])),
            const SizedBox(height: 4),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value, style: GoogleFonts.roboto(fontSize: 16, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

