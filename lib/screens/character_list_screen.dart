import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/character_data.dart';
import '../services/character_storage.dart';
import 'character_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final CharacterStorage _storage = CharacterStorage();
  List<CharacterData> _characters = [];
  bool _isLoading = true;
  CharacterData? _selectedCharacter;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    setState(() => _isLoading = true);
    final characters = await _storage.listCharacters();
    setState(() {
      _characters = characters;
      _isLoading = false;
    });
  }

  Future<void> _deleteCharacter(CharacterData character) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Deletar Personagem',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF5B0A16),
          ),
        ),
        content: Text(
          'Tem certeza que deseja deletar "${character.name.isEmpty ? "Personagem sem nome" : character.name}"?',
          style: GoogleFonts.roboto(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancelar',
              style: GoogleFonts.roboto(color: Colors.grey[700]),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Deletar',
              style: GoogleFonts.roboto(
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final characterId = _storage.getCharacterId(character.name.isEmpty 
          ? 'character_${character.createdAt.millisecondsSinceEpoch}'
          : character.name);
      final deleted = await _storage.deleteCharacter(characterId);
      if (deleted) {
        setState(() {
          _characters.remove(character);
          if (_selectedCharacter == character) {
            _selectedCharacter = null;
          }
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Personagem deletado'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    }
  }

  void _openCharacter() {
    if (_selectedCharacter == null) return;
    
    final characterId = _storage.getCharacterId(_selectedCharacter!.name.isEmpty 
        ? 'character_${_selectedCharacter!.createdAt.millisecondsSinceEpoch}'
        : _selectedCharacter!.name);
    
    _storage.loadCharacter(characterId).then((loaded) {
      if (loaded != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CharacterScreen(
              defaultTitle: _selectedCharacter!.name.isEmpty 
                  ? 'Personagem sem nome' 
                  : _selectedCharacter!.name,
              characterData: loaded,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header vermelho escuro
          Container(
            color: const Color(0xFF5B0A16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.folder, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      'Armazenamento Local',
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Filtros (simplificados por enquanto)
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown('Mais Recente', Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildFilterDropdown('Todas as Origens', Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Área de conteúdo com fundo pergaminho
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/textura_pergaminho.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _characters.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Nenhum personagem salvo',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          itemCount: _characters.length,
                          itemBuilder: (context, index) {
                            final character = _characters[index];
                            final isSelected = _selectedCharacter == character;
                            return _buildCharacterEntry(character, isSelected);
                          },
                        ),
            ),
          ),
          // Botões na parte inferior
          Container(
            color: Colors.grey[800],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão X (deletar personagem selecionado)
                GestureDetector(
                  onTap: _selectedCharacter != null
                      ? () => _deleteCharacter(_selectedCharacter!)
                      : null,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _selectedCharacter != null
                          ? Colors.white
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _selectedCharacter != null
                            ? const Color(0xFF5B0A16)
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: _selectedCharacter != null
                          ? const Color(0xFF5B0A16)
                          : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ),
                // Botão Cancel
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Color(0xFF5B0A16),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Botão Open
                TextButton(
                  onPressed: _selectedCharacter != null ? _openCharacter : null,
                  style: TextButton.styleFrom(
                    backgroundColor: _selectedCharacter != null
                        ? Colors.white
                        : Colors.grey[300],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: _selectedCharacter != null
                            ? const Color(0xFF5B0A16)
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    'Abrir',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _selectedCharacter != null
                          ? Colors.black87
                          : Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: textColor,
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterEntry(CharacterData character, bool isSelected) {
    final displayName = character.name.isEmpty 
        ? 'Personagem sem nome' 
        : character.name;
    final origin = character.origin.isEmpty ? 'Sem origem' : character.origin;
    final culture = character.culture.isEmpty ? 'Sem cultura' : character.culture;
    final xp = character.xp.isEmpty ? '0' : character.xp;
    final dateTime = _formatDateTime(character.updatedAt);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCharacter = character;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF5B0A16)
                : const Color(0xFF5B0A16).withOpacity(0.5),
            width: isSelected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF5B0A16).withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayName,
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2F1B10),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$origin | $culture | XP: $xp',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dateTime,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final second = date.second.toString().padLeft(2, '0');
    
    return '$year-$month-$day $hour:$minute:$second';
  }
}
