# 🛍️ Modern Catalog App

Modern, şık ve yüksek performanslı bir kullanıcı deneyimi sunmak amacıyla **Flutter** ile geliştirilmiş, minimalist ve estetik bir e-ticaret katalog ve keşif uygulaması.

## ✨ Özellikler

- **Dinamik Kategori & Ürün Yönetimi:** DummyJSON API entegrasyonu ile kategorilerin ve ürünlerin anlık olarak çekilmesi, slug bazlı filtreleme ve arama desteği.
- **Modern Arayüz Tasarımı:** Özel gradyanlar, şeffaf katman bileşenleri, esnek kaydırma (`CustomScrollView`, `SliverGrid`) ve Material 3 uyumlu tasarım.
- **Gelişmiş Navigasyon:** Sabit alt yüzeyli (`NavigationIsland`) ve `IndexedStack` destekli kalıcı sayfa durumu yönetimi.
- **Favoriler Sistemi:** `ValueNotifier` mimarisiyle anlık güncellenen favori ürünler yönetimi.
- **Zengin Keşif Alanı:** Otomatik kayan (auto-scroll) duyuru banner'ları ve akıllı kategori yönlendirmeleri.

## 🧰 Kullanılan Teknolojiler & Paketler

- **Framework:** Flutter (Material 3)
- **Dil:** Dart
- **HTTP & API:** `http` paketi (DummyJSON REST API)
- **Durum Yönetimi (State Management):** `StatefulWidget`, `ValueNotifier`

## 📦 Kullanılan Flutter Sürümü

Bu proje aşağıdaki sürümlerle geliştirilmiş ve test edilmiştir:

- **Flutter:** `3.x` (Stabil son sürüm önerilir)
- **Dart:** `3.x`

## 🚀 Çalıştırma Adımları

Projeyi yerel ortamınızda çalıştırmak için sırasıyla şu adımları takip edebilirsiniz:

1. Projeyi bilgisayarınıza klonlayın:

```bash
   git clone https://github.com/mertcakirm/Catalog-App.git
```

2. Proje dizinine gidin:

```bash
   cd Catalog-App
```

3. Gerekli bağımlılıkları yükleyin:

```bash
   flutter pub get
```

4. Uygulamayı başlatın:

```bash
   flutter run
```

## 📁 Proje Klasör Yapısı

Uygulamanın kaynak kodları ve varlıkları şu düzen içinde yapılandırılmıştır:

```text
lib/
 ┣ pages/       # Uygulama ekranları (ExplorePage, ProductsPage, LikedProductsPage)
 ┣ services/    # API servisleri ve veri yönetimi (CategoryService, ProductService, FavoritesService)
 ┣ utils/       # Yardımcı fonksiyonlar, sabitler ve ortak araçlar
 ┗ widgets/     # Yeniden kullanılabilir arayüz bileşenleri (NavigationIsland, CategoryChips, vb.)
assets/
 ┗ images/      # Proje görselleri ve logo dosyaları
```
