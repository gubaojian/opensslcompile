SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"
uname -a

rm -rf cdeps_debug_openssl_3_5_2.zip

openssl_download_file="openssl-3.5.2.tar.gz"
echo "Checking for openssl download file: $openssl_download_file"
file_path="$SCRIPT_DIR/$openssl_download_file"
if [ -f "$file_path" ]; then
  echo "$file_path openssl already exists, skipping download."
else
  echo "$file_path 不存在 try download openssl "
  rm -rf openssl-3.5.2.tar.gz
  curl -O https://github.com/openssl/openssl/releases/download/openssl-3.5.2/openssl-3.5.2.tar.gz
fi
## rm -rf openssl-3.5.2
echo "Extracting OpenSSL source code..."
## tar -zxvf openssl-3.5.2.tar.gz
cd openssl-3.5.2
rm -rf $HOME/cdeps_debug/openssl
mkdir -p $HOME/cdeps_debug/openssl
 ./Configure --prefix=$HOME/cdeps_debug/openssl --openssldir=$HOME/cdeps_debug/openssl --debug -g -O0 -Wall -Wextra -Iinclude -fPIC
 make -j12
 make install_sw
cd ..
rm -rf cdeps_debug_openssl_3_5_2.zip
cd $HOME/cdeps_debug/
zip -r cdeps_debug_openssl_3_5_2.zip openssl
echo "openssl build and packaging completed."
mv cdeps_debug_openssl_3_5_2.zip "$SCRIPT_DIR/cdeps_debug_openssl_3_5_2.zip"
echo "Package moved to script directory: $SCRIPT_DIR/cdeps_debug_openssl_3_5_2.zip"
echo "Build script completed successfully."
cd $SCRIPT_DIR
rm -rf $HOME/cdeps_source/openssl-3.5.2
mkdir -p $HOME/cdeps_source/openssl-3.5.2
mv openssl-3.5.2 $HOME/cdeps_source/



