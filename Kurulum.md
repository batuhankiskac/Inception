Harika. Temiz bir Ubuntu VM, üzerine inşaat yapabileceğimiz boş bir arsa gibidir. Şimdi temelleri atalım.

Bu aşamada **3 temel hedefimiz** var:

1. Gerekli araçları (Docker, Make, Git) yüklemek.
2. Yetki ayarlarını yapmak (Her seferinde `sudo` yazmamak için).
3. Proje klasör yapısını ve Domain ayarlarını hazırlamak.

VM'inde terminali aç ve sırasıyla şu adımları uygula. Her komutun ne işe yaradığını açıklıyorum.

### Adım 1: Paketlerin Yüklenmesi

Önce paket listemizi güncelleyelim ve ihtiyacımız olan araçları kuralım.

```bash
sudo apt update
sudo apt install -y make git curl vim docker.io docker-compose

```

* 
**make:** Projeyi tek komutla (`make`) yönetmek için şart.


* **docker.io:** Docker motorunun (Engine) kendisi.
* **docker-compose:** YAML dosyalarını okuyup konteynerleri orkestre eden araç. (Not: Yeni Docker sürümlerinde `docker compose` komutu dahili gelir ama garanti olsun diye paketi de kuruyoruz).

### Adım 2: Docker Yetki Ayarı (Önemli)

Normalde Docker, sistem kök dizinine eriştiği için sadece `root` (veya sudo) ile çalışır. Sürekli şifre girmek istemiyorsan, kendi kullanıcını `docker` grubuna eklemelisin.

```bash
sudo usermod -aG docker $USER

```

* **Açıklama:** `$USER` senin o anki kullanıcı adını otomatik alır. `-aG` (append group) ile seni docker yetkilileri arasına ekler.

⚠️ **Kritik Nokta:** Bu ayarın aktif olması için oturumu kapatıp açman gerekir. Şimdilik devam edelim, en son VM'i yeniden başlatacağız.

### Adım 3: Domain Ayarı (/etc/hosts)

Subject dosyasında projenin `login.42.fr` adresinde çalışması isteniyor . Ancak internette böyle bir adres gerçekten varsa bile, biz **kendi makinemize** yönlenmesini istiyoruz.

Bunun için DNS'i kandıracağız:

1. Hosts dosyasını aç:
```bash
sudo nano /etc/hosts

```


2. Dosyanın en altına şu satırı ekle (Buradaki `login` yerine kendi 42 kullanıcı adını yazmalısın, örneğin `yusuf.42.fr`):
```text
127.0.0.1   login.42.fr

```


3. `Ctrl+O`, `Enter` (Kaydet) ve `Ctrl+X` (Çık) ile dosyayı kapat.

* **Mantık:** Tarayıcıya `login.42.fr` yazdığında bilgisayarın önce bu dosyaya bakar. "Ha, bu adres 127.0.0.1 yani benim kendimmişim" der ve internete çıkmadan senin NGINX konteynerine gelir.

### Adım 4: Klasör Yapısı (İskelet)

Şimdi projenin fiziksel yapısını kuralım. Subject çok spesifik bir yapı istiyor.

Önce proje klasörünü oluştur (Ev dizininde `inception` adında bir klasör açalım):

```bash
mkdir -p ~/inception
cd ~/inception

```

Şimdi gerekli alt klasörleri oluşturalım:

```bash
# Ana yapı
mkdir -p srcs
mkdir -p secrets

# Servisler için alt klasörler (Her biri için Dockerfile buraya gelecek)
mkdir -p srcs/requirements/nginx
mkdir -p srcs/requirements/mariadb
mkdir -p srcs/requirements/wordpress
mkdir -p srcs/requirements/bonus

# Konfigürasyon ve araçlar için klasörler
mkdir -p srcs/requirements/nginx/conf
mkdir -p srcs/requirements/mariadb/conf
mkdir -p srcs/requirements/wordpress/conf
mkdir -p srcs/requirements/nginx/tools
mkdir -p srcs/requirements/mariadb/tools
mkdir -p srcs/requirements/wordpress/tools

# Boş dosyaları oluştur (Şimdilik içi boş dursun)
touch Makefile
touch srcs/docker-compose.yml
touch srcs/.env

```

### Adım 5: Veri Klasörleri (Data Volumes)

Subject'in en hassas noktası: Verilerin host makinede `/home/login/data` altında tutulması zorunluluğu.

Bunu şimdi manuel olarak oluşturalım (Yine `login` yerine kendi kullanıcı adını yaz):

```bash
# Database ve Web dosyaları için
sudo mkdir -p /home/login/data/mariadb
sudo mkdir -p /home/login/data/wordpress

# Klasörlerin boş olduğunu kontrol et
ls -R /home/login/data

```

---

### Kontrol Listesi

Şu an şunları yapmış olmalısın:

1. [ ] Paketler kuruldu.
2. [ ] Kullanıcı gruba eklendi.
3. [ ] `/etc/hosts` dosyasında `127.0.0.1 login.42.fr` var.
4. [ ] `~/inception/srcs/...` klasör ağacı hazır.
5. [ ] `/home/login/data/...` klasörleri hazır.

**Son Adım:** VM'i yeniden başlat (`sudo reboot`).
Yeniden açıldığında terminale `docker ps` yaz. Eğer "Permission denied" hatası **almıyorsan** ve boş bir tablo görüyorsan her şey hazır demektir.

Durumu onayla, sonra hemen **NGINX** servisini yazmaya başlayalım.