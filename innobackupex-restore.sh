#!/bin/bash
innobackupex --apply-log --redo-only /data/Xtrabackup/full/ 1>/data/fuifu.log 2>&1
innobackupex --apply-log --redo-only /data/Xtrabackup/full/ --incremental-dir=/data/Xtrabackup/in2/  1>/data/huifu.log 2>&1
innobackupex --apply-log --redo-only /data/Xtrabackup/full/ --incremental-dir=/data/Xtrabackup/in3/ 1>/data/huifu.log 2>&1
innobackupex --apply-log --redo-only /data/Xtrabackup/full/ --incremental-dir=/data/Xtrabackup/in4/ 1>/data/huifu.log 2>&1
innobackupex --apply-log --redo-only /data/Xtrabackup/full/ --incremental-dir=/data/Xtrabackup/in5/ 1>/data/huifu.log 2>&1
innobackupex --apply-log --redo-only /data/Xtrabackup/full/ --incremental-dir=/data/Xtrabackup/in6/ 1>/data/huifu.log 2>&1
innobackupex --apply-log --redo-only /data/Xtrabackup/full/ --incremental-dir=/data/Xtrabackup/in7/ 1>/data/huifu.log 2>&1
innobackupex --apply-log /data/Xtrabackup/full/ 1> /data/fuifu.log 2>&1
innobackupex --defaults-file=/etc/my.cnf --user=root --copy-back /data/Xtrabackup/full/
