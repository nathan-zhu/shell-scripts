#!/bin/bash
### Begining time and Format_time ###
BEGINTIME=`date +"%Y-%m-%d %H:%M:%S"`
format_time=`date +"%Y-%m-%d_%H:%M:%S"`

### Week number ###
week=`date +%w
`
###Backup folder ###
backdir=/data/xtrabackup
file_cnf=/etc/my.cnf

###Database username and password ###
user_name=root 
password=2VPNy6xnPzAL

###Backup log files ###
out_log=$backdir/xtrabackup_log_$format_time 
time_cost=$backdir/xtrabackup_time.txt

###Move existing backup fiels for whole week and prepage new around backup ###
if [ -d "$backdir/incr6" ];then 
    mv $backdir $backdir-$format_time
    mkdir $backdir
else
    mkdir -p  $backdir
fi

###### Start backup now, Monday full backup other days is incremental backup ###### 

if [ ! -d "$backdir/full" ];then
    echo "#####start monday full backup at  $BEGINTIME to directory full" >>$time_cost
    innobackupex --defaults-file=$file_cnf --no-timestamp --user=$user_name --password=$password  $backdir/full 1> $out_log 2>&1
    exit 1
fi
if [ ! -d "$backdir/incr1" ];then 
    echo "#####start incremental 1 backup at $BEGINTIME to directory incr1" >>$time_cost
    innobackupex --defaults-file=$file_cnf --no-timestamp --user=$user_name --password=$password --incremental-basedir=$backdir/full --no-timestamp  --incremental $backdir/incr1 1> $out_log 2>&1
    exit 1
fi
if [ ! -d "$backdir/incr2" ];then
    echo "#####start incremental 2 backup at $BEGINTIME to directory incr2" >>$time_cost
    innobackupex-1.5.1 --defaults-file=$file_cnf --no-timestamp --user=$user_name --password=$password --incremental --incremental-basedir=$backdir/incr1 $backdir/incr2 1> $out_log 2>&1
    exit 1
fi
if [ ! -d "$backdir/incr3" ];then
    echo "#####start incremental 3 backup at $BEGINTIME to directory incr3" >>$time_cost
    innobackupex-1.5.1 --defaults-file=$file_cnf --no-timestamp --user=$user_name --password=$password --incremental --incremental-basedir=$backdir/incr2 $backdir/incr3 1> $out_log 2>&1
    exit 1
fi
if [ ! -d "$backdir/incr4" ];then
    echo "#####start incremental 4 backup at $BEGINTIME to directory incr4" >>$time_cost
    innobackupex-1.5.1 --defaults-file=$file_cnf --no-timestamp --user=$user_name --password=$password --incremental --incremental-basedir=$backdir/incr3 $backdir/incr4 1> $out_log 2>&1
    exit 1
fi
if [ ! -d "$backdir/incr5" ];then
    echo "#####start incremental 5 backup at $BEGINTIME to directory incr5" >>$time_cost
    innobackupex-1.5.1 --defaults-file=$file_cnf --no-timestamp --user=$user_name --password=$password --incremental --incremental-basedir=$backdir/incr4 $backdir/incr5 1> $out_log 2>&1
    exit 1
fi
if [ ! -d "$backdir/incr6" ];then
    echo "#####start incremental 6 backup at $BEGINTIME to directory incr6" >>$time_cost
    innobackupex-1.5.1 --defaults-file=$file_cnf --no-timestamp --user=$user_name --password=$password --incremental --incremental-basedir=$backdir/incr5 $backdir/incr6 1> $out_log 2>&1
    exit 1
fi
### END weekly backup ###
