# ParsCrucis App

Aplicativo **Flutter** focado em apoiar sessões de **Parscrucis**: criar, organizar e consultar **Personagens** de forma rápida no celular.

## Motivos da criação do app

- **Agilidade na mesa**: reduzir tempo perdido com anotações soltas, PDFs e planilhas durante a sessão.
- **Centralização**: manter as informações do personagem em um único lugar (criação + consulta).
- **Organização**: facilitar o gerenciamento de múltiplos personagens (ex.: versões, rascunhos, fichas diferentes).
- **Acesso offline**: permitir consulta prática mesmo sem internet (ideal para eventos e locais sem sinal).

## Principais utilidades

- **Criar um novo Persona**: fluxo de criação rápido (rota `'/novo'` no app).
- **Carregar/Listar personagens**: visualizar e abrir personagens já criados (rota `'/carregar'`).
- **Tela inicial (Splash)**: entrada do app (rota `'/'`).
- **Informações/Config (Copyright)**: seção informativa do projeto (rota `'/config'`).


## Instalação no celular (sem Play Store / App Store)

### Android (APK “por fora”)

Pré-requisitos:

- Ter **Flutter** instalado na máquina (para gerar o APK).
- Ter um celular Android com **Depuração USB** opcional (se for instalar via cabo) e permissão para **instalar apps de fontes desconhecidas**.

Gerar o APK:

```bash
flutter pub get
flutter build apk --release
```

O arquivo será gerado em:

- `build/app/outputs/flutter-apk/app-release.apk`

Instalar no celular:

- **Opção A (enviar o arquivo)**: copie o `app-release.apk` para o celular (USB/WhatsApp/Drive) e abra o arquivo para instalar.
- **Opção B (via USB com adb)**:

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

### iOS (sem App Store)

No iOS, instalar fora da App Store geralmente exige **sideload** com assinatura. Existem 2 caminhos comuns:

#### Opção A — Xcode (recomendado para uso próprio)

Pré-requisitos:

- macOS com **Xcode**
- iPhone conectado por cabo
- Uma Apple ID (conta gratuita funciona, com limitações de assinatura)

Passos:

```bash
flutter pub get
flutter build ios --release
```

Em seguida:

- Abra `ios/Runner.xcworkspace` no Xcode
- Selecione seu iPhone como destino
- Em **Signing & Capabilities**, selecione seu **Team**
- Clique em **Run**

#### Opção B — Sideload (AltStore/Sideloadly)

- Gere o app iOS (ou use o projeto no Xcode) e assine com sua Apple ID via ferramenta de sideload.
- Observação: assinaturas com conta gratuita tendem a expirar (precisa reinstalar/reassinar periodicamente).

## Desenvolvimento

Rodar em modo debug:

```bash
flutter pub get
flutter run
```

