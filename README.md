# ParsCrucis App

Aplicativo **Flutter** focado em apoiar sessões de **Parscrucis**: criar, organizar e consultar **Personagens** de forma rápida no celular.
 

## Motivos da criação do app

- **Agilidade na mesa**: reduzir tempo perdido com anotações soltas, PDFs e planilhas durante a sessão.
- **Centralização**: manter as informações do personagem em um único lugar (criação + consulta).
- **Organização**: facilitar o gerenciamento de múltiplos personagens (ex.: versões, rascunhos, fichas diferentes).
- **Acesso offline**: permitir consulta prática mesmo sem internet (ideal para eventos e locais sem sinal).

## Principais utilidades

- **Criar um novo Persona**: fluxo de criação rápido.
- **Carregar/Listar personagens**: visualizar e abrir personagens já criados.
- **Tela inicial (Splash)**: entrada do app.
- **Informações/Config (Copyright)**: seção informativa do projeto.


## Instalação no celular (sem Play Store / App Store)

Esta seção é para **usuário final**: você só precisa do arquivo do app já pronto.

### Onde conseguir o arquivo do app

- **Android**: um arquivo `ParsCrucis.apk` (ou `app-release.apk`)
- **iOS**: um arquivo `ParsCrucis.ipa` (instalado via *sideload*)

> Esses arquivos serão disponibilizados pelo autor do projeto.

### Android (instalar APK “por fora”)

1. Copie o arquivo **`.apk`** para o celular (USB, WhatsApp, Telegram, Drive, etc.).
2. No Android, abra o arquivo.
3. Se aparecer bloqueio de segurança, habilite **“Instalar apps desconhecidos”** para o app que você está usando (Arquivos/Chrome/Drive).
4. Confirme **Instalar**.

### iOS (instalar sem App Store)

No iOS, instalar fora da App Store exige **sideload** (assinatura). Na prática você vai precisar de um computador.

#### Opção A — AltStore (muito comum)

- Instale o **AltStore** no iPhone e use o computador para assinar/instalar o arquivo **`.ipa`**.
- Observação: com Apple ID gratuita, a assinatura costuma **expirar** e precisa ser renovada periodicamente.

#### Opção B — Sideloadly (alternativa)

- Use o **Sideloadly** no computador para instalar o **`.ipa`** no iPhone usando sua Apple ID.
- Observação: as mesmas limitações de assinatura podem se aplicar.

## Desenvolvimento

Rodar em modo debug:

```bash
flutter pub get
flutter run
```


