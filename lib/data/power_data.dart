// Estrutura de dados para poderes
class PowerCategory {
  final String name;
  final List<PowerDativa> dativas;

  const PowerCategory({
    required this.name,
    required this.dativas,
  });
}

class PowerDativa {
  final String name;
  final List<String> powers;

  const PowerDativa({
    required this.name,
    required this.powers,
  });
}

// Estrutura para poder com custo de XP
class PowerWithCost {
  final String name;
  final int xpCost;

  const PowerWithCost({required this.name, required this.xpCost});
  
  String get displayName => '$name [$xpCost XP]';
}

// Catálogo de custos de XP para poderes Aoístas
class PowerXPCatalog {
  // AOISMO - DÁDIVAS DE FAVOR
  static const Map<String, PowerWithCost> aoismoDadivasDeFavor = {
    'Impor Mãos': PowerWithCost(name: 'Impor Mãos', xpCost: 2),
    'Cura Prístina': PowerWithCost(name: 'Cura Prístina', xpCost: 2),
    'Remanescer': PowerWithCost(name: 'Remanescer', xpCost: 2),
    'Sinal de Aura': PowerWithCost(name: 'Sinal de Aura', xpCost: 2),
    'Expurgo': PowerWithCost(name: 'Expurgo', xpCost: 2),
    'Presença Gentil': PowerWithCost(name: 'Presença Gentil', xpCost: 3),
    'Restauração': PowerWithCost(name: 'Restauração', xpCost: 2),
    'Sinal do Abascanto': PowerWithCost(name: 'Sinal do Abascanto', xpCost: 2),
    'Sinal de Proteção': PowerWithCost(name: 'Sinal de Proteção', xpCost: 2),
    'Sinal de Paz': PowerWithCost(name: 'Sinal de Paz', xpCost: 2),
    'Súplica': PowerWithCost(name: 'Súplica', xpCost: 2),
    'Graça de Aura': PowerWithCost(name: 'Graça de Aura', xpCost: 4),
    'Badalo Curador': PowerWithCost(name: 'Badalo Curador', xpCost: 2),
    'Graça DE Φiliya': PowerWithCost(name: 'Graça DE Φiliya', xpCost: 4),
    'Sinal de Couraça': PowerWithCost(name: 'Sinal de Couraça', xpCost: 4),
    'Benção de Cura': PowerWithCost(name: 'Benção de Cura', xpCost: 2),
  };
  
  // AOISMO - DÁDIVAS DE INVOCAÇÃO
  static const Map<String, PowerWithCost> aoismoDadivasDeInvocacao = {
    'Tato Espiritual': PowerWithCost(name: 'Tato Espiritual', xpCost: 2),
    'Espírito Musicista': PowerWithCost(name: 'Espírito Musicista', xpCost: 2),
    'Espírito Vigia': PowerWithCost(name: 'Espírito Vigia', xpCost: 2),
    'Espírito Protetor': PowerWithCost(name: 'Espírito Protetor', xpCost: 2),
    'Espiríto Soldado': PowerWithCost(name: 'Espiríto Soldado', xpCost: 2),
    'Sinal de Invocação': PowerWithCost(name: 'Sinal de Invocação', xpCost: 2),
    'Espírito Arqueiro': PowerWithCost(name: 'Espírito Arqueiro', xpCost: 2),
    'Espírito Esfolador': PowerWithCost(name: 'Espírito Esfolador', xpCost: 2),
    'Graça de ∆iscis': PowerWithCost(name: 'Graça de ∆iscis', xpCost: 4),
    'Graça de Okimos': PowerWithCost(name: 'Graça de Okimos', xpCost: 4),
    'Imponente': PowerWithCost(name: 'Imponente', xpCost: 2),
    'Canalizar Guerreiro': PowerWithCost(name: 'Canalizar Guerreiro', xpCost: 2),
    'Milagre': PowerWithCost(name: 'Milagre', xpCost: 2),
    'Passagem Etérea': PowerWithCost(name: 'Passagem Etérea', xpCost: 3),
  };
  
  // AOISMO - DÁDIVAS DE RETRIBUIÇÃO
  static const Map<String, PowerWithCost> aoismoDadivasDeRetribuicao = {
    'Luz Guia': PowerWithCost(name: 'Luz Guia', xpCost: 2),
    'Tribulação': PowerWithCost(name: 'Tribulação', xpCost: 2),
    'Luz Sacra': PowerWithCost(name: 'Luz Sacra', xpCost: 2),
    'Arma Purificada/Profanada': PowerWithCost(name: 'Arma Purificada/Profanada', xpCost: 2),
    'Sinal da Luz': PowerWithCost(name: 'Sinal da Luz', xpCost: 2),
    'Fardo': PowerWithCost(name: 'Fardo', xpCost: 2),
    'Pura Lux': PowerWithCost(name: 'Pura Lux', xpCost: 2),
    'Arma Espiritual': PowerWithCost(name: 'Arma Espiritual', xpCost: 4),
    'Chama Etérea': PowerWithCost(name: 'Chama Etérea', xpCost: 2),
    'Escudo Abençoado': PowerWithCost(name: 'Escudo Abençoado', xpCost: 2),
    'Olhos Justos': PowerWithCost(name: 'Olhos Justos', xpCost: 2),
    'Balança de Atos': PowerWithCost(name: 'Balança de Atos', xpCost: 2),
    'Flecha de Luz': PowerWithCost(name: 'Flecha de Luz', xpCost: 4),
    'Graça de Πathos': PowerWithCost(name: 'Graça de Πathos', xpCost: 4),
    'Badalo Justificador': PowerWithCost(name: 'Badalo Justificador', xpCost: 2),
    'Graça de Λuxai': PowerWithCost(name: 'Graça de Λuxai', xpCost: 4),
    'Martírio': PowerWithCost(name: 'Martírio', xpCost: 2),
    'Condenação': PowerWithCost(name: 'Condenação', xpCost: 2),
  };
  
  // AOISMO - DÁDIVAS MACULADAS
  static const Map<String, PowerWithCost> aoismoDadivasMaculadas = {
    'Açoite Sombrio': PowerWithCost(name: 'Açoite Sombrio', xpCost: 2),
    'Ideais Turvados': PowerWithCost(name: 'Ideais Turvados', xpCost: 2),
    'Cinde Sombras': PowerWithCost(name: 'Cinde Sombras', xpCost: 2),
    'Mortalha Sombria': PowerWithCost(name: 'Mortalha Sombria', xpCost: 2),
    'Sinal de Tormento': PowerWithCost(name: 'Sinal de Tormento', xpCost: 2),
    'Badalo Moribundo': PowerWithCost(name: 'Badalo Moribundo', xpCost: 2),
    'Troca Existencial': PowerWithCost(name: 'Troca Existencial', xpCost: 2),
    'Subjugar Vontade': PowerWithCost(name: 'Subjugar Vontade', xpCost: 2),
    'Escuridão Penetrante': PowerWithCost(name: 'Escuridão Penetrante', xpCost: 2),
    'Graça de Zoa': PowerWithCost(name: 'Graça de Zoa', xpCost: 4),
    'Cura Inversa': PowerWithCost(name: 'Cura Inversa', xpCost: 2),
    'Graça de Tenebris': PowerWithCost(name: 'Graça de Tenebris', xpCost: 4),
    'Olhos Vazios': PowerWithCost(name: 'Olhos Vazios', xpCost: 2),
    'Graça de ΣORDOS': PowerWithCost(name: 'Graça de ΣORDOS', xpCost: 4),
    'Toque Inverso': PowerWithCost(name: 'Toque Inverso', xpCost: 2),
  };
  
  // ARCANISMO - ESCOLA ALQUÍMICA
  static const Map<String, PowerWithCost> arcanismoEscolaAlquimica = {
    'Identificar Matéria': PowerWithCost(name: 'Identificar Matéria', xpCost: 2),
    'Termorregulação': PowerWithCost(name: 'Termorregulação', xpCost: 2),
    'Reforço Material': PowerWithCost(name: 'Reforço Material', xpCost: 2),
    'Revestir Material': PowerWithCost(name: 'Revestir Material', xpCost: 2),
    'Sono Induzido': PowerWithCost(name: 'Sono Induzido', xpCost: 2),
    'Tri Potência': PowerWithCost(name: 'Tri Potência', xpCost: 2),
    'Aquecer Coisa': PowerWithCost(name: 'Aquecer Coisa', xpCost: 2),
    'Esfera Dúplice': PowerWithCost(name: 'Esfera Dúplice', xpCost: 2),
    'Fragilizar': PowerWithCost(name: 'Fragilizar', xpCost: 2),
    'Resfriar Coisa': PowerWithCost(name: 'Resfriar Coisa', xpCost: 2),
    'Reparação': PowerWithCost(name: 'Reparação', xpCost: 2),
    'Jato Fumegante': PowerWithCost(name: 'Jato Fumegante', xpCost: 2),
    'Jato Cáustico': PowerWithCost(name: 'Jato Cáustico', xpCost: 2),
    'Metábole': PowerWithCost(name: 'Metábole', xpCost: 2),
    'Esteroquimía': PowerWithCost(name: 'Esteroquimía', xpCost: 2),
    'Moldar Matéria': PowerWithCost(name: 'Moldar Matéria', xpCost: 2),
    'Nimbos Tóxica': PowerWithCost(name: 'Nimbos Tóxica', xpCost: 2),
    'Raio Voltaico': PowerWithCost(name: 'Raio Voltaico', xpCost: 2),
    'Adaptação Gênica': PowerWithCost(name: 'Adaptação Gênica', xpCost: 2),
    'Concocção Inopinada': PowerWithCost(name: 'Concocção Inopinada', xpCost: 2),
    'Material Superior': PowerWithCost(name: 'Material Superior', xpCost: 2),
    'Fogo Vesano': PowerWithCost(name: 'Fogo Vesano', xpCost: 2),
    'Cristalizar Lágrima': PowerWithCost(name: 'Cristalizar Lágrima', xpCost: 3),
    'Nitro Congelar': PowerWithCost(name: 'Nitro Congelar', xpCost: 2),
    'ExoLágrima': PowerWithCost(name: 'ExoLágrima', xpCost: 2),
    'Surto de Adrenalina': PowerWithCost(name: 'Surto de Adrenalina', xpCost: 2),
    'Hipermetábole': PowerWithCost(name: 'Hipermetábole', xpCost: 2),
  };
  
