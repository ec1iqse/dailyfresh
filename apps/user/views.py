from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from django.shortcuts import redirect
from django.views.generic import View
from django.shortcuts import render
from django.urls import reverse
from .models import User
import re


# Create your views here.

# /user/register
def register(request):
    if request.method == 'GET':
        # 显示注册
        return render(request, template_name='register.html')
    else:
        # 进行注册处理

        # 接收数据数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email]):  # all()函数判断是否为可迭代类型，
            # 数据不完整
            return render(request, template_name='register.html', context={'errormsg': '数据不完整'})

        # 邮箱校验
        if not re.match('^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return render(request, template_name='register.html', context={'errormsg': '邮箱格式不正确'})

        # 校验是否同意条款
        if allow != 'on':
            return render(request, template_name='register.html', context={'errormsg': '请同意协议'})

        # 校验用户名是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, template_name='register.html', context={'errormsg': '用户名已存在'})

        # 进行业务处理:进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()

        # 返回应答,跳转到首页
        return redirect(reverse('goods:index'))

        # 显示注册页面
        return render(request, template_name='register.html')


def register_handle(request):
    """进行注册处理"""
    # 接收数据数据
    username = request.POST.get('user_name')
    password = request.POST.get('pwd')
    email = request.POST.get('email')
    allow = request.POST.get('allow')

    # 进行数据校验
    if not all([username, password, email]):  # all()函数判断是否为可迭代类型，
        # 数据不完整
        return render(request, template_name='register.html', context={'errormsg': '数据不完整'})

    # 邮箱校验
    if not re.match('^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
        return render(request, template_name='register.html', context={'errormsg': '邮箱格式不正确'})

    # 校验是否同意条款
    if allow != 'on':
        return render(request, template_name='register.html', context={'errormsg': '请同意协议'})

    # 校验用户名是否重复
    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        # 用户名不存在
        user = None

    if user:
        # 用户名已存在
        return render(request, template_name='register.html', context={'errormsg': '用户名已存在'})

    # 进行业务处理:进行用户注册
    user = User.objects.create_user(username, email, password)
    user.is_active = 0
    user.save()

    # 返回应答,跳转到首页
    return redirect(reverse('goods:index'))


# /user/register
class RegisterView(View):
    """注册"""

    def get(self, request):
        """显示注册页面"""
        return render(request, template_name='register.html')

    def post(self, request):
        """进行注册处理"""
        # 接收数据数据

        # 接收数据数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email]):  # all()函数判断是否为可迭代类型，
            # 数据不完整
            return render(request, template_name='register.html', context={'errormsg': '数据不完整'})

        # 邮箱校验
        if not re.match('^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return render(request, template_name='register.html', context={'errormsg': '邮箱格式不正确'})

        # 校验是否同意条款
        if allow != 'on':
            return render(request, template_name='register.html', context={'errormsg': '请同意协议'})

        # 校验用户名是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, template_name='register.html', context={'errormsg': '用户名已存在'})

        # 进行业务处理:进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()

        #  发送激活邮件，包含激活链接http://localhost:8000/user/active/<加密后的用户ID>

        # 激活连接中需要包含用户的身份信息，并且要把身份进行加密处理

        # ???????

        # 返回应答,跳转到首页
        return redirect(reverse('goods:index'))
