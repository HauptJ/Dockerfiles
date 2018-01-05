#!/bin/bash

function exportBoolean {
    if [ "${!1}" = "**Boolean**" ]; then
            export ${1}=''
    else 
            export ${1}='Yes.'
    fi
}

exportBoolean LOG_STDOUT
exportBoolean LOG_STDERR

if [ $LOG_STDERR ]; then
    /bin/ln -sf /dev/stderr /var/log/apache2/error.log
else
	LOG_STDERR='No.'
fi

if [ $ALLOW_OVERRIDE == 'All' ]; then
    /bin/sed -i 's/AllowOverride\ None/AllowOverride\ All/g' /etc/apache2/apache2.conf
fi

if [ $LOG_LEVEL != 'warn' ]; then
    /bin/sed -i "s/LogLevel\ warn/LogLevel\ ${LOG_LEVEL}/g" /etc/apache2/apache2.conf
fi

# enable php short tags:
echo "enabling php short tags"
/bin/sed -i "s/short_open_tag\ \=\ Off/short_open_tag\ \=\ On/g" /etc/php/7.0/apache2/php.ini

# set max_execution_time to 7200
echo "setting max_execution_time to 7200"
/bin/sed -e 's/max_execution_time = 30/max_execution_time = 7200/' -i /etc/php/7.0/apache2/php.ini

# set post_max_size to 100M
echo "setting post_max_size to 100M"
/bin/sed -e 's/post_max_size = 8M/post_max_size = 100M/' -i /etc/php/7.0/apache2/php.ini

# set upload_max_filesize to 100M
echo "setting upload_max_filesize to 100M"
/bin/sed -e 's/upload_max_filesize = 2M/upload_max_filesize = 100M/' -i /etc/php/7.0/apache2/php.ini

# set memory_limit to 512M
echo "setting memory_limit to 512M"
/bin/sed -e 's/memory_limit = 128M/memory_limit = 512M/' -i /etc/php/7.0/apache2/php.ini

# stdout server info:
if [ ! $LOG_STDOUT ]; then
cat << EOB
    
    **********************************************
    *                                            *
    *    Docker image: fauria/lamp               *
    *    https://github.com/fauria/docker-lamp   *
    *                                            *
    **********************************************

    SERVER SETTINGS
    ---------------
    · Redirect Apache access_log to STDOUT [LOG_STDOUT]: No.
    · Redirect Apache error_log to STDERR [LOG_STDERR]: $LOG_STDERR
    · Log Level [LOG_LEVEL]: $LOG_LEVEL
    · Allow override [ALLOW_OVERRIDE]: $ALLOW_OVERRIDE
    · PHP date timezone [DATE_TIMEZONE]: $DATE_TIMEZONE

EOB
else
    /bin/ln -sf /dev/stdout /var/log/apache2/access.log
fi

# Set PHP timezone
/bin/sed -i "s/\;date\.timezone\ \=/date\.timezone\ \=\ ${DATE_TIMEZONE}/" /etc/php/7.0/apache2/php.ini

# Run Postfix
/usr/sbin/postfix start

# Run MariaDB
/usr/bin/mysqld_safe --timezone=${DATE_TIMEZONE}&

# Run Apache:
if [ $LOG_LEVEL == 'debug' ]; then
    /usr/sbin/apachectl -DFOREGROUND -k start -e debug
else
    &>/dev/null /usr/sbin/apachectl -DFOREGROUND -k start
fi