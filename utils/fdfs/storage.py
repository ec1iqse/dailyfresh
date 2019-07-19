# -*- coding: utf-8 -*-
from django.core.files.storage import Storage
from fdfs_client.client import *


class FDFSStorage(Storage):
    """fastdfs文件存储类"""

    def _open(self, name, mode='rb'):
        '''打开文件时使用'''
        pass

    def _save(self, name, content):
        """保存文件时使用
        :param name:你选择上传的文件
        :param content:包含你上传文件内容的File对象
        """
        # 读取client.conf配置文件
        # conf = get_tracker_conf('client.conf')
        conf = get_tracker_conf('./utils/fdfs/client.conf')

        # 创建一个Fdfs_client对象
        client = Fdfs_client(conf)

        # 上传文件到FastDFS
        # ret = client.upload_by_filename(filename='corn.jpg')

        res = client.upload_by_buffer(content.read())
        if res.get('Status') != 'Upload successed.':
            """上传失败"""
            raise Exception('上传文件到FastDFS失败')
        else:
            """获取返回的文件ID"""
            filename = res.get('Remote file_id')
            return filename

    # 返回格式：
    # {
    #     'Group name': group_name,
    #     'Remote file_id': remote_file_id,
    #     'Status': 'Upload successed.',
    #     'Local file name': '',
    #     'Uploaded size': upload_size,
    #     'Storage IP': storage_ip
    # }

    def exists(self, name):
        """判断django文件是否可用"""
        return False