  // ARCANISMO - ESCOLA PSICOCOGNITIVA
  static const Map<String, PowerWithCost> arcanismoEscolaPsicocognitiva = {
    'Escudar Mente': PowerWithCost(name: 'Escudar Mente', xpCost: 2),
    'Falar à Mente': PowerWithCost(name: 'Falar à Mente', xpCost: 2),
    'Mente Ativa': PowerWithCost(name: 'Mente Ativa', xpCost: 2),
    'Mente Factual': PowerWithCost(name: 'Mente Factual', xpCost: 2),
    'Neuropotência': PowerWithCost(name: 'Neuropotência', xpCost: 2),
    'Cogni Senso': PowerWithCost(name: 'Cogni Senso', xpCost: 2),
    'Devaneio': PowerWithCost(name: 'Devaneio', xpCost: 2),
    'Penetrar a Mente': PowerWithCost(name: 'Penetrar a Mente', xpCost: 2),
    'Afligir Dor': PowerWithCost(name: 'Afligir Dor', xpCost: 2),
    'Miragem': PowerWithCost(name: 'Miragem', xpCost: 3),
    'Prostração': PowerWithCost(name: 'Prostração', xpCost: 2),
    'Tempo Tolhido': PowerWithCost(name: 'Tempo Tolhido', xpCost: 2),
    'Sigilo de Ilusão': PowerWithCost(name: 'Sigilo de Ilusão', xpCost: 4),
    'Bloqueio Mental': PowerWithCost(name: 'Bloqueio Mental', xpCost: 2),
    'Descarga Psiônica': PowerWithCost(name: 'Descarga Psiônica', xpCost: 2),
    'Projetar Pensamento': PowerWithCost(name: 'Projetar Pensamento', xpCost: 2),
    'Sigilo do Versar': PowerWithCost(name: 'Sigilo do Versar', xpCost: 2),
    'Alucinação': PowerWithCost(name: 'Alucinação', xpCost: 4),
    'Choque Psiônico': PowerWithCost(name: 'Choque Psiônico', xpCost: 2),
    'Perscrutar Ideia': PowerWithCost(name: 'Perscrutar Ideia', xpCost: 2),
    'Abalo Mental': PowerWithCost(name: 'Abalo Mental', xpCost: 2),
    'Oblívio': PowerWithCost(name: 'Oblívio', xpCost: 2),
    'Ascenção Psiônica': PowerWithCost(name: 'Ascenção Psiônica', xpCost: 4),
    'Memória Fabricada': PowerWithCost(name: 'Memória Fabricada', xpCost: 2),
    'Sigilo da Fantasia': PowerWithCost(name: 'Sigilo da Fantasia', xpCost: 2),
  };
  
  // ARCANISMO - ESCOLA METAESSENCIAL
  static const Map<String, PowerWithCost> arcanismoEscolaMetaessencial = {
    'Fluorescência': PowerWithCost(name: 'Fluorescência', xpCost: 2),
    'Rastro Essencial': PowerWithCost(name: 'Rastro Essencial', xpCost: 2),
    'Corte de Mana': PowerWithCost(name: 'Corte de Mana', xpCost: 2),
    'Éter Luz': PowerWithCost(name: 'Éter Luz', xpCost: 2),
    'Repulsão': PowerWithCost(name: 'Repulsão', xpCost: 2),
    'Centelha': PowerWithCost(name: 'Centelha', xpCost: 2),
    'Dardo de Energia': PowerWithCost(name: 'Dardo de Energia', xpCost: 2),
    'Esfera Antimana': PowerWithCost(name: 'Esfera Antimana', xpCost: 2),
    'Refluxo de Mana': PowerWithCost(name: 'Refluxo de Mana', xpCost: 2),
    'Grilhões de Estresse': PowerWithCost(name: 'Grilhões de Estresse', xpCost: 2),
    'Lâmina de Plasma': PowerWithCost(name: 'Lâmina de Plasma', xpCost: 2),
    'Quebra de Sigilo': PowerWithCost(name: 'Quebra de Sigilo', xpCost: 2),
    'Transfusão Essencial': PowerWithCost(name: 'Transfusão Essencial', xpCost: 2),
    'Esconjurar': PowerWithCost(name: 'Esconjurar', xpCost: 2),
    'Absorção Essencial': PowerWithCost(name: 'Absorção Essencial', xpCost: 2),
    'Barreira Adiabática': PowerWithCost(name: 'Barreira Adiabática', xpCost: 2),
    'Dobrar Essência': PowerWithCost(name: 'Dobrar Essência', xpCost: 2),
    'Excrucio': PowerWithCost(name: 'Excrucio', xpCost: 2),
    'Feixe de Plasma': PowerWithCost(name: 'Feixe de Plasma', xpCost: 4),
    'Campo Desconexo': PowerWithCost(name: 'Campo Desconexo', xpCost: 2),
    'Sigilo do Manto Obscuro': PowerWithCost(name: 'Sigilo do Manto Obscuro', xpCost: 2),
    'Nova Arcana': PowerWithCost(name: 'Nova Arcana', xpCost: 2),
    'Ascenção Meta Essencial': PowerWithCost(name: 'Ascenção Meta Essencial', xpCost: 4),
  };
  
  // ARCANISMO - ESCOLA ESCRIBA
  static const Map<String, PowerWithCost> arcanismoEscolaEscriba = {
    'Sigilo Mensagem': PowerWithCost(name: 'Sigilo Mensagem', xpCost: 2),
    'Velar Sigilos': PowerWithCost(name: 'Velar Sigilos', xpCost: 2),
    'Sigilo Vigia': PowerWithCost(name: 'Sigilo Vigia', xpCost: 2),
    'Sigilo Tranca': PowerWithCost(name: 'Sigilo Tranca', xpCost: 2),
    'Sigilo Lança': PowerWithCost(name: 'Sigilo Lança', xpCost: 2),
    'Arma Sigilada': PowerWithCost(name: 'Arma Sigilada', xpCost: 2),
    'Ciência Escriba': PowerWithCost(name: 'Ciência Escriba', xpCost: 4),
    'Sigilo Armadilha': PowerWithCost(name: 'Sigilo Armadilha', xpCost: 2),
    'Sigilo Supressor': PowerWithCost(name: 'Sigilo Supressor', xpCost: 2),
    'Círculo Arcano': PowerWithCost(name: 'Círculo Arcano', xpCost: 2),
    'Manter em Sigilo': PowerWithCost(name: 'Manter em Sigilo', xpCost: 2),
    'Sigilo Barreira': PowerWithCost(name: 'Sigilo Barreira', xpCost: 2),
    'Contra Sigilo': PowerWithCost(name: 'Contra Sigilo', xpCost: 2),
    'Manter Aprimorado': PowerWithCost(name: 'Manter Aprimorado', xpCost: 2),
    'Sigilo de Translado': PowerWithCost(name: 'Sigilo de Translado', xpCost: 3),
    'Ascensão Arcano Escriba': PowerWithCost(name: 'Ascensão Arcano Escriba', xpCost: 2),
  };
  
  // BARDISMO - ARTES DA FORTUNA
  static const Map<String, PowerWithCost> bardismoArtesDaFortuna = {
    'Manipular Entropia': PowerWithCost(name: 'Manipular Entropia', xpCost: 2),
    'Entropia Essencial': PowerWithCost(name: 'Entropia Essencial', xpCost: 2),
    'Sorte em Aposta': PowerWithCost(name: 'Sorte em Aposta', xpCost: 2),
    'Equilibrar Chances': PowerWithCost(name: 'Equilibrar Chances', xpCost: 2),
    'Sorte Em Essência': PowerWithCost(name: 'Sorte Em Essência', xpCost: 2),
    'Boaventura': PowerWithCost(name: 'Boaventura', xpCost: 2),
    'Infortúnio': PowerWithCost(name: 'Infortúnio', xpCost: 4),
    'Canalizar Sorte': PowerWithCost(name: 'Canalizar Sorte', xpCost: 2),
    'Aura de sorte': PowerWithCost(name: 'Aura de sorte', xpCost: 2),
    'Conto Heroico': PowerWithCost(name: 'Conto Heroico', xpCost: 2),
    'Sorte em Vida': PowerWithCost(name: 'Sorte em Vida', xpCost: 2),
    'Léria Desastrosa': PowerWithCost(name: 'Léria Desastrosa', xpCost: 2),
    'Sorte em Ação': PowerWithCost(name: 'Sorte em Ação', xpCost: 2),
    'Sorte em Morte': PowerWithCost(name: 'Sorte em Morte', xpCost: 2),
    'Sorte Destinada': PowerWithCost(name: 'Sorte Destinada', xpCost: 4),
  };
  
  // BARDISMO - ARTES INSTRUMENTAIS
  static const Map<String, PowerWithCost> bardismoArtesInstrumentais = {
    'Cacofonia': PowerWithCost(name: 'Cacofonia', xpCost: 2),
    'Canto': PowerWithCost(name: 'Canto', xpCost: 2),
    'Allegretto': PowerWithCost(name: 'Allegretto', xpCost: 2),
    'Espasmo': PowerWithCost(name: 'Espasmo', xpCost: 2),
    'Harmonia': PowerWithCost(name: 'Harmonia', xpCost: 2),
    'Ranger': PowerWithCost(name: 'Ranger', xpCost: 2),
    'Sinfonia Discordante': PowerWithCost(name: 'Sinfonia Discordante', xpCost: 2),
    'Acorde Edaz': PowerWithCost(name: 'Acorde Edaz', xpCost: 2),
    'Alarde': PowerWithCost(name: 'Alarde', xpCost: 2),
    'Coda de Guerra': PowerWithCost(name: 'Coda de Guerra', xpCost: 2),
    'Canção de Ninar': PowerWithCost(name: 'Canção de Ninar', xpCost: 2),
    'Vertigem': PowerWithCost(name: 'Vertigem', xpCost: 2),
    'Melopeia de Vidro': PowerWithCost(name: 'Melopeia de Vidro', xpCost: 2),
    'Serenata': PowerWithCost(name: 'Serenata', xpCost: 2),
    'Sonata Muda': PowerWithCost(name: 'Sonata Muda', xpCost: 2),
    'Vibrato': PowerWithCost(name: 'Vibrato', xpCost: 2),
    'Choque Sonoro': PowerWithCost(name: 'Choque Sonoro', xpCost: 4),
    'Valsa Lúdica': PowerWithCost(name: 'Valsa Lúdica', xpCost: 2),
    'Ária do Campeão': PowerWithCost(name: 'Ária do Campeão', xpCost: 2),
    'Réquiem': PowerWithCost(name: 'Réquiem', xpCost: 2),
    'Peça do Ventríloquo': PowerWithCost(name: 'Peça do Ventríloquo', xpCost: 2),
  };
  
