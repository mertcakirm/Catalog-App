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

## 📱 Ekran Görüntüleri

<table>
  <tr>
    <td align="center"><img src="https://github.com/user-attachments/assets/08b8891b-45d7-47db-91ec-606555dab942" width="240" alt="IMG_9461" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/f4ca9281-719f-49ec-b32b-f18e0e0c27d9" width="240" alt="IMG_9459" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/5944097d-4e00-4e9d-9a01-ac5ccd3e829f" width="240" alt="IMG_9458" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/fe483a41-0de8-463e-bf63-5f141d1812c6" width="240" alt="IMG_9457" /></td>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/user-attachments/assets/f3270a03-1053-4cf6-bf33-2142953c1470" width="240" alt="IMG_9456" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/b0b9616e-235c-4731-8420-cbc57e351b05" width="240" alt="IMG_9455" /></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/ffd7b94e-b01b-46fe-a945-f252ed9e5b5d" width="240" alt="IMG_9453" /></td>
  </tr>
</table>
