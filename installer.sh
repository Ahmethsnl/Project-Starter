#!/bin/bash

SCRIPT_NAME="projectstarter.sh"
REPO_NAME="ProjectStarter"
HOME_DIR="$HOME"
TARGET_PATH="$HOME_DIR/.projectstarter/$SCRIPT_NAME"
TARGET_DIR="$HOME_DIR/.projectstarter"

# 1. Dosya var mı kontrol et
if [ ! -f "$SCRIPT_NAME" ]; then
    echo "❌ Hata: $SCRIPT_NAME bu dizinde bulunamadı!"
    exit 1
fi

# 2. Hedef klasör oluşturulup dosya oraya taşınır
mkdir -p "$TARGET_DIR"
mv -f "$SCRIPT_NAME" "$TARGET_PATH"
echo "✅ Dosya $TARGET_PATH konumuna taşındı."

# 3. Alias komutu
ALIAS_CMD="alias wstart='bash $TARGET_PATH'"

# 4. Shell RC dosyaları
BASHRC="$HOME_DIR/.bashrc"
ZSHRC="$HOME_DIR/.zshrc"

# 5. bashrc güncelle
if [ -f "$BASHRC" ]; then
    grep -v "^alias wstart=" "$BASHRC" 2>/dev/null > "$BASHRC.tmp" && mv "$BASHRC.tmp" "$BASHRC"
    echo "$ALIAS_CMD" >> "$BASHRC"
    echo "✅ Alias 'wstart' .bashrc dosyasına eklendi."
fi

# 6. zshrc güncelle
if [ -f "$ZSHRC" ]; then
    grep -v "^alias wstart=" "$ZSHRC" 2>/dev/null > "$ZSHRC.tmp" && mv "$ZSHRC.tmp" "$ZSHRC"
    echo "$ALIAS_CMD" >> "$ZSHRC"
    echo "✅ Alias 'wstart' .zshrc dosyasına eklendi."
fi

# 7. Bulunduğun dizinden bir üst dizine çık
CURRENT_DIR="$(pwd)"
cd .. || exit

# 8. Repo klasörünü sil
if [ -d "$REPO_NAME" ]; then
    rm -rf "$REPO_NAME"
    echo "🧹 $REPO_NAME klasörü silindi."
else
    echo "ℹ️ $REPO_NAME klasörü zaten yoktu veya silinemedi."
fi

# 9. Bilgilendirme
echo -e "\n✅ Kurulum tamamlandı! Yeni terminal aç veya aşağıdakini çalıştır:"
echo -e "\n🔁 \033[1msource ~/.bashrc\033[0m   veya   \033[1msource ~/.zshrc\033[0m\n"
echo -e "\033[1;32m GitHub   ➜\033[0m  \033[4;36m ahmethsnl \033[0m"
echo -e "\033[1;32m 42 Slack ➜\033[0m  \033[4;36m ahmsanli \033[0m"
