# -*- coding: utf-8 -*-
import os
import sys

BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
# FDFS_CLIENT_CONF = os.path.join(LAST_BASE_DIR, 'utils/fdfs/client.conf')


FDFS_CLIENT_CONF = os.path.join(BASE_DIR, './utils/fdfs/client.conf')

# print(BASE_DIR)

print(FDFS_CLIENT_CONF)

# print(os.path.abspath('Demo.py'))
