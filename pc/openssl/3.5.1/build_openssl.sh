SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION=3.5.1
INSTALL_DIR=$HOME/cdeps/release/openssl/${VERSION}
echo "Script directory: $SCRIPT_DIR"
echo "INSTALL directory: $INSTALL_DIR"
uname -a

rm -rf cdeps_openssl_${VERSION}.zip

openssl_download_file="openssl-${VERSION}.tar.gz"
echo "Checking for openssl download file: $openssl_download_file"
file_path="$SCRIPT_DIR/$openssl_download_file"
if [ -f "$file_path" ]; then
  echo "$file_path openssl already exists, skipping download."
else
  echo "$file_path 不存在 try download openssl "
  rm -rf openssl-${VERSION}.tar.gz
  url=https://github.com/openssl/openssl/releases/download/openssl-${VERSION}/openssl-${VERSION}.tar.gz
  echo "${url}"
  curl -OL ${url}
fi
rm -rf openssl-${VERSION}
echo "Extracting OpenSSL source code..."
tar -zxvf openssl-${VERSION}.tar.gz
cd openssl-${VERSION}
rm -rf $INSTALL_DIR
mkdir -p $INSTALL_DIR
 ./Configure --prefix=$INSTALL_DIR --openssldir=$INSTALL_DIR  --release
 make -j12
 make install_sw
 
cd ..
rm -rf cdeps_openssl_${VERSION}.zip
cd $HOME/cdeps/release/openssl/
rm -rf cdeps_openssl_${VERSION}.zip
zip -r cdeps_openssl_${VERSION}.zip ${VERSION}
echo "openssl build and packaging completed."
mv cdeps_openssl_${VERSION}.zip "$SCRIPT_DIR/cdeps_openssl_${VERSION}.zip"
echo "Package moved to script directory: $SCRIPT_DIR/cdeps_openssl_${VERSION}.zip"
echo "Build script completed successfully."


