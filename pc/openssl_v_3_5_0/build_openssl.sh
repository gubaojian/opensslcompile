SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"
uname -a

rm -rf cdeps_openssl_3_5_0.zip

openssl_download_file="openssl-3.5.0.tar.gz"
echo "Checking for openssl download file: $openssl_download_file"
file_path="$SCRIPT_DIR/$openssl_download_file"
if [ -f "$file_path" ]; then
  echo "$file_path openssl already exists, skipping download."
else
  echo "$file_path 不存在 try download openssl "
  rm -rf openssl-3.5.0.tar.gz
  curl -O https://github.com/openssl/openssl/releases/download/openssl-3.5.0/openssl-3.5.0.tar.gz
fi
rm -rf openssl-3.5.0
echo "Extracting OpenSSL source code..."
tar -zxvf openssl-3.5.0.tar.gz
cd openssl-3.5.0
rm -rf $HOME/cdeps/openssl
mkdir -p $HOME/cdeps/openssl
 ./Configure --prefix=$HOME/cdeps/openssl --openssldir=$HOME/cdeps/openssl  --release
 make -j12
 make install_sw
 
cd ..
rm -rf cdeps_openssl_3_5_0.zip
cd $HOME/cdeps/
zip -r cdeps_openssl_3_5_0.zip openssl
echo "openssl build and packaging completed."
mv cdeps_openssl_3_5_0.zip "$SCRIPT_DIR/cdeps_openssl_3_5_0.zip"
echo "Package moved to script directory: $SCRIPT_DIR/cdeps_openssl_3_5_0.zip"
echo "Build script completed successfully."
