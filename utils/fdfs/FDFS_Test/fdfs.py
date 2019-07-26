from fdfs_client.client import *

conf = get_tracker_conf('client.conf')

client = Fdfs_client(conf)

ret = client.upload_by_filename(filename='corn.jpg')

if ret['Status'] == 'Upload successed.':
    print('上传成功！')
    print('成功信息')
    print(ret)
else:
    print('上传失败')
