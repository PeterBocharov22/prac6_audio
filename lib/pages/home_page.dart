
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../routes.dart';
import 'profile_page.dart';

class AudioFormat {
  final String name;
  final String image;
  final String description;
  final IconData icon;

  const AudioFormat({
    required this.name,
    required this.image,
    required this.description,
    required this.icon,
  });
}

const formats = [
  AudioFormat(
    name: 'MP3',
    image: 'mp3.png',
    description: 'Популярный формат сжатия аудио с потерями.',
    icon: Icons.music_note,
  ),
  AudioFormat(
    name: 'WAV',
    image: 'wav.png',
    description: 'Формат для хранения несжатого звука высокого качества.',
    icon: Icons.graphic_eq,
  ),
  AudioFormat(
    name: 'FLAC',
    image: 'flac.png',
    description: 'Формат сжатия аудио без потери качества.',
    icon: Icons.high_quality,
  ),
  AudioFormat(
    name: 'AAC',
    image: 'aac.png',
    description: 'Современный формат сжатия аудио с потерями.',
    icon: Icons.headphones,
  ),
  AudioFormat(
    name: 'OGG',
    image: 'ogg.png',
    description: 'Открытый формат для хранения сжатого аудио.',
    icon: Icons.audiotrack,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  Future<void> openDetails(AudioFormat format) async {
    final result = await Navigator.pushNamed<int>(
      context,
      Routes.detail,
      arguments: format,
    );

    if (!mounted) return;

    if (result == 1) {
      setState(() {
        selectedIndex = 1;
      });
    }
  }

  Widget buildHome() {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 600;

    final isDesktop = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;

    final verticalSpacing = isDesktop ? 25.0 : 15.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 600 ? 2 : 1;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isWide ? 30 : 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Форматы аудиофайлов',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Основные форматы цифрового аудио '
                        'отличаются способом сжатия, качеством '
                        'звучания и размером файла.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: verticalSpacing),

                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: formats.length,
                      itemBuilder: (context, index) {
                        final format = formats[index];

                        return GestureDetector(
                          onTap: () => openDetails(format),
                          child: Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 15),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/${format.image}',
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: verticalSpacing),

                  const Text(
                    'Основные форматы',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: formats.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: verticalSpacing,
                      mainAxisExtent: 115,
                    ),
                    itemBuilder: (context, index) {
                      final format = formats[index];

                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Icon(
                            format.icon,
                            color: const Color(0xFFFF5A76),
                            size: 30,
                          ),
                          title: Text(
                            format.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            format.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                          onTap: () => openDetails(format),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: verticalSpacing),

                  const Divider(),

                  const SizedBox(height: 8),

                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFFFF5A76),
                        size: 30,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Бочаров Пётр Андреевич\nИКБО-63-23',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? 'Практическая работа №6'
              : 'Профиль',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF5A76),
        foregroundColor: Colors.white,
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: [
          buildHome(),
          const ProfilePage(
            name: 'Бочаров Пётр Андреевич',
            email: 'student@mail.ru',
            embedded: true,
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: const Color(0xFFFFEEF2),
        indicatorColor: const Color(0xFFFFC5D0),
        labelBehavior:
        NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
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
