"""dailyfresh URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include
from django.urls import re_path
from django.urls import path

# 注意！ include()第一个参数是一个元组！！！是('应用名称.urls','应用名称')
# 即为：include(('应用名称.urls','应用名称')，namespace='XXXXXXX')

urlpatterns = [
    path('admin/', admin.site.urls),
    re_path(r'^tinymce/', include(('tinymce.urls', 'tinymce'), namespace='tinymce')),  # 富文本编辑器
    re_path(r'^user/', include(('user.urls', 'user'), namespace='user')),  # 用户模块
    re_path(r'cart/', include(('cart.urls', 'cart'), namespace='cart')),  # 购物车模块
    re_path(r'order/', include(('order.urls', 'order'), namespace='order')),  # 订单模块
    path('', include(('goods.urls', 'goods'), namespace='goods')),  # 商品模块(要放在最后！防止被抢先匹配)

    # re_path(r'^tinymce/', include('tinymce.urls',namespace='tinymce')),  # 富文本编辑器

]
