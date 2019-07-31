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
from django.urls import include
from django.urls import re_path
from django.urls import path
from .views import IndexView
from .views import DetailView

# app_name = 'goods'

urlpatterns = [
    path('index', IndexView.as_view(), name='index'),  # 首页
    re_path(r'^goods/(?P<goods_id>\d+)$', DetailView.as_view(), name='detail')  # 详情页
]
