# KitApp - Dijital Kitap Platformu

![KitApp Logo](assets/images/logo.png)

## 📖 Proje Hakkında

KitApp, kullanıcılara dijital kitap okuma ve keşfetme deneyimi sunan modern bir mobil uygulamadır. Firebase altyapısı ile geliştirilmiş olup, kullanıcılara kişiselleştirilmiş kitap önerileri, kategori bazlı kitap keşfi ve kesintisiz bir okuma deneyimi sunmaktadır.

## ✨ Özellikler

-   **Kullanıcı Hesap Yönetimi**: Firebase Authentication ile güvenli oturum açma ve kayıt olma
-   **Kitap Keşfetme**: Kategorilere göre kitapları filtreleme ve keşfetme
-   **PDF Okuyucu**: Dahili PDF okuyucu ile sorunsuz okuma deneyimi
-   **Okuma Geçmişi**: Kullanıcının okuma ilerlemesini takip etme ve kaldığı yerden devam etme
-   **Favoriler**: Sevilen kitapları favori listesine ekleme
-   **Öneriler**: Yapay zeka destekli kitap önerileri
-   **Yönetici Paneli**: Kitap ve yazar ekleyip düzenleyebilme

## 🚀 Kurulum

1. Bu repoyu klonlayın:

    ```
    git clone https://github.com/kullaniciadi/kitapp.git
    ```

2. Bağımlılıkları yükleyin:

    ```
    flutter pub get
    ```

3. Firebase projenizi kurun ve `firebase_options.dart` dosyasını güncelleyin.

4. `.env` dosyasını oluşturun (Google AI API için gerekli):

    ```
    GEMINI_API_KEY=sizin_api_anahtarınız
    ```

5. Uygulamayı çalıştırın:
    ```
    flutter run
    ```

## 🛠️ Kullanılan Teknolojiler

-   **Flutter & Dart**: Cross-platform uygulama geliştirme
-   **Firebase**: Kimlik doğrulama, Firestore veritabanı ve depolama
-   **Provider**: Durum yönetimi
-   **Google Generative AI**: Kitap önerme sisteminde
-   **GetStorage**: Yerel veri depolama
-   **PDF Viewer**: PDF dosyalarını görüntüleme ve işleme

## 📱 Ekran Görüntüleri

[Buraya ekran görüntüleri eklenecek]

## 📋 Proje Yapısı

```
lib/
├── components/         # Yeniden kullanılabilir UI bileşenleri
├── models/             # Veri modelleri (Book, Author)
├── pages/              # Uygulama sayfaları
│   ├── admin_pages/    # Yönetici işlevleri
│   ├── auth_pages/     # Kimlik doğrulama sayfaları
│   ├── home/           # Ana sayfa ve alt sayfaları
│   ├── onboarding_pages/ # Karşılama ekranları
│   └── recommender_pages/ # Kitap önerme sayfaları
├── providers/          # Durum yönetimi
├── services/           # Firebase ve diğer servisler
├── utils/              # Yardımcı fonksiyonlar
└── main.dart           # Uygulama girişi
```

## 👥 Katkıda Bulunma

1. Bu repoyu forklayın
2. Yeni bir özellik dalı oluşturun (`git checkout -b yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik: Özet'`)
4. Dalınıza push yapın (`git push origin yeni-ozellik`)
5. Bir Pull Request oluşturun

## 📄 Lisans

Bu proje [MIT lisansı](LICENSE) altında lisanslanmıştır.

## 📞 İletişim

Sorularınız veya önerileriniz için [e-posta adresiniz] adresine e-posta gönderebilirsiniz.
