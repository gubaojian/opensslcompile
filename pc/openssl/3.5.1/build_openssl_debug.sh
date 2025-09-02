SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION=3.5.1
INSTALL_DIR=$HOME/cdeps/debug/openssl/3.5.1
echo "Script directory: $SCRIPT_DIR"
uname -a

rm -rf cdeps_debug_openssl_${VERSION}.zip

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
 ./Configure --prefix=$INSTALL_DIR --openssldir=$INSTALL_DIR --debug
 make -j12
 make install_sw
cd ..
rm -rf cdeps_debug_openssl_${VERSION}.zip
cd $HOME/cdeps/debug/openssl
zip -r cdeps_debug_openssl_${VERSION}.zip ${VERSION}
echo "openssl build and packaging completed."
mv cdeps_debug_openssl_${VERSION}.zip "$SCRIPT_DIR/cdeps_debug_openssl_${VERSION}.zip"
echo "Package moved to script directory: $SCRIPT_DIR/cdeps_debug_openssl_${VERSION}.zip"
echo "Build script completed successfully."
cd $SCRIPT_DIR
rm -rf $HOME/cdeps/src/openssl/${VERSION}/
mkdir -p $HOME/cdeps/src/openssl/${VERSION}/
mv openssl-${VERSION} $HOME/cdeps/src/openssl/${VERSION}/



