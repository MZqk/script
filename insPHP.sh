#!/bin/bash
#zip install

if [ -d php-5.4.25/ext/zip ];then
	cd php-5.4.25/ext/zip
else
	tar zxvf php-5.4.25.tar.gz
	cd php-5.4.25/ext/zip
fi
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make
[ $? != 0 ] && exit
make install
echo 
grep 'no-debug-zts-20100525' /usr/local/php/etc/php.ini
if [ $? != 0 ];then
        echo '' >> /usr/local/php/etc/php.ini
        echo 'extension_dir=/usr/local/php/lib/php/extensions/no-debug-zts-20100525' >> /usr/local/php/etc/php.ini
fi
grep 'zip.so' /usr/local/php/etc/php.ini
if [ $? != 0 ];then
	echo 'extension=zip.so' >> /usr/local/php/etc/php.ini
fi
echo "zip install is OK"


/usr/local/apache2/bin/apachectl restart
cd -
rm -rf php-5.4.25
echo "all ok!"
ls /usr/local/php/lib/php/extensions/no-debug-zts-20100525/