  // BARDISMO - ARTES PSICOVOCAIS
  static const Map<String, PowerWithCost> bardismoArtesPsicovocais = {
    'Falar à Mente': PowerWithCost(name: 'Falar à Mente', xpCost: 2),
    'Voz Confortante': PowerWithCost(name: 'Voz Confortante', xpCost: 2),
    'Som Falso': PowerWithCost(name: 'Som Falso', xpCost: 2),
    'Fraqueza': PowerWithCost(name: 'Fraqueza', xpCost: 2),
    'Lábia Afinada': PowerWithCost(name: 'Lábia Afinada', xpCost: 2),
    'Implantar Pensamento': PowerWithCost(name: 'Implantar Pensamento', xpCost: 2),
    'Tolice': PowerWithCost(name: 'Tolice', xpCost: 2),
    'Carisma de Bardo': PowerWithCost(name: 'Carisma de Bardo', xpCost: 3),
    'Palavras Dolorosas': PowerWithCost(name: 'Palavras Dolorosas', xpCost: 2),
    'Palavra de Incentivo': PowerWithCost(name: 'Palavra de Incentivo', xpCost: 2),
    'Terceira Voz': PowerWithCost(name: 'Terceira Voz', xpCost: 2),
    'Voz Estrondosa': PowerWithCost(name: 'Voz Estrondosa', xpCost: 2),
    'Bloqueio Mental': PowerWithCost(name: 'Bloqueio Mental', xpCost: 2),
    'Fofoca Contagiosa': PowerWithCost(name: 'Fofoca Contagiosa', xpCost: 2),
    'Grande Estima': PowerWithCost(name: 'Grande Estima', xpCost: 2),
    'Sussurros': PowerWithCost(name: 'Sussurros', xpCost: 4),
    'Voz da Lembrança': PowerWithCost(name: 'Voz da Lembrança', xpCost: 2),
    'Oblívio': PowerWithCost(name: 'Oblívio', xpCost: 2),
    'Palavras de Comando': PowerWithCost(name: 'Palavras de Comando', xpCost: 4),
    'Memória Fabricada': PowerWithCost(name: 'Memória Fabricada', xpCost: 2),
  };
  
  // BARDISMO - ARTES TEATRAIS
  static const Map<String, PowerWithCost> bardismoArtesTeatrais = {
    'Dança Chamativa': PowerWithCost(name: 'Dança Chamativa', xpCost: 2),
    'Encenação': PowerWithCost(name: 'Encenação', xpCost: 2),
    'Fleuma': PowerWithCost(name: 'Fleuma', xpCost: 2),
    'Morte Fingida': PowerWithCost(name: 'Morte Fingida', xpCost: 2),
    'Passada Avante': PowerWithCost(name: 'Passada Avante', xpCost: 2),
    'Dança da Égide': PowerWithCost(name: 'Dança da Égide', xpCost: 2),
    'Dança Elusiva': PowerWithCost(name: 'Dança Elusiva', xpCost: 2),
    'Passada Furtiva': PowerWithCost(name: 'Passada Furtiva', xpCost: 2),
    'Sanguíneo': PowerWithCost(name: 'Sanguíneo', xpCost: 2),
    'Atrabílis': PowerWithCost(name: 'Atrabílis', xpCost: 2),
    'Contrapasso': PowerWithCost(name: 'Contrapasso', xpCost: 4),
    'Cólera': PowerWithCost(name: 'Cólera', xpCost: 2),
    'Dança Fatal': PowerWithCost(name: 'Dança Fatal', xpCost: 2),
    'Detenção Hipnótica': PowerWithCost(name: 'Detenção Hipnótica', xpCost: 2),
    'Incógnito': PowerWithCost(name: 'Incógnito', xpCost: 4),
  };
  
