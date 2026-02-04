### 1. Sistem Güncelleme ve Paket Kurulumu

*(Docker Compose V2 plugin dahil edildi)*

```bash
sudo apt update
sudo apt install -y make git curl vim docker.io docker-compose-plugin

```

### 2. Docker Yetki Ayarı

```bash
sudo usermod -aG docker $USER

```
### 3. Domain Ayarı

Bunu manuel açıp eklemen gerekecek:

```bash
sudo nano /etc/hosts

```

* Dosyanın en altına şunu ekle ve kaydet (Ctrl+O, Enter, Ctrl+X):
`127.0.0.1   bkiskac.42.fr`

### 4. Son İşlem

Ayarların (özellikle Docker yetkisinin) aktif olması için VM'i yeniden başlat:

```bash
sudo reboot

```
