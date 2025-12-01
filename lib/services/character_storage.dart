import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/character_data.dart';

class CharacterStorage {
  static const String _charactersDir = 'characters';
  
  // Obter diretório de documentos do app
  Future<Directory> _getDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final charactersDir = Directory('${directory.path}/$_charactersDir');
    if (!await charactersDir.exists()) {
      await charactersDir.create(recursive: true);
    }
    return charactersDir;
  }
  
  // Obter caminho do arquivo do personagem
  Future<String> _getCharacterFilePath(String characterId) async {
    final dir = await _getDocumentsDirectory();
    return '${dir.path}/$characterId.json';
  }
  
  // Salvar personagem
  Future<bool> saveCharacter(CharacterData character) async {
    try {
      final characterId = character.name.isEmpty 
          ? 'character_${DateTime.now().millisecondsSinceEpoch}'
          : character.name.replaceAll(RegExp(r'[^\w\s-]'), '_').toLowerCase();
      
      final filePath = await _getCharacterFilePath(characterId);
      final file = File(filePath);
      
      // Atualizar data de modificação
      character.updatedAt = DateTime.now();
      if (character.createdAt == DateTime(1970)) {
        character.createdAt = DateTime.now();
      }
      
      // Salvar JSON
      final jsonString = jsonEncode(character.toJson());
      await file.writeAsString(jsonString);
      
      // Copiar imagem se existir (apenas se ainda não estiver no diretório de imagens)
      if (character.imagePath != null) {
        final imageFile = File(character.imagePath!);
        if (await imageFile.exists()) {
          final imagesDir = Directory('${(await _getDocumentsDirectory()).path}/images');
          if (!await imagesDir.exists()) {
            await imagesDir.create(recursive: true);
          }
          final imageFileName = '${characterId}_image.jpg';
          final destImagePath = '${imagesDir.path}/$imageFileName';
          
          // Só copia se ainda não estiver no diretório de imagens
          if (!imageFile.path.contains(imagesDir.path)) {
            await imageFile.copy(destImagePath);
            character.imagePath = destImagePath;
          }
        }
      }
      
      return true;
    } catch (e) {
      print('Erro ao salvar personagem: $e');
      return false;
    }
  }
  
  // Carregar personagem
  Future<CharacterData?> loadCharacter(String characterId) async {
    try {
      final filePath = await _getCharacterFilePath(characterId);
      final file = File(filePath);
      
      if (!await file.exists()) {
        return null;
      }
      
      final jsonString = await file.readAsString();
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return CharacterData.fromJson(json);
    } catch (e) {
      print('Erro ao carregar personagem: $e');
      return null;
    }
  }
  
  // Listar todos os personagens
  Future<List<CharacterData>> listCharacters() async {
    try {
      final dir = await _getDocumentsDirectory();
      final files = dir.listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.json'))
          .toList();
      
      final characters = <CharacterData>[];
      for (final file in files) {
        try {
          final jsonString = await file.readAsString();
          final json = jsonDecode(jsonString) as Map<String, dynamic>;
          final character = CharacterData.fromJson(json);
          characters.add(character);
        } catch (e) {
          print('Erro ao ler arquivo ${file.path}: $e');
        }
      }
      
      // Ordenar por data de modificação (mais recente primeiro)
      characters.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      
      return characters;
    } catch (e) {
      print('Erro ao listar personagens: $e');
      return [];
    }
  }
  
  // Deletar personagem
  Future<bool> deleteCharacter(String characterId) async {
    try {
      final filePath = await _getCharacterFilePath(characterId);
      final file = File(filePath);
      
      if (await file.exists()) {
        await file.delete();
        
        // Deletar imagem associada se existir
        final imagesDir = Directory('${(await _getDocumentsDirectory()).path}/images');
        if (await imagesDir.exists()) {
          final imageFile = File('${imagesDir.path}/${characterId}_image.jpg');
          if (await imageFile.exists()) {
            await imageFile.delete();
          }
        }
        
        return true;
      }
      return false;
    } catch (e) {
      print('Erro ao deletar personagem: $e');
      return false;
    }
  }
  
  // Obter ID do personagem a partir do nome
  String getCharacterId(String name) {
    return name.replaceAll(RegExp(r'[^\w\s-]'), '_').toLowerCase();
  }
}

