
import 'package:flutter/material.dart';
import 'home_page.dart';

class DetailPage extends StatelessWidget {
  final AudioFormat format;

  const DetailPage({
    super.key,
    required this.format,
  });

  String getFullDescription() {
    switch (format.name) {
      case 'MP3':
        return 'MP3 (MPEG Audio Layer III) — один из самых '
            'распространённых форматов цифрового аудио. '
            'Использует сжатие с потерями, благодаря чему '
            'размер аудиофайлов значительно уменьшается. '
            'Применяется для хранения музыки, подкастов '
            'и передачи звука через интернет.';

      case 'WAV':
        return 'WAV (Waveform Audio File Format) — формат '
            'хранения цифрового звука, разработанный '
            'Microsoft и IBM. Часто используется для '
            'несжатого аудио в формате PCM. '
            'Обеспечивает высокое качество звучания, '
            'но требует большого объёма памяти.';

      case 'FLAC':
        return 'FLAC (Free Lossless Audio Codec) — '
            'формат сжатия аудио без потери качества. '
            'Позволяет уменьшить размер файла, '
            'сохраняя исходные звуковые данные. '
            'Используется для архивирования музыки '
            'и прослушивания записей высокого качества.';

      case 'AAC':
        return 'AAC (Advanced Audio Coding) — современный '
            'формат кодирования аудио с потерями. '
            'При одинаковом битрейте обычно обеспечивает '
            'лучшее качество звучания по сравнению с MP3. '
            'Широко используется в потоковых сервисах, '
            'мобильных устройствах и видеоконтенте.';

      case 'OGG':
        return 'OGG — открытый формат мультимедийного '
            'контейнера, который часто используется '
            'совместно с аудиокодеком Vorbis. '
            'Поддерживает эффективное сжатие звука '
            'и применяется в играх, приложениях '
            'и мультимедийных проектах.';

      default:
        return format.description;
    }
  }

  void openHome(BuildContext context) {
    Navigator.pop(context);
  }

  void openProfile(BuildContext context) {
    Navigator.pop(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FA),

      appBar: AppBar(
        title: Text(
          format.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF5A76),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 650,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFFF5A76),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/${format.image}',
                        height: 180,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 20),

                      Text(
                        format.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.05,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Описание формата',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        getFullDescription(),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: 250,
                  child: ElevatedButton.icon(
                    onPressed: () => openHome(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      'Вернуться назад',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5A76),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Color(0xFFFF5A76),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Бочаров Пётр Андреевич\nИКБО-63-23',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        backgroundColor: const Color(0xFFFFEEF2),
        indicatorColor: const Color(0xFFFFC5D0),
        labelBehavior:
        NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          if (index == 0) {
            openHome(context);
          } else if (index == 1) {
            openProfile(context);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
