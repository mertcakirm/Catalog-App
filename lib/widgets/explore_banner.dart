import 'dart:async';

import 'package:flutter/material.dart';

class ExploreBanner extends StatefulWidget {
  const ExploreBanner({super.key});

  @override
  State<ExploreBanner> createState() => _ExploreBannerState();
}

class _ExploreBannerState extends State<ExploreBanner> {
  final PageController _bannerController = PageController(
    viewportFraction: 0.92,
  );
  int _currentBanner = 0;
  Timer? _timer;

  // Görsel olarak dikkat çekici ve zenginleştirilmiş banner listesi
  final List<_BannerData> _banners = const [
    _BannerData(
      title: 'Yeni Sezon\nBaşladı',
      subtitle: '%40\'a varan özel indirim fırsatlarıyla tarzını yenile.',
      emoji: '🛍️',
      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
    ),
    _BannerData(
      title: 'Geleceğin\nTeknolojisi',
      subtitle: 'Hayatını kolaylaştıracak en yeni akıllı cihazlar.',
      emoji: '🎧',
      colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
    ),
    _BannerData(
      title: 'Özgün ve\nŞık Tarz',
      subtitle: 'Moda dünyasının en trend parçaları seni bekliyor.',
      emoji: '👗',
      colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
    ),
    _BannerData(
      title: 'Yaşam Alanı\nDönüşümü',
      subtitle: 'Evinize modern bir dokunuş yapacak tasarımlar.',
      emoji: '🪑',
      colors: [Color(0xFF1D976C), Color(0xFF93F9B9)],
    ),
    _BannerData(
      title: 'Sağlıklı ve\nAktif Yaşam',
      subtitle: 'Spor tutkunları için performans odaklı seçimler.',
      emoji: '🏀',
      colors: [Color(0xFFF7971E), Color(0xFFFFD200)],
    ),
    _BannerData(
      title: 'Güzellik ve\nBakım Sırları',
      subtitle: 'Cildine iyi gelecek en seçkin kozmetik ürünleri.',
      emoji: '✨',
      colors: [Color(0xFF833AB4), Color(0xFFFD1D1D)],
    ),
    _BannerData(
      title: 'Hızlı ve Güvenli\nAlışveriş',
      subtitle: 'Binlerce ürün kapına kadar gelsin, keyfini çıkar.',
      emoji: '🚀',
      colors: [Color(0xFF0052D4), Color(0xFF4364F7)],
    ),
    _BannerData(
      title: 'Özel Fırsat\nÜrünleri',
      subtitle: 'Sınırlı süreli indirimleri kaçırma, avantajı yakala.',
      emoji: '🔥',
      colors: [Color(0xFFEB3349), Color(0xFFF45C43)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_bannerController.hasClients) return;
      final next = (_currentBanner + 1) % _banners.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 175,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemBuilder: (context, index) {
              final b = _banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: b.colors,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: b.colors.first.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        bottom: -40,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 12,
                        child: Text(
                          b.emoji,
                          style: const TextStyle(fontSize: 75),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              b.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                height: 1.1,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 200,
                              child: Text(
                                b.subtitle,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            final active = i == _currentBanner;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: active ? 22 : 6,
              decoration: BoxDecoration(
                color: active ? Colors.white : Colors.white30,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _BannerData {
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> colors;

  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.colors,
  });
}
