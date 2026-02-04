# Inception - Hızlı Kurulum Rehberi

Bu rehber, temiz bir Ubuntu Sanal Makinesine (VM) Inception projesini kurmak için gerekli adımları içerir.

### 1. Sistem Güncelleme ve Docker Kurulumu (Resmi Depo Yöntemi)

Ubuntu'nun kendi deposundaki Docker bazen eski olabiliyor veya `docker compose` komutunda sorun çıkarabiliyor. Bu yüzden Docker'ın resmi deposunu ekleyip en güncel ve kararlı sürümü kuruyoruz.

Aşağıdaki bloktaki komutları sırasıyla çalıştır:

```bash
# 1.1. Gerekli ön paketleri ve araçları yükle
sudo apt-get update
sudo apt-get install -y make git curl vim ca-certificates

# 1.2. Docker'ın resmi GPG anahtarını ekle
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 1.3. Docker deposunu kaynak listesine ekle
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 1.4. Paket listesini güncelle ve Docker + Plugin'i kur
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

```

### 2. Docker Yetki Ayarı

Her Docker komutunda `sudo` yazmamak için kullanıcını gruba ekle.

```bash
sudo usermod -aG docker $USER

```

### 3. Domain Ayarı (/etc/hosts)

Projeye tarayıcıdan erişebilmek için domain yönlendirmesini yap.

```bash
sudo nano /etc/hosts

```

* Açılan dosyanın **en altına** şu satırı ekle (Kendi kullanıcı adını yaz):
`127.0.0.1   bkiskac.42.fr`
* *(Kaydetmek için: `Ctrl + O`, `Enter`, `Ctrl + X`)*

### 4. Sistemi Yeniden Başlat (Zorunlu)

Grup yetkilerinin ve kurulumun aktif olması için makineyi yeniden başlat.

```bash
sudo reboot

```

---

### Kurulum Sonrası Projeyi Başlatma

VM açıldıktan sonra proje klasörüne girip şu komutla her şeyi başlatabilirsin:

```bash
make

```

* **Test:** Tarayıcıdan `https://bkiskac.42.fr` adresine git.
* **Temizlik:** Her şeyi silip baştan kurmak istersen `make fclean` ardından `make` yapman yeterli.
