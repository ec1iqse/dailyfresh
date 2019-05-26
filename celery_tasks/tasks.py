# -*- coding: utf-8 -*-
import os
import time
import django
from celery import Celery
from django.conf import settings
from django.core.mail import send_mail

# 在任务处理者一端(celery)
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dailyfresh.settings')
# django.setup()

# 使用celery
# 创建一个Celery的实例对象
app = Celery('celery_tasks.tasks', broker='redis://root:root@localhost:6379/8')


# 定义任务函数
@app.task
def send_register_active_email(to_email, username, token):
    """发送激活邮件"""
    #  发送激活邮件，包含激活链接http://localhost:8000/user/active/<加密后的用户ID>
    # 组织邮件信息
    html_content = """
                       <h1>{}，欢迎您成为天天生鲜注册会员</h1>，
                       请点击以下链接激活您的账户<br/>
                       <a href="http://localhost:8000/user/active/{}">
                       http://localhost:8000/user/active/{} 
                       </a>
                      """.format(username, token, token)
    send_mail(subject='天天生鲜欢迎信息', message='', from_email=settings.EMAIL_FROM, recipient_list=[to_email],
              html_message=html_content, )
    # 激活连接中需要包含用户的身份信息，并且要把身份进行加密处理
