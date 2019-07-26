# -*- coding: utf-8 -*-
from django.core.files.storage import Storage
from fdfs_client.client import *
from django.conf import settings
from django.utils.deconstruct import deconstructible


@deconstructible
class FDFSStorage(Storage):
    """fastdfs文件存储类"""

    def __init__(self, client_conf=None, base_url=None):
        """初始化
        :param client_conf:
        :param base_url:
        """
        if client_conf is None:
            client_conf = settings.FDFS_CLIENT_CONF
        self.client_conf = client_conf

        if base_url is None:
            base_url = settings.FDFS_URL
        self.base_url = base_url

        print(settings.FDFS_CLIENT_CONF)
        print(settings.FDFS_URL)

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
        conf = get_tracker_conf(self.client_conf)
        # conf = get_tracker_conf('client.conf')

        # 创建一个Fdfs_client对象
        # client = Fdfs_client(conf)
        # client = Fdfs_client(conf)

        client = Fdfs_client(conf)

        # client = Fdfs_client(self.client_conf)

        # 上传文件到FastDFS
        # ret = client.upload_by_filename(filename='corn.jpg')

        res = client.upload_by_buffer(content.read())

        if res.get('Status') != 'Upload successed.':
            """上传失败"""
            raise Exception('上传文件到FastDFS失败')

        """获取返回的文件ID"""
        filename = res.get('Remote file_id')
        # print('文件名称' + filename)
        print(type(filename))
        return filename.decode()
        # return filename

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
        """判断django文件是否可用,FastDFS自动区分重复文件
        :param name:
        :return:
        """
        return False

    def url(self, name):
        """返回访问文件的URL路径
        :param name:
        :return:
        """
        return self.base_url + name