  // Função auxiliar para obter o custo de XP de um poder
  static int getPowerXPCost(String category, String dativa, String powerName) {
    if (category == 'AOISMO') {
      if (dativa == 'DÁDIVAS DE FAVOR') {
        return aoismoDadivasDeFavor[powerName]?.xpCost ?? 0;
      } else if (dativa == 'DADIVAS DE INVOCAÇÃO') {
        return aoismoDadivasDeInvocacao[powerName]?.xpCost ?? 0;
      } else if (dativa == 'DÁDIVAS DE RETRIBUIÇÃO') {
        return aoismoDadivasDeRetribuicao[powerName]?.xpCost ?? 0;
      } else if (dativa == 'DÁDIVAS MACULADAS') {
        return aoismoDadivasMaculadas[powerName]?.xpCost ?? 0;
      }
    } else if (category == 'ARCANISMO') {
      if (dativa == 'ESCOLA ALQUÍMICA') {
        return arcanismoEscolaAlquimica[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ESCOLA PSICOCOGONITIVA') {
        return arcanismoEscolaPsicocognitiva[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ESCOLA METAESSENCIAL') {
        return arcanismoEscolaMetaessencial[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ESCOLA ESCRIBA') {
        return arcanismoEscolaEscriba[powerName]?.xpCost ?? 0;
      }
    } else if (category == 'BARDISMO') {
      if (dativa == 'ARTES DA FORTUNA') {
        return bardismoArtesDaFortuna[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ARTES INSTRUMENTAIS') {
        return bardismoArtesInstrumentais[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ARTES PSICOVOCAIS') {
        return bardismoArtesPsicovocais[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ARTES TEATRAIS') {
        return bardismoArtesTeatrais[powerName]?.xpCost ?? 0;
      }
    } else if (category == 'CRONOCIÊNCIA') {
      if (dativa == 'CONTROLE CRONOLÓGICO') {
        return cronocienciaControleCronologico[powerName]?.xpCost ?? 0;
      } else if (dativa == 'CONTROLE FÁSICO') {
        return cronocienciaControleFasico[powerName]?.xpCost ?? 0;
      } else if (dativa == 'CONTROLE GRAVITACIONAL') {
        return cronocienciaControleGravitacional[powerName]?.xpCost ?? 0;
      } else if (dativa == 'CONTROLE SIDERAL') {
        return cronocienciaControleSideral[powerName]?.xpCost ?? 0;
      }
    } else if (category == 'DRUIDISMO') {
      if (dativa == 'ÂMBITO ANIMAL') {
        return druidismoAmbitoAnimal[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ÂMBITO ASTRAL') {
        return druidismoAmbitoAstral[powerName]?.xpCost ?? 0;
      } else if (dativa == 'ÂMBITO VEGETAL') {
        return druidismoAmbitoVegetal[powerName]?.xpCost ?? 0;
      }
    } else if (category == 'ELEMENTALISMO') {
      if (dativa == 'FORÇA DA ÁGUA') {
        return elementalismoForcaDaAgua[powerName]?.xpCost ?? 0;
      } else if (dativa == 'FORÇA DO FOGO') {
        return elementalismoForcaDoFogo[powerName]?.xpCost ?? 0;
      } else if (dativa == 'FORÇA DO RAIO') {
        return elementalismoForcaDoRaio[powerName]?.xpCost ?? 0;
      } else if (dativa == 'FORÇA DA TERRA') {
        return elementalismoForcaDaTerra[powerName]?.xpCost ?? 0;
      } else if (dativa == 'FORÇA DO VENTO') {
        return elementalismoForcaDoVento[powerName]?.xpCost ?? 0;
      }
    } else if (category == 'SABAKISMO') {
      if (dativa == 'DOMÍNIO DO EXÍCIO') {
        return sabakismoDominioDoExicio[powerName]?.xpCost ?? 0;
      } else if (dativa == 'DOMÍNIO MENTAL') {
        return sabakismoDominioMental[powerName]?.xpCost ?? 0;
      } else if (dativa == 'DOMÍNIO DAS PRAGAS') {
        return sabakismoDominioDasPragas[powerName]?.xpCost ?? 0;
      } else if (dativa == 'DOMÍINO DO SANGUE') {
        return sabakismoDominioDoSangue[powerName]?.xpCost ?? 0;
      }
    }
    // TODO: Adicionar outras categorias quando necessário
    return 0;
  }
  
  // SABAKISMO - DOMÍNIO DO EXÍCIO
  static const Map<String, PowerWithCost> sabakismoDominioDoExicio = {
    'Açoite Sombrio': PowerWithCost(name: 'Açoite Sombrio', xpCost: 2),
    'Sifonar': PowerWithCost(name: 'Sifonar', xpCost: 2),
    'Fende Luz': PowerWithCost(name: 'Fende Luz', xpCost: 2),
    'Mortalha Sombria': PowerWithCost(name: 'Mortalha Sombria', xpCost: 2),
    'Aflição do Exício': PowerWithCost(name: 'Aflição do Exício', xpCost: 2),
    'Obscurecer Olhos': PowerWithCost(name: 'Obscurecer Olhos', xpCost: 2),
    'Quebra de Sigilo': PowerWithCost(name: 'Quebra de Sigilo', xpCost: 2),
    'Espírito Dilacerador': PowerWithCost(name: 'Espírito Dilacerador', xpCost: 3),
    'Espírito Adepto': PowerWithCost(name: 'Espírito Adepto', xpCost: 2),
    'Hausto': PowerWithCost(name: 'Hausto', xpCost: 2),
    'Látego': PowerWithCost(name: 'Látego', xpCost: 2),
    'Troca Existencial': PowerWithCost(name: 'Troca Existencial', xpCost: 2),
    'Excrucio': PowerWithCost(name: 'Excrucio', xpCost: 2),
    'Devora Luz': PowerWithCost(name: 'Devora Luz', xpCost: 4),
    'Espírito Esfolador': PowerWithCost(name: 'Espírito Esfolador', xpCost: 2),
    'Sombra': PowerWithCost(name: 'Sombra', xpCost: 4),
    'Olhos Vazios': PowerWithCost(name: 'Olhos Vazios', xpCost: 2),
    'Espírito Ceifador': PowerWithCost(name: 'Espírito Ceifador', xpCost: 2),
    'Marcações do Exício': PowerWithCost(name: 'Marcações do Exício', xpCost: 4),
    'Vida Falsa': PowerWithCost(name: 'Vida Falsa', xpCost: 2),
    'Canalizar Sombrio': PowerWithCost(name: 'Canalizar Sombrio', xpCost: 2),
  };
  
  // SABAKISMO - DOMÍNIO MENTAL
  static const Map<String, PowerWithCost> sabakismoDominioMental = {
    'Falar à Mente': PowerWithCost(name: 'Falar à Mente', xpCost: 2),
    'Mente Ativa': PowerWithCost(name: 'Mente Ativa', xpCost: 2),
    'Aliviar Dor': PowerWithCost(name: 'Aliviar Dor', xpCost: 2),
    'Entorpecer': PowerWithCost(name: 'Entorpecer', xpCost: 2),
    'Adinamia': PowerWithCost(name: 'Adinamia', xpCost: 2),
    'Afligir Dor': PowerWithCost(name: 'Afligir Dor', xpCost: 2),
    'Cogni Senso': PowerWithCost(name: 'Cogni Senso', xpCost: 2),
    'Devaneio': PowerWithCost(name: 'Devaneio', xpCost: 2),
    'Ímpeto': PowerWithCost(name: 'Ímpeto', xpCost: 2),
    'Perseguição': PowerWithCost(name: 'Perseguição', xpCost: 2),
    'Terror': PowerWithCost(name: 'Terror', xpCost: 2),
    'Torpor': PowerWithCost(name: 'Torpor', xpCost: 2),
    'Vislumbre': PowerWithCost(name: 'Vislumbre', xpCost: 2),
    'Vox': PowerWithCost(name: 'Vox', xpCost: 2),
    'Augúrio': PowerWithCost(name: 'Augúrio', xpCost: 2),
    'Dominar Criatura': PowerWithCost(name: 'Dominar Criatura', xpCost: 2),
    'Perdição': PowerWithCost(name: 'Perdição', xpCost: 2),
    'Alucinação': PowerWithCost(name: 'Alucinação', xpCost: 4),
    'Detenção Hipnótica': PowerWithCost(name: 'Detenção Hipnótica', xpCost: 2),
    'Grunhido': PowerWithCost(name: 'Grunhido', xpCost: 2),
    'Imperar': PowerWithCost(name: 'Imperar', xpCost: 2),
    'Abalo Mental': PowerWithCost(name: 'Abalo Mental', xpCost: 2),
    'Presença Impositiva': PowerWithCost(name: 'Presença Impositiva', xpCost: 2),
    'Marca do Lacaio': PowerWithCost(name: 'Marca do Lacaio', xpCost: 2),
    'Olhar Cego': PowerWithCost(name: 'Olhar Cego', xpCost: 3),
    'Marcações da Mente': PowerWithCost(name: 'Marcações da Mente', xpCost: 4),
  };
  
  // SABAKISMO - DOMÍNIO DAS PRAGAS
  static const Map<String, PowerWithCost> sabakismoDominioDasPragas = {
    'Gafanhotos': PowerWithCost(name: 'Gafanhotos', xpCost: 2),
    'Pestilência': PowerWithCost(name: 'Pestilência', xpCost: 2),
    'Irritação': PowerWithCost(name: 'Irritação', xpCost: 2),
    'Morbo': PowerWithCost(name: 'Morbo', xpCost: 2),
    'Enxame': PowerWithCost(name: 'Enxame', xpCost: 2),
    'Fétido': PowerWithCost(name: 'Fétido', xpCost: 2),
    'Adoecer': PowerWithCost(name: 'Adoecer', xpCost: 2),
    'Bodum': PowerWithCost(name: 'Bodum', xpCost: 2),
    'Estagnação': PowerWithCost(name: 'Estagnação', xpCost: 2),
    'Mangra': PowerWithCost(name: 'Mangra', xpCost: 2),
    'Marcas de Futum': PowerWithCost(name: 'Marcas de Futum', xpCost: 2),
    'Praga': PowerWithCost(name: 'Praga', xpCost: 2),
    'Conspurgar': PowerWithCost(name: 'Conspurgar', xpCost: 2),
    'Marcas Putrefeitas': PowerWithCost(name: 'Marcas Putrefeitas', xpCost: 2),
    'Miasma': PowerWithCost(name: 'Miasma', xpCost: 2),
    'Ruína': PowerWithCost(name: 'Ruína', xpCost: 4),
    'Vetores': PowerWithCost(name: 'Vetores', xpCost: 2),
    'Chagas Necróticas': PowerWithCost(name: 'Chagas Necróticas', xpCost: 2),
    'Marcações Estagnantes': PowerWithCost(name: 'Marcações Estagnantes', xpCost: 4),
  };
  
  // SABAKISMO - DOMÍNIO DO SANGUE
  static const Map<String, PowerWithCost> sabakismoDominioDoSangue = {
    'Sangria': PowerWithCost(name: 'Sangria', xpCost: 2),
    'Coagulação': PowerWithCost(name: 'Coagulação', xpCost: 2),
    'Suturar': PowerWithCost(name: 'Suturar', xpCost: 3),
    'Ler Sangue': PowerWithCost(name: 'Ler Sangue', xpCost: 2),
    'Hemorragia': PowerWithCost(name: 'Hemorragia', xpCost: 2),
    'Eco Sanguíneo': PowerWithCost(name: 'Eco Sanguíneo', xpCost: 2),
    'Sanguívoro': PowerWithCost(name: 'Sanguívoro', xpCost: 4),
    'Sedento': PowerWithCost(name: 'Sedento', xpCost: 2),
    'Sanguessuga': PowerWithCost(name: 'Sanguessuga', xpCost: 2),
    'Arte do Sangue': PowerWithCost(name: 'Arte do Sangue', xpCost: 2),
    'Véu de Sangue': PowerWithCost(name: 'Véu de Sangue', xpCost: 2),
    'Sangue Podre': PowerWithCost(name: 'Sangue Podre', xpCost: 2),
    'Tratado de Sangue': PowerWithCost(name: 'Tratado de Sangue', xpCost: 2),
    'Veias de Flagelo': PowerWithCost(name: 'Veias de Flagelo', xpCost: 2),
    'Trabalhar o Sangue': PowerWithCost(name: 'Trabalhar o Sangue', xpCost: 3),
    'Lágrima de Sangue': PowerWithCost(name: 'Lágrima de Sangue', xpCost: 3),
    'Vampirismo': PowerWithCost(name: 'Vampirismo', xpCost: 4),
    'Tornar Estrige': PowerWithCost(name: 'Tornar Estrige', xpCost: 2),
  };
  
  // ELEMENTALISMO - FORÇA DA ÁGUA
  static const Map<String, PowerWithCost> elementalismoForcaDaAgua = {
    'Senso Hídrico': PowerWithCost(name: 'Senso Hídrico', xpCost: 2),
    'Correnteza': PowerWithCost(name: 'Correnteza', xpCost: 2),
    'Resfriar Coisa': PowerWithCost(name: 'Resfriar Coisa', xpCost: 2),
    'Cristalizar': PowerWithCost(name: 'Cristalizar', xpCost: 2),
    'Estilhaços': PowerWithCost(name: 'Estilhaços', xpCost: 2),
    'Pancada d\'Água': PowerWithCost(name: 'Pancada d\'Água', xpCost: 2),
    'Natural ao Frio': PowerWithCost(name: 'Natural ao Frio', xpCost: 2),
    'Aura Fria': PowerWithCost(name: 'Aura Fria', xpCost: 2),
    'Barreira Cristalizada': PowerWithCost(name: 'Barreira Cristalizada', xpCost: 2),
    'Golpe Glacial': PowerWithCost(name: 'Golpe Glacial', xpCost: 2),
    'Onda de Frio': PowerWithCost(name: 'Onda de Frio', xpCost: 2),
    'Rajada Congelante': PowerWithCost(name: 'Rajada Congelante', xpCost: 2),
    'Estalagmite': PowerWithCost(name: 'Estalagmite', xpCost: 2),
    'Espelho d\'Água': PowerWithCost(name: 'Espelho d\'Água', xpCost: 2),
    'Água Pristina': PowerWithCost(name: 'Água Pristina', xpCost: 4),
    'Estalo Gélido': PowerWithCost(name: 'Estalo Gélido', xpCost: 2),
    'Fera Gélida': PowerWithCost(name: 'Fera Gélida', xpCost: 4),
    'Abraço Frígido': PowerWithCost(name: 'Abraço Frígido', xpCost: 2),
    'Crio': PowerWithCost(name: 'Crio', xpCost: 3),
    'Maremoto': PowerWithCost(name: 'Maremoto', xpCost: 2),
  };
  
  // ELEMENTALISMO - FORÇA DO FOGO
  static const Map<String, PowerWithCost> elementalismoForcaDoFogo = {
    'Ignição': PowerWithCost(name: 'Ignição', xpCost: 2),
    'Sinal da Fogueira': PowerWithCost(name: 'Sinal da Fogueira', xpCost: 2),
    'Bola de Fogo': PowerWithCost(name: 'Bola de Fogo', xpCost: 2),
    'Esfumaçar': PowerWithCost(name: 'Esfumaçar', xpCost: 2),
    'Flamejar': PowerWithCost(name: 'Flamejar', xpCost: 2),
    'Aquecer Coisa': PowerWithCost(name: 'Aquecer Coisa', xpCost: 2),
    'Natural ao Ardor': PowerWithCost(name: 'Natural ao Ardor', xpCost: 2),
    'Aura Quente': PowerWithCost(name: 'Aura Quente', xpCost: 2),
    'Fumaça Negra': PowerWithCost(name: 'Fumaça Negra', xpCost: 2),
    'Lança Chamas': PowerWithCost(name: 'Lança Chamas', xpCost: 2),
    'Incinerar': PowerWithCost(name: 'Incinerar', xpCost: 2),
    'Onda de Calor': PowerWithCost(name: 'Onda de Calor', xpCost: 2),
    'Revés Flamejante': PowerWithCost(name: 'Revés Flamejante', xpCost: 2),
    'Esfera Explosiva': PowerWithCost(name: 'Esfera Explosiva', xpCost: 2),
    'Labareda': PowerWithCost(name: 'Labareda', xpCost: 2),
    'Pilar de Chamas': PowerWithCost(name: 'Pilar de Chamas', xpCost: 4),
    'Cria Flamejante': PowerWithCost(name: 'Cria Flamejante', xpCost: 4),
    'Tornar Escória': PowerWithCost(name: 'Tornar Escória', xpCost: 3),
  };
  
  // ELEMENTALISMO - FORÇA DO RAIO
  static const Map<String, PowerWithCost> elementalismoForcaDoRaio = {
    'Choque': PowerWithCost(name: 'Choque', xpCost: 2),
    'Raio': PowerWithCost(name: 'Raio', xpCost: 2),
    'Choque Atordoante': PowerWithCost(name: 'Choque Atordoante', xpCost: 2),
    'Eletrizar': PowerWithCost(name: 'Eletrizar', xpCost: 2),
    'Sinal do Raio': PowerWithCost(name: 'Sinal do Raio', xpCost: 2),
    'Estrondo': PowerWithCost(name: 'Estrondo', xpCost: 2),
    'Raio Voltáico': PowerWithCost(name: 'Raio Voltáico', xpCost: 2),
    'Cólera de Raios': PowerWithCost(name: 'Cólera de Raios', xpCost: 2),
    'Descarga': PowerWithCost(name: 'Descarga', xpCost: 2),
    'Onda de Choque': PowerWithCost(name: 'Onda de Choque', xpCost: 2),
    'Sobre Carga': PowerWithCost(name: 'Sobre Carga', xpCost: 2),
    'Essência Estática': PowerWithCost(name: 'Essência Estática', xpCost: 4),
    'Sibilar': PowerWithCost(name: 'Sibilar', xpCost: 4),
    'Fera Elétrica': PowerWithCost(name: 'Fera Elétrica', xpCost: 4),
    'Trovão': PowerWithCost(name: 'Trovão', xpCost: 2),
    'Eletrocussão': PowerWithCost(name: 'Eletrocussão', xpCost: 3),
  };
  
  // ELEMENTALISMO - FORÇA DA TERRA
  static const Map<String, PowerWithCost> elementalismoForcaDaTerra = {
    'Senso Sísmico': PowerWithCost(name: 'Senso Sísmico', xpCost: 2),
    'Moldar Terra': PowerWithCost(name: 'Moldar Terra', xpCost: 2),
    'Pilar de Terra': PowerWithCost(name: 'Pilar de Terra', xpCost: 2),
    'Jato de Areia': PowerWithCost(name: 'Jato de Areia', xpCost: 2),
    'Muro': PowerWithCost(name: 'Muro', xpCost: 2),
    'Golpe Sísmico': PowerWithCost(name: 'Golpe Sísmico', xpCost: 2),
    'Pedregulho': PowerWithCost(name: 'Pedregulho', xpCost: 2),
    'Terra Movediça': PowerWithCost(name: 'Terra Movediça', xpCost: 2),
    'Abalo Sísmico': PowerWithCost(name: 'Abalo Sísmico', xpCost: 2),
    'Deslizamento': PowerWithCost(name: 'Deslizamento', xpCost: 2),
    'Rijeza da Pedra': PowerWithCost(name: 'Rijeza da Pedra', xpCost: 2),
    'Terra Magnitude': PowerWithCost(name: 'Terra Magnitude', xpCost: 2),
    'Força Terrena': PowerWithCost(name: 'Força Terrena', xpCost: 2),
    'Quebra Terra': PowerWithCost(name: 'Quebra Terra', xpCost: 2),
    'Petrificar': PowerWithCost(name: 'Petrificar', xpCost: 3),
    'Besta da Terra': PowerWithCost(name: 'Besta da Terra', xpCost: 4),
    'Arenoso': PowerWithCost(name: 'Arenoso', xpCost: 3),
  };
  
  // ELEMENTALISMO - FORÇA DO VENTO
  static const Map<String, PowerWithCost> elementalismoForcaDoVento = {
    'Areo Manipular': PowerWithCost(name: 'Areo Manipular', xpCost: 2),
    'Senso Eólico': PowerWithCost(name: 'Senso Eólico', xpCost: 2),
    'Rajada': PowerWithCost(name: 'Rajada', xpCost: 2),
    'Névoa': PowerWithCost(name: 'Névoa', xpCost: 2),
    'Voz do Vento': PowerWithCost(name: 'Voz do Vento', xpCost: 2),
    'Aero Salto': PowerWithCost(name: 'Aero Salto', xpCost: 2),
    'Cama de Ar': PowerWithCost(name: 'Cama de Ar', xpCost: 2),
    'Corte Eólico': PowerWithCost(name: 'Corte Eólico', xpCost: 2),
    'Parede Turbulenta': PowerWithCost(name: 'Parede Turbulenta', xpCost: 2),
    'Redemoinho': PowerWithCost(name: 'Redemoinho', xpCost: 2),
    'Pressurizar': PowerWithCost(name: 'Pressurizar', xpCost: 2),
    'Vento Lâmina': PowerWithCost(name: 'Vento Lâmina', xpCost: 2),
    'Vórtice': PowerWithCost(name: 'Vórtice', xpCost: 2),
    'Pilar de Vento': PowerWithCost(name: 'Pilar de Vento', xpCost: 2),
    'Inspirar Essência': PowerWithCost(name: 'Inspirar Essência', xpCost: 2),
    'Cria do Vento': PowerWithCost(name: 'Cria do Vento', xpCost: 4),
    'Disparo Zéfiro': PowerWithCost(name: 'Disparo Zéfiro', xpCost: 2),
    'Fúria Elemental': PowerWithCost(name: 'Fúria Elemental', xpCost: 2),
    'Sufocar': PowerWithCost(name: 'Sufocar', xpCost: 4),
    'Tornar Tempestuoso': PowerWithCost(name: 'Tornar Tempestuoso', xpCost: 3),
  };
  
  // DRUIDISMO - ÂMBITO ANIMAL
  static const Map<String, PowerWithCost> druidismoAmbitoAnimal = {
    'Empatia Animal': PowerWithCost(name: 'Empatia Animal', xpCost: 2),
    'Termorregulação': PowerWithCost(name: 'Termorregulação', xpCost: 2),
    'Vagalumes': PowerWithCost(name: 'Vagalumes', xpCost: 2),
    'Gafanhotos': PowerWithCost(name: 'Gafanhotos', xpCost: 2),
    'Apaziguar': PowerWithCost(name: 'Apaziguar', xpCost: 2),
    'Cardume Voraz': PowerWithCost(name: 'Cardume Voraz', xpCost: 2),
    'Identificar Animal': PowerWithCost(name: 'Identificar Animal', xpCost: 2),
    'Senso Animal': PowerWithCost(name: 'Senso Animal', xpCost: 2),
    'Sono Induzido': PowerWithCost(name: 'Sono Induzido', xpCost: 2),
    'Contatar Animal': PowerWithCost(name: 'Contatar Animal', xpCost: 2),
    'Enxame': PowerWithCost(name: 'Enxame', xpCost: 2),
    'Incitar Criatura': PowerWithCost(name: 'Incitar Criatura', xpCost: 2),
    'Regeneração': PowerWithCost(name: 'Regeneração', xpCost: 2),
    'Repelir': PowerWithCost(name: 'Repelir', xpCost: 2),
    'Tornar Animal': PowerWithCost(name: 'Tornar Animal', xpCost: 3),
    'Entendimento Animal': PowerWithCost(name: 'Entendimento Animal', xpCost: 2),
    'Cascos': PowerWithCost(name: 'Cascos', xpCost: 2),
    'Efúgio': PowerWithCost(name: 'Efúgio', xpCost: 2),
    'Focinho': PowerWithCost(name: 'Focinho', xpCost: 2),
    'Olhos Selvagens': PowerWithCost(name: 'Olhos Selvagens', xpCost: 2),
    'Pata Feral': PowerWithCost(name: 'Pata Feral', xpCost: 2),
    'Cauda': PowerWithCost(name: 'Cauda', xpCost: 2),
    'Descamar': PowerWithCost(name: 'Descamar', xpCost: 2),
    'Pele Animal': PowerWithCost(name: 'Pele Animal', xpCost: 2),
    'Predação': PowerWithCost(name: 'Predação', xpCost: 2),
    'Presas Venenosas': PowerWithCost(name: 'Presas Venenosas', xpCost: 2),
    'Urro Frêmito': PowerWithCost(name: 'Urro Frêmito', xpCost: 2),
    'Visão Animal': PowerWithCost(name: 'Visão Animal', xpCost: 2),
    'Aquático': PowerWithCost(name: 'Aquático', xpCost: 3),
    'Asas Braçais': PowerWithCost(name: 'Asas Braçais', xpCost: 3),
    'Eletrolumes': PowerWithCost(name: 'Eletrolumes', xpCost: 3),
    'Invisível aos Animais': PowerWithCost(name: 'Invisível aos Animais', xpCost: 4),
  };
  
  // DRUIDISMO - ÂMBITO ASTRAL
  static const Map<String, PowerWithCost> druidismoAmbitoAstral = {
    'Astrovalia': PowerWithCost(name: 'Astrovalia', xpCost: 2),
    'Força dos Astros': PowerWithCost(name: 'Força dos Astros', xpCost: 2),
    'Companhia': PowerWithCost(name: 'Companhia', xpCost: 2),
    'Espírito da Presa': PowerWithCost(name: 'Espírito da Presa', xpCost: 2),
    'Espírito Indômito': PowerWithCost(name: 'Espírito Indômito', xpCost: 2),
    'Espírito Bruto': PowerWithCost(name: 'Espírito Bruto', xpCost: 2),
    'Espírito da Fera': PowerWithCost(name: 'Espírito da Fera', xpCost: 2),
    'Espíritos da Revoada': PowerWithCost(name: 'Espíritos da Revoada', xpCost: 2),
    'Predador da Água': PowerWithCost(name: 'Predador da Água', xpCost: 2),
    'Espírito da Peçonha': PowerWithCost(name: 'Espírito da Peçonha', xpCost: 2),
    'Espírito Viajante': PowerWithCost(name: 'Espírito Viajante', xpCost: 2),
    'Espírito Guardião': PowerWithCost(name: 'Espírito Guardião', xpCost: 2),
    'Espíritos da Debandada': PowerWithCost(name: 'Espíritos da Debandada', xpCost: 2),
    'Besta da Terra': PowerWithCost(name: 'Besta da Terra', xpCost: 4),
    'Cria do Vento': PowerWithCost(name: 'Cria do Vento', xpCost: 4),
    'Cria Flamejante': PowerWithCost(name: 'Cria Flamejante', xpCost: 4),
    'Fera Elétrica': PowerWithCost(name: 'Fera Elétrica', xpCost: 4),
    'Fera Gélida': PowerWithCost(name: 'Fera Gélida', xpCost: 4),
  };
  
  // DRUIDISMO - ÂMBITO VEGETAL
  static const Map<String, PowerWithCost> druidismoAmbitoVegetal = {
    'Identificar Planta': PowerWithCost(name: 'Identificar Planta', xpCost: 2),
    'Senso Vegetal': PowerWithCost(name: 'Senso Vegetal', xpCost: 2),
    'Cipó': PowerWithCost(name: 'Cipó', xpCost: 2),
    'Pólen': PowerWithCost(name: 'Pólen', xpCost: 2),
    'Cultivar': PowerWithCost(name: 'Cultivar', xpCost: 2),
    'Comungar à Planta': PowerWithCost(name: 'Comungar à Planta', xpCost: 2),
    'Fungos': PowerWithCost(name: 'Fungos', xpCost: 2),
    'Naturalizar': PowerWithCost(name: 'Naturalizar', xpCost: 2),
    'Colher Essência': PowerWithCost(name: 'Colher Essência', xpCost: 4),
    'Emaranhado': PowerWithCost(name: 'Emaranhado', xpCost: 2),
    'Foliação': PowerWithCost(name: 'Foliação', xpCost: 2),
    'Natureza Esmagadora': PowerWithCost(name: 'Natureza Esmagadora', xpCost: 2),
    'Conexão Natural': PowerWithCost(name: 'Conexão Natural', xpCost: 4),
    'Supercrescimento': PowerWithCost(name: 'Supercrescimento', xpCost: 2),
    'Esporos Venenosos': PowerWithCost(name: 'Esporos Venenosos', xpCost: 2),
    'Moldar Planta': PowerWithCost(name: 'Moldar Planta', xpCost: 4),
    'Lumipólen': PowerWithCost(name: 'Lumipólen', xpCost: 2),
    'Pau-aço': PowerWithCost(name: 'Pau-aço', xpCost: 2),
    'Trilha': PowerWithCost(name: 'Trilha', xpCost: 4),
    'Vinhas Venenosas': PowerWithCost(name: 'Vinhas Venenosas', xpCost: 2),
    'Flamopólen': PowerWithCost(name: 'Flamopólen', xpCost: 2),
    'Muda': PowerWithCost(name: 'Muda', xpCost: 2),
    'Nadir Natural': PowerWithCost(name: 'Nadir Natural', xpCost: 3),
    'Cadeia Emaranhada': PowerWithCost(name: 'Cadeia Emaranhada', xpCost: 2),
  };
  
  // CRONOCIÊNCIA - CONTROLE CRONOLÓGICO
  static const Map<String, PowerWithCost> cronocienciaControleCronologico = {
    'Datar': PowerWithCost(name: 'Datar', xpCost: 2),
    'Ajuste Temporal': PowerWithCost(name: 'Ajuste Temporal', xpCost: 2),
    'Acelerar Variáveis': PowerWithCost(name: 'Acelerar Variáveis', xpCost: 2),
    'Prolongar Variáveis': PowerWithCost(name: 'Prolongar Variáveis', xpCost: 2),
    'Retardar': PowerWithCost(name: 'Retardar', xpCost: 2),
    'Resquício Atemporal': PowerWithCost(name: 'Resquício Atemporal', xpCost: 2),
    'Tempo Tolhido': PowerWithCost(name: 'Tempo Tolhido', xpCost: 2),
    'Crono': PowerWithCost(name: 'Crono', xpCost: 2),
    'Hipótese': PowerWithCost(name: 'Hipótese', xpCost: 2),
    'Restituir': PowerWithCost(name: 'Restituir', xpCost: 2),
    'Tempo Dilatado': PowerWithCost(name: 'Tempo Dilatado', xpCost: 2),
    'Decair': PowerWithCost(name: 'Decair', xpCost: 2),
    'Passo Atrás': PowerWithCost(name: 'Passo Atrás', xpCost: 2),
    'Deteriorar': PowerWithCost(name: 'Deteriorar', xpCost: 4),
    'Retorno Forçado': PowerWithCost(name: 'Retorno Forçado', xpCost: 2),
  };
  
  // CRONOCIÊNCIA - CONTROLE FÁSICO
  static const Map<String, PowerWithCost> cronocienciaControleFasico = {
    'Senso Fásico': PowerWithCost(name: 'Senso Fásico', xpCost: 2),
    'Tato Fásico': PowerWithCost(name: 'Tato Fásico', xpCost: 2),
    'Disturbio de Fase': PowerWithCost(name: 'Disturbio de Fase', xpCost: 4),
    'Alento': PowerWithCost(name: 'Alento', xpCost: 2),
    'Espírito Vigia': PowerWithCost(name: 'Espírito Vigia', xpCost: 2),
    'Estase': PowerWithCost(name: 'Estase', xpCost: 2),
    'Espírito da Fera': PowerWithCost(name: 'Espírito da Fera', xpCost: 2),
    'Espírito Soldado': PowerWithCost(name: 'Espírito Soldado', xpCost: 2),
    'Espíritos da Revoada': PowerWithCost(name: 'Espíritos da Revoada', xpCost: 2),
    'Fase Paralela': PowerWithCost(name: 'Fase Paralela', xpCost: 2),
    'Malha Essencial': PowerWithCost(name: 'Malha Essencial', xpCost: 2),
    'Sifão Essencial': PowerWithCost(name: 'Sifão Essencial', xpCost: 2),
    'Salto Fásico': PowerWithCost(name: 'Salto Fásico', xpCost: 2),
    'Paralaxe': PowerWithCost(name: 'Paralaxe', xpCost: 2),
    'Colapsar': PowerWithCost(name: 'Colapsar', xpCost: 2),
    'Espírito Aberrante': PowerWithCost(name: 'Espírito Aberrante', xpCost: 4),
  };
  
  // CRONOCIÊNCIA - CONTROLE GRAVITACIONAL
  static const Map<String, PowerWithCost> cronocienciaControleGravitacional = {
    'Pesar': PowerWithCost(name: 'Pesar', xpCost: 2),
    'Força Escura': PowerWithCost(name: 'Força Escura', xpCost: 2),
    'Lançar Objeto': PowerWithCost(name: 'Lançar Objeto', xpCost: 2),
    'Golpe Gravitacional': PowerWithCost(name: 'Golpe Gravitacional', xpCost: 2),
    'Momento de Força': PowerWithCost(name: 'Momento de Força', xpCost: 2),
    'Puxão Gravitacional': PowerWithCost(name: 'Puxão Gravitacional', xpCost: 2),
    'Queda Leve': PowerWithCost(name: 'Queda Leve', xpCost: 2),
    'Impulso Súbito': PowerWithCost(name: 'Impulso Súbito', xpCost: 2),
    'Mão Distante': PowerWithCost(name: 'Mão Distante', xpCost: 2),
    'Retorno': PowerWithCost(name: 'Retorno', xpCost: 2),
    'Supergravidade': PowerWithCost(name: 'Supergravidade', xpCost: 2),
    'Eixo Gravitacional': PowerWithCost(name: 'Eixo Gravitacional', xpCost: 2),
    'Esmagar': PowerWithCost(name: 'Esmagar', xpCost: 2),
    'Peso Controlado': PowerWithCost(name: 'Peso Controlado', xpCost: 2),
    'Sombrinha': PowerWithCost(name: 'Sombrinha', xpCost: 2),
    'Devora Luz': PowerWithCost(name: 'Devora Luz', xpCost: 3),
    'Disparo Escuro': PowerWithCost(name: 'Disparo Escuro', xpCost: 2),
    'Flutuar Abrupto': PowerWithCost(name: 'Flutuar Abrupto', xpCost: 2),
    'Levitar': PowerWithCost(name: 'Levitar', xpCost: 2),
    'Espera Negra': PowerWithCost(name: 'Espera Negra', xpCost: 4),
  };
  
  // CRONOCIÊNCIA - CONTROLE SIDERAL
  static const Map<String, PowerWithCost> cronocienciaControleSideral = {
    'Astrovalia': PowerWithCost(name: 'Astrovalia', xpCost: 2),
    'Radiação': PowerWithCost(name: 'Radiação', xpCost: 2),
    'Raios X': PowerWithCost(name: 'Raios X', xpCost: 2),
    'Lunático': PowerWithCost(name: 'Lunático', xpCost: 2),
    'Clarão Solar': PowerWithCost(name: 'Clarão Solar', xpCost: 2),
    'Rádio Emanação': PowerWithCost(name: 'Rádio Emanação', xpCost: 2),
    'Sincronia': PowerWithCost(name: 'Sincronia', xpCost: 2),
    'Brilho Lunar': PowerWithCost(name: 'Brilho Lunar', xpCost: 2),
    'Irradiar': PowerWithCost(name: 'Irradiar', xpCost: 2),
    'Senso Radiante': PowerWithCost(name: 'Senso Radiante', xpCost: 3),
    'Ira Solar': PowerWithCost(name: 'Ira Solar', xpCost: 2),
    'Resfriamento Radiante': PowerWithCost(name: 'Resfriamento Radiante', xpCost: 2),
    'Fulgor Solar': PowerWithCost(name: 'Fulgor Solar', xpCost: 4),
    'Meteorito': PowerWithCost(name: 'Meteorito', xpCost: 2),
    'Radiação Ômega': PowerWithCost(name: 'Radiação Ômega', xpCost: 2),
    'Zênite': PowerWithCost(name: 'Zênite', xpCost: 2),
    'Cometa': PowerWithCost(name: 'Cometa', xpCost: 2),
  };
}

// Catálogo de poderes
const Map<String, PowerCategory> powerCatalog = {
  'AOISMO': PowerCategory(
    name: 'AOISMO',
    dativas: [
      PowerDativa(
        name: 'DÁDIVAS DE FAVOR',
        powers: [
          'Impor Mãos',
          'Cura Prístina',
          'Remanescer',
          'Sinal de Aura',
          'Expurgo',
          'Presença Gentil',
          'Restauração',
          'Sinal do Abascanto',
          'Sinal de Proteção',
          'Sinal de Paz',
          'Súplica',
          'Graça de Aura',
          'Badalo Curador',
          'Graça DE Φiliya',
          'Sinal de Couraça',
          'Benção de Cura',
        ],
      ),
      PowerDativa(
        name: 'DADIVAS DE INVOCAÇÃO',
        powers: [
          'Tato Espiritual',
          'Espírito Musicista',
          'Espírito Vigia',
          'Espírito Protetor',
          'Espiríto Soldado',
          'Sinal de Invocação',
          'Espírito Arqueiro',
          'Espírito Esfolador',
          'Graça de ∆iscis',
          'Graça de Okimos',
          'Imponente',
          'Canalizar Guerreiro',
          'Milagre',
          'Passagem Etérea',
        ],
      ),
      PowerDativa(
        name: 'DÁDIVAS DE RETRIBUIÇÃO',
        powers: [
          'Luz Guia',
          'Tribulação',
          'Luz Sacra',
          'Arma Purificada/Profanada',
          'Sinal da Luz',
          'Fardo',
          'Pura Lux',
          'Arma Espiritual',
          'Chama Etérea',
          'Escudo Abençoado',
          'Olhos Justos',
          'Balança de Atos',
          'Flecha de Luz',
          'Graça de Πathos',
          'Badalo Justificador',
          'Graça de Λuxai',
          'Martírio',
          'Condenação',
        ],
      ),
      PowerDativa(
        name: 'DÁDIVAS MACULADAS',
        powers: [
          'Açoite Sombrio',
          'Ideais Turvados',
          'Cinde Sombras',
          'Mortalha Sombria',
          'Sinal de Tormento',
          'Badalo Moribundo',
          'Troca Existencial',
          'Subjugar Vontade',
          'Escuridão Penetrante',
          'Graça de Zoa',
          'Cura Inversa',
          'Graça de Tenebris',
          'Olhos Vazios',
          'Graça de ΣORDOS',
          'Toque Inverso',
        ],
      ),
    ],
  ),
  'ARCANISMO': PowerCategory(
    name: 'ARCANISMO',
    dativas: [
      PowerDativa(
        name: 'ESCOLA ALQUÍMICA',
        powers: [
          'Identificar Matéria',
          'Termorregulação',
          'Reforço Material',
          'Revestir Material',
          'Sono Induzido',
          'Tri Potência',
          'Aquecer Coisa',
          'Esfera Dúplice',
          'Fragilizar',
          'Resfriar Coisa',
          'Reparação',
          'Jato Fumegante',
          'Jato Cáustico',
          'Metábole',
          'Esteroquimía',
          'Moldar Matéria',
          'Nimbos Tóxica',
          'Raio Voltaico',
          'Adaptação Gênica',
          'Concocção Inopinada',
          'Material Superior',
          'Fogo Vesano',
          'Cristalizar Lágrima',
          'Nitro Congelar',
          'ExoLágrima',
          'Surto de Adrenalina',
          'Hipermetábole',
        ],
      ),
      PowerDativa(
        name: 'ESCOLA PSICOCOGONITIVA',
        powers: [
          'Escudar Mente',
          'Falar à Mente',
          'Mente Ativa',
          'Mente Factual',
          'Neuropotência',
          'Cogni Senso',
          'Devaneio',
          'Penetrar a Mente',
          'Afligir Dor',
          'Miragem',
          'Prostração',
          'Tempo Tolhido',
          'Sigilo de Ilusão',
          'Bloqueio Mental',
          'Descarga Psiônica',
          'Projetar Pensamento',
          'Sigilo do Versar',
          'Alucinação',
          'Choque Psiônico',
          'Perscrutar Ideia',
          'Abalo Mental',
          'Oblívio',
          'Ascenção Psiônica',
          'Memória Fabricada',
          'Sigilo da Fantasia',
        ],
      ),
      PowerDativa(
        name: 'ESCOLA METAESSENCIAL',
        powers: [
          'Fluorescência',
          'Rastro Essencial',
          'Corte de Mana',
          'Éter Luz',
          'Repulsão',
          'Centelha',
          'Dardo de Energia',
          'Esfera Antimana',
          'Refluxo de Mana',
          'Grilhões de Estresse',
          'Lâmina de Plasma',
          'Quebra de Sigilo',
          'Transfusão Essencial',
          'Esconjurar',
          'Absorção Essencial',
          'Barreira Adiabática',
          'Dobrar Essência',
          'Excrucio',
          'Feixe de Plasma',
          'Campo Desconexo',
          'Sigilo do Manto Obscuro',
          'Nova Arcana',
          'Ascenção Meta Essencial',
        ],
      ),
      PowerDativa(
        name: 'ESCOLA ESCRIBA',
        powers: [
          'Sigilo Mensagem',
          'Velar Sigilos',
          'Sigilo Vigia',
          'Sigilo Tranca',
          'Sigilo Lança',
          'Arma Sigilada',
          'Ciência Escriba',
          'Sigilo Armadilha',
          'Sigilo Supressor',
          'Círculo Arcano',
          'Manter em Sigilo',
          'Sigilo Barreira',
          'Contra Sigilo',
          'Manter Aprimorado',
          'Sigilo de Translado',
          'Ascensão Arcano Escriba',
        ],
      ),
    ],
  ),
  'BARDISMO': PowerCategory(
    name: 'BARDISMO',
    dativas: [
      PowerDativa(
        name: 'ARTES DA FORTUNA',
        powers: [
          'Manipular Entropia',
          'Entropia Essencial',
          'Sorte em Aposta',
          'Equilibrar Chances',
          'Sorte Em Essência',
          'Boaventura',
          'Infortúnio',
          'Canalizar Sorte',
          'Aura de sorte',
          'Conto Heroico',
          'Sorte em Vida',
          'Léria Desastrosa',
          'Sorte em Ação',
          'Sorte em Morte',
          'Sorte Destinada',
        ],
      ),
      PowerDativa(
        name: 'ARTES INSTRUMENTAIS',
        powers: [
          'Cacofonia',
          'Canto',
          'Allegretto',
          'Espasmo',
          'Harmonia',
          'Ranger',
          'Sinfonia Discordante',
          'Acorde Edaz',
          'Alarde',
          'Coda de Guerra',
          'Canção de Ninar',
          'Vertigem',
          'Melopeia de Vidro',
          'Serenata',
          'Sonata Muda',
          'Vibrato',
          'Choque Sonoro',
          'Valsa Lúdica',
          'Ária do Campeão',
          'Réquiem',
          'Peça do Ventríloquo',
        ],
      ),
      PowerDativa(
        name: 'ARTES PSICOVOCAIS',
        powers: [
          'Falar à Mente',
          'Voz Confortante',
          'Som Falso',
          'Fraqueza',
          'Lábia Afinada',
          'Implantar Pensamento',
          'Tolice',
          'Carisma de Bardo',
          'Palavras Dolorosas',
          'Palavra de Incentivo',
          'Terceira Voz',
          'Voz Estrondosa',
          'Bloqueio Mental',
          'Fofoca Contagiosa',
          'Grande Estima',
          'Sussurros',
          'Voz da Lembrança',
          'Oblívio',
          'Palavras de Comando',
          'Memória Fabricada',
        ],
      ),
      PowerDativa(
        name: 'ARTES TEATRAIS',
        powers: [
          'Dança Chamativa',
          'Encenação',
          'Fleuma',
          'Morte Fingida',
          'Passada Avante',
          'Dança da Égide',
          'Dança Elusiva',
          'Passada Furtiva',
          'Sanguíneo',
          'Atrabílis',
          'Contrapasso',
          'Cólera',
          'Dança Fatal',
          'Detenção Hipnótica',
          'Incógnito',
        ],
      ),
    ],
  ),
  'CRONOCIÊNCIA': PowerCategory(
    name: 'CRONOCIÊNCIA',
    dativas: [
      PowerDativa(
        name: 'CONTROLE CRONOLÓGICO',
        powers: [
          'Datar',
          'Ajuste Temporal',
          'Acelerar Variáveis',
          'Prolongar Variáveis',
          'Retardar',
          'Resquício Atemporal',
          'Tempo Tolhido',
          'Crono',
          'Hipótese',
          'Restituir',
          'Tempo Dilatado',
          'Decair',
          'Passo Atrás',
          'Deteriorar',
          'Retorno Forçado',
        ],
      ),
      PowerDativa(
        name: 'CONTROLE FÁSICO',
        powers: [
          'Senso Fásico',
          'Tato Fásico',
          'Disturbio de Fase',
          'Alento',
          'Espírito Vigia',
          'Estase',
          'Espírito da Fera',
          'Espírito Soldado',
          'Espíritos da Revoada',
          'Fase Paralela',
          'Malha Essencial',
          'Sifão Essencial',
          'Salto Fásico',
          'Paralaxe',
          'Colapsar',
          'Espírito Aberrante',
        ],
      ),
      PowerDativa(
        name: 'CONTROLE GRAVITACIONAL',
        powers: [
          'Pesar',
          'Força Escura',
          'Lançar Objeto',
          'Golpe Gravitacional',
          'Momento de Força',
          'Puxão Gravitacional',
          'Queda Leve',
          'Impulso Súbito',
          'Mão Distante',
          'Retorno',
          'Supergravidade',
          'Eixo Gravitacional',
          'Esmagar',
          'Peso Controlado',
          'Sombrinha',
          'Devora Luz',
          'Disparo Escuro',
          'Flutuar Abrupto',
          'Levitar',
          'Espera Negra',
        ],
      ),
      PowerDativa(
        name: 'CONTROLE SIDERAL',
        powers: [
          'Astrovalia',
          'Radiação',
          'Raios X',
          'Lunático',
          'Clarão Solar',
          'Rádio Emanação',
          'Sincronia',
          'Brilho Lunar',
          'Irradiar',
          'Senso Radiante',
          'Ira Solar',
          'Resfriamento Radiante',
          'Fulgor Solar',
          'Meteorito',
          'Radiação Ômega',
          'Zênite',
          'Cometa',
        ],
      ),
    ],
  ),
  'DRUIDISMO': PowerCategory(
    name: 'DRUIDISMO',
    dativas: [
      PowerDativa(
        name: 'ÂMBITO ANIMAL',
        powers: [
          'Empatia Animal',
          'Termorregulação',
          'Vagalumes',
          'Gafanhotos',
          'Apaziguar',
          'Cardume Voraz',
          'Identificar Animal',
          'Senso Animal',
          'Sono Induzido',
          'Contatar Animal',
          'Enxame',
          'Incitar Criatura',
          'Regeneração',
          'Repelir',
          'Tornar Animal',
          'Entendimento Animal',
          'Cascos',
          'Efúgio',
          'Focinho',
          'Olhos Selvagens',
          'Pata Feral',
          'Cauda',
          'Descamar',
          'Pele Animal',
          'Predação',
          'Presas Venenosas',
          'Urro Frêmito',
          'Visão Animal',
          'Aquático',
          'Asas Braçais',
          'Eletrolumes',
          'Invisível aos Animais',
        ],
      ),
      PowerDativa(
        name: 'ÂMBITO ASTRAL',
        powers: [
          'Astrovalia',
          'Força dos Astros',
          'Companhia',
          'Espírito da Presa',
          'Espírito Indômito',
          'Espírito Bruto',
          'Espírito da Fera',
          'Espíritos da Revoada',
          'Predador da Água',
          'Espírito da Peçonha',
          'Espírito Viajante',
          'Espírito Guardião',
          'Espíritos da Debandada',
          'Besta da Terra',
          'Cria do Vento',
          'Cria Flamejante',
          'Fera Elétrica',
          'Fera Gélida',
        ],
      ),
      PowerDativa(
        name: 'ÂMBITO VEGETAL',
        powers: [
          'Identificar Planta',
          'Senso Vegetal',
          'Cipó',
          'Pólen',
          'Cultivar',
          'Comungar à Planta',
          'Fungos',
          'Naturalizar',
          'Colher Essência',
          'Emaranhado',
          'Foliação',
          'Natureza Esmagadora',
          'Conexão Natural',
          'Supercrescimento',
          'Esporos Venenosos',
          'Moldar Planta',
          'Lumipólen',
          'Pau-aço',
          'Trilha',
          'Vinhas Venenosas',
          'Flamopólen',
          'Muda',
          'Nadir Natural',
          'Cadeia Emaranhada',
        ],
      ),
    ],
  ),
  'ELEMENTALISMO': PowerCategory(
    name: 'ELEMENTALISMO',
    dativas: [
      PowerDativa(
        name: 'FORÇA DA ÁGUA',
        powers: [
          'Senso Hídrico',
          'Correnteza',
          'Resfriar Coisa',
          'Cristalizar',
          'Estilhaços',
          'Pancada d\'Água',
          'Natural ao Frio',
          'Aura Fria',
          'Barreira Cristalizada',
          'Golpe Glacial',
          'Onda de Frio',
          'Rajada Congelante',
          'Estalagmite',
          'Espelho d\'Água',
          'Água Pristina',
          'Estalo Gélido',
          'Fera Gélida',
          'Abraço Frígido',
          'Crio',
          'Maremoto',
        ],
      ),
      PowerDativa(
        name: 'FORÇA DO FOGO',
        powers: [
          'Ignição',
          'Sinal da Fogueira',
          'Bola de Fogo',
          'Esfumaçar',
          'Flamejar',
          'Aquecer Coisa',
          'Natural ao Ardor',
          'Aura Quente',
          'Fumaça Negra',
          'Lança Chamas',
          'Incinerar',
          'Onda de Calor',
          'Revés Flamejante',
          'Esfera Explosiva',
          'Labareda',
          'Pilar de Chamas',
          'Cria Flamejante',
          'Tornar Escória',
        ],
      ),
      PowerDativa(
        name: 'FORÇA DO RAIO',
        powers: [
          'Choque',
          'Raio',
          'Choque Atordoante',
          'Eletrizar',
          'Sinal do Raio',
          'Estrondo',
          'Raio Voltáico',
          'Cólera de Raios',
          'Descarga',
          'Onda de Choque',
          'Sobre Carga',
          'Essência Estática',
          'Sibilar',
          'Fera Elétrica',
          'Trovão',
          'Eletrocussão',
        ],
      ),
      PowerDativa(
        name: 'FORÇA DA TERRA',
        powers: [
          'Senso Sísmico',
          'Moldar Terra',
          'Pilar de Terra',
          'Jato de Areia',
          'Muro',
          'Golpe Sísmico',
          'Pedregulho',
          'Terra Movediça',
          'Abalo Sísmico',
          'Deslizamento',
          'Rijeza da Pedra',
          'Terra Magnitude',
          'Força Terrena',
          'Quebra Terra',
          'Petrificar',
          'Besta da Terra',
          'Arenoso',
        ],
      ),
      PowerDativa(
        name: 'FORÇA DO VENTO',
        powers: [
          'Areo Manipular',
          'Senso Eólico',
          'Rajada',
          'Névoa',
          'Voz do Vento',
          'Aero Salto',
          'Cama de Ar',
          'Corte Eólico',
          'Parede Turbulenta',
          'Redemoinho',
          'Pressurizar',
          'Vento Lâmina',
          'Vórtice',
          'Pilar de Vento',
          'Inspirar Essência',
          'Cria do Vento',
          'Disparo Zéfiro',
          'Fúria Elemental',
          'Sufocar',
          'Tornar Tempestuoso',
        ],
      ),
    ],
  ),
  'SABAKISMO': PowerCategory(
    name: 'SABAKISMO',
    dativas: [
      PowerDativa(
        name: 'DOMÍNIO DO EXÍCIO',
        powers: [
          'Açoite Sombrio',
          'Sifonar',
          'Fende Luz',
          'Mortalha Sombria',
          'Aflição do Exício',
          'Obscurecer Olhos',
          'Quebra de Sigilo',
          'Espírito Dilacerador',
          'Espírito Adepto',
          'Hausto',
          'Látego',
          'Troca Existencial',
          'Excrucio',
          'Devora Luz',
          'Espírito Esfolador',
          'Sombra',
          'Olhos Vazios',
          'Espírito Ceifador',
          'Marcações do Exício',
          'Vida Falsa',
          'Canalizar Sombrio',
        ],
      ),
      PowerDativa(
        name: 'DOMÍNIO MENTAL',
        powers: [
          'Falar à Mente',
          'Mente Ativa',
          'Aliviar Dor',
          'Entorpecer',
          'Adinamia',
          'Afligir Dor',
          'Cogni Senso',
          'Devaneio',
          'Ímpeto',
          'Perseguição',
          'Terror',
          'Torpor',
          'Vislumbre',
          'Vox',
          'Augúrio',
          'Dominar Criatura',
          'Perdição',
          'Alucinação',
          'Detenção Hipnótica',
          'Grunhido',
          'Imperar',
          'Abalo Mental',
          'Presença Impositiva',
          'Marca do Lacaio',
          'Olhar Cego',
          'Marcações da Mente',
        ],
      ),
      PowerDativa(
        name: 'DOMÍNIO DAS PRAGAS',
        powers: [
          'Gafanhotos',
          'Pestilência',
          'Irritação',
          'Morbo',
          'Enxame',
          'Fétido',
          'Adoecer',
          'Bodum',
          'Estagnação',
          'Mangra',
          'Marcas de Futum',
          'Praga',
          'Conspurgar',
          'Marcas Putrefeitas',
          'Miasma',
          'Ruína',
          'Vetores',
          'Chagas Necróticas',
          'Marcações Estagnantes',
        ],
      ),
      PowerDativa(
        name: 'DOMÍNIO DO SANGUE',
        powers: [
          'Sangria',
          'Coagulação',
          'Suturar',
          'Ler Sangue',
          'Hemorragia',
          'Eco Sanguíneo',
          'Sanguívoro',
          'Sedento',
          'Sanguessuga',
          'Arte do Sangue',
          'Véu de Sangue',
          'Sangue Podre',
          'Tratado de Sangue',
          'Veias de Flagelo',
          'Trabalhar o Sangue',
          'Lágrima de Sangue',
          'Vampirismo',
          'Tornar Estrige',
        ],
      ),
    ],
  ),
};

// Classe para representar um poder selecionado
class SelectedPower {
  final String category;
  final String dativa;
  final String power;

  SelectedPower({
    required this.category,
    required this.dativa,
    required this.power,
  });

  // Converter para string para armazenamento
  String toStorageString() => '$category|$dativa|$power';

  // Criar a partir de string
  factory SelectedPower.fromStorageString(String str) {
    final parts = str.split('|');
    if (parts.length == 3) {
      return SelectedPower(
        category: parts[0],
        dativa: parts[1],
        power: parts[2],
      );
    }
    
    return SelectedPower(
      category: 'AOISMO',
      dativa: 'Desconhecida',
      power: str,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedPower &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          dativa == other.dativa &&
          power == other.power;

  @override
  int get hashCode => category.hashCode ^ dativa.hashCode ^ power.hashCode;
}


