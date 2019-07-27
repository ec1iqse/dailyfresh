# -*- coding: utf-8 -*-


import os
import sys
import time
import django
from celery import Celery
from django.conf import settings
from django.template import loader
from django.shortcuts import render
from django.core.mail import send_mail
from django.template import RequestContext  # 自定义模型类必须写在django下方
from django_redis import get_redis_connection  # 自定义模型类必须写在django下方

# 在任务处理者一端(celery)
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dailyfresh.settings')
# django.setup()


os.environ.setdefault('FORKED_BY_MULTIPROCESSING', '1')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dailyfresh.settings')
django.setup()  # django初始化

from goods.models import IndexPromotionBanner  # 自定义模型类必须写在django下方
from goods.models import IndexTypeGoodsBanner  # 自定义模型类必须写在django下方
from goods.models import GoodsType  # 自定义模型类必须写在django下方
from goods.models import IndexGoodsBanner  # 自定义模型类必须写在django下方

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


@app.task
def generate_static_index_html():
    """产生首页静态页面"""
    # 获取商品种类信息
    types = GoodsType.objects.all()

    # 获取首页轮播商品信息
    goods_banners = IndexGoodsBanner.objects.all().order_by('index')  # 0 1 2 默认是升序

    # 获取首页促销活动信息
    promotion_banners = IndexPromotionBanner.objects.all().order_by('index')

    # 获取首页分类展示信息
    for type in types:  # GoodsType

        # 获取type种类首页分类商品的图片展示信息
        image_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1).order_by('index')
        # 获取type种类首页分类商品的文字展示信息
        title_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0).order_by('index')

        # 动态给type增加属性，分别保存首页分类商品的图片展示信息和文字展示信息
        type.image_banners = image_banners
        type.title_banners = title_banners

    # 组织模板上下文
    context = {
        'types': types,
        'goods_banners': goods_banners,
        'promotion_banners': promotion_banners,

    }

    # 使用模板

    # 1.加载模板文件,返回模板对象
    temp = loader.get_template(template_name='static_index.html')

    # 2.模板渲染
    static_index_html = temp.render(context)

    # 3.生成首页对应静态文件
    save_path = os.path.join(settings.BASE_DIR, 'static/index.html')
    with open(save_path, 'w', encoding='UTF-8')as f:
        f.write(static_index_html)
    return
