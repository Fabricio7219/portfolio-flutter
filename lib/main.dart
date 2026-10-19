import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ============================================================
//  EDITE AQUI: todo o conteúdo do portfólio fica nestas constantes
// ============================================================
const String nome = 'Fabrício Araújo';
const String tituloProjeto = 'Frete Legal: Calculadora de Piso Mínimo de Frete';
const String subtitulo =
    'App Android publicado na Google Play que calcula o piso mínimo de frete '
    'conforme a tabela da ANTT, feito para caminhoneiros autônomos.';

const List<String> tags = ['Mobile', 'Flutter', 'Firebase'];

const String linkGithub = 'https://github.com/Fabricio7219/FreteLEGAL';
const String linkDeploy =
    'https://play.google.com/store/apps/details?id=com.fretepro.frete_legal';
const String email = 'mailto:faandrade7219@gmail.com';
const String linkedin = 'https://www.linkedin.com/in/fabricio-araujo-qa';

const String desafio =
    'Caminhoneiros autônomos têm dificuldade de saber se o frete oferecido '
    'respeita o piso mínimo da ANTT, porque o cálculo da resolução é complexo.';
const String solucao =
    'Um app simples que aplica as regras da Resolução ANTT 6.084/2026 e mostra '
    'na hora o valor mínimo que o frete deve pagar.';

const List<List<String>> tecnologias = [
  ['Flutter', 'Interface multiplataforma com um único código.'],
  ['Dart', 'Linguagem do Flutter, usada na lógica de cálculo do piso.'],
  ['AdMob', 'Monetização com anúncios dentro do app.'],
  ['In-App Purchase', 'Versão premium vitalícia, sem anúncios.'],
  ['GitHub Pages', 'Hospedagem da política de privacidade exigida pela loja.'],
];

const List<List<dynamic>> features = [
  [Icons.calculate, 'Cálculo do Piso', 'Valor mínimo conforme a tabela ANTT.'],
  [Icons.local_shipping, 'Feito pro Autônomo', 'Pensado por quem vive a estrada.'],
  [Icons.workspace_premium, 'Versão Premium', 'Compra única que remove anúncios.'],
];

const List<List<String>> resultados = [
  ['Publicação', 'App publicado e disponível na Google Play Store.'],
  ['Aprendizado', 'Resolver erros de Gradle, atualizar versões do Flutter e '
      'adaptar o NDK para páginas de memória de 16KB exigidas pelo Android.'],
];
// ============================================================

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio - $nome',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

Future<void> abrirLink(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Chaves usadas pelo menu para rolar até cada seção
    final keyProjetos = GlobalKey();
    final keySobre = GlobalKey();
    final keyContato = GlobalKey();

    void irPara(GlobalKey key) => Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 500),
        );

    return Scaffold(
      // ---------------- CABEÇALHO / MENU ----------------
      appBar: AppBar(
        title: const Text(nome, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(onPressed: () => irPara(keyProjetos), child: const Text('Projetos')),
          TextButton(onPressed: () => irPara(keySobre), child: const Text('Sobre')),
          TextButton(onPressed: () => irPara(keyContato), child: const Text('Contato')),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardDestaque(key: keyProjetos),
                  const SizedBox(height: 24),
                  const AreaVisual(),
                  const SizedBox(height: 24),
                  SecaoProblemaSolucao(key: keySobre),
                  const SizedBox(height: 24),
                  const SecaoTecnologias(),
                  const SizedBox(height: 24),
                  const SecaoFeatures(),
                  const SizedBox(height: 24),
                  const SecaoResultados(),
                  const SizedBox(height: 24),
                  SecaoContato(key: keyContato),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Card base reutilizado por todas as seções
class Secao extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Widget child;
  const Secao({super.key, required this.titulo, required this.icone, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icone, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Flexible(
                child: Text(titulo,
                    style: Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
            ]),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

// ---------------- 1. CARD DE DESTAQUE ----------------
class CardDestaque extends StatelessWidget {
  const CardDestaque({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Card(
      color: cores.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((t) => Chip(label: Text(t))).toList(),
            ),
            const SizedBox(height: 16),
            Text(tituloProjeto,
                style: Theme.of(context).textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(subtitulo, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: () => abrirLink(linkGithub),
                  icon: const Icon(Icons.code),
                  label: const Text('Ver Código no GitHub'),
                ),
                FilledButton.icon(
                  onPressed: () => abrirLink(linkDeploy),
                  icon: const Icon(Icons.rocket_launch),
                  label: const Text('Ver na Google Play'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- 2. ÁREA VISUAL (MOCKUP) ----------------
class AreaVisual extends StatelessWidget {
  const AreaVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/app_icon.jpg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// ---------------- 3. PROBLEMA E SOLUÇÃO ----------------
class SecaoProblemaSolucao extends StatelessWidget {
  const SecaoProblemaSolucao({super.key});

  @override
  Widget build(BuildContext context) {
    return Secao(
      titulo: 'O Problema e a Solução',
      icone: Icons.lightbulb,
      child: Column(
        children: const [
          ListTile(
            leading: Icon(Icons.warning_amber),
            title: Text('O Desafio'),
            subtitle: Text(desafio),
          ),
          ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text('A Solução'),
            subtitle: Text(solucao),
          ),
        ],
      ),
    );
  }
}

// ---------------- 4. TECNOLOGIAS ----------------
class SecaoTecnologias extends StatelessWidget {
  const SecaoTecnologias({super.key});

  @override
  Widget build(BuildContext context) {
    return Secao(
      titulo: 'Arquitetura e Tecnologias',
      icone: Icons.build,
      child: Column(
        children: tecnologias
            .map((t) => ListTile(
                  leading: Chip(label: Text(t[0])),
                  title: Text(t[1]),
                ))
            .toList(),
      ),
    );
  }
}

// ---------------- 5. FEATURES ----------------
class SecaoFeatures extends StatelessWidget {
  const SecaoFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Secao(
      titulo: 'Características Principais',
      icone: Icons.bolt,
      child: Wrap(
        // Wrap quebra a linha sozinho em telas pequenas (responsivo)
        spacing: 16,
        runSpacing: 16,
        children: features
            .map((f) => SizedBox(
                  width: 280,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(f[0] as IconData, size: 32),
                          const SizedBox(height: 8),
                          Text(f[1] as String,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(f[2] as String),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

// ---------------- 6. RESULTADOS ----------------
class SecaoResultados extends StatelessWidget {
  const SecaoResultados({super.key});

  @override
  Widget build(BuildContext context) {
    return Secao(
      titulo: 'Resultados e Lições Aprendidas',
      icone: Icons.trending_up,
      child: Column(
        children: resultados
            .map((r) => ListTile(
                  leading: const Icon(Icons.star_outline),
                  title: Text(r[0]),
                  subtitle: Text(r[1]),
                ))
            .toList(),
      ),
    );
  }
}

// ---------------- 7. CONTATO (CALL TO ACTION) ----------------
class SecaoContato extends StatelessWidget {
  const SecaoContato({super.key});

  @override
  Widget build(BuildContext context) {
    return Secao(
      titulo: 'Vamos trabalhar juntos?',
      icone: Icons.handshake,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gostou do projeto? Estou disponível para novos desafios e contratos.'),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => abrirLink(email),
                icon: const Icon(Icons.email),
                label: const Text('Enviar E-mail'),
              ),
              OutlinedButton.icon(
                onPressed: () => abrirLink(linkedin),
                icon: const Icon(Icons.person),
                label: const Text('Conectar no LinkedIn'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

