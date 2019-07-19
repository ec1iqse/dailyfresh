from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from celery_tasks.tasks import send_register_active_email
from django_redis import get_redis_connection
from django.contrib.auth import authenticate
from utils.mixin import LoginRequiredMixin
from itsdangerous import SignatureExpired
from django.core.mail import send_mail
from django.contrib.auth import logout
from django.contrib.auth import login
from django.views.generic import View
from django.shortcuts import redirect
from django.http import HttpResponse
from django.shortcuts import render
from goods.models import GoodsSKU
from django.conf import settings
from django.urls import reverse
from redis import StrictRedis
from .models import Address
from .models import User
from .models import User
import re




# Create your views here.


'''
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

'''


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

        # 加密用户身份信息，生成激活的Token
        serializer = Serializer(settings.SECRET_KEY, 3600)
        info = {'confirm': user.id}
        token = serializer.dumps(info)
        token = token.decode('UTF-8')

        # 发送邮件(celery异步)
        send_register_active_email.delay(email, username, token)  # celery异步
        '''
        #  发送激活邮件，包含激活链接http://localhost:8000/user/active/<加密后的用户ID>

        content = """
                    <h1>{}，欢迎您成为天天生鲜注册会员</h1>，
                    请点击以下链接激活您的账户<br/>
                    <a href="http://localhost:8000/user/active/{}">
                    http://localhost:8000/user/active/{} 
                    </a>
                   """.format(username, token, token)

        html_content = """
                           <h1>{}，欢迎您成为天天生鲜注册会员</h1>，
                           请点击以下链接激活您的账户<br/>
                           <a href="http://localhost:8000/user/active/{}">
                           http://localhost:8000/user/active/{} 
                           </a>
                          """.format(username, token, token)

        send_mail(subject='天天生鲜欢迎信息', message='', from_email=settings.EMAIL_FROM, recipient_list=[email],
                  html_message=html_content, )
        # 激活连接中需要包含用户的身份信息，并且要把身份进行加密处理
        '''

        # 返回应答,跳转到首页
        return redirect(reverse('goods:index'))


class ActiveView(View):
    """用户激活"""

    def get(self, request, token):
        """进行用户激活"""
        # 进行解密,获取要激活的用户信息
        serializer = Serializer(settings.SECRET_KEY, 3600)
        try:
            info = serializer.loads(token)
            # 获取待激活用户的ID
            user_id = info['confirm']
            # 根据ID获取用户信息
            user = User.objects.get(id=user_id)
            user.is_active = 1
            user.save()

            # 返回应答，跳转到登陆页面
            return redirect(reverse('user:login'))
        except SignatureExpired as e:
            # 激活链接已过期
            return HttpResponse('激活链接已过期')


#  /user/login
class LoginView(View):
    def get(self, request):
        """显示登陆页面"""
        # 判断是否记住了用户名
        if 'username' in request.COOKIES:
            username = request.COOKIES.get('username')
            checked = 'checked'
        else:
            username = ''
            checked = ''
        # 使用模板
        return render(request, template_name='login.html', content_type={'username': username, 'checked': checked})

    def post(self, request):
        """登录校验"""
        # 接受数据
        username = request.POST.get('username')
        password = request.POST.get('pwd')
        # 校验数据
        if not all([username, password]):
            return render(request, content_type={'errormsg': '数据不完整'})
        else:
            # 业务处理：登录校验
            user = authenticate(username=username, password=password)
            if user is not None:
                # 用户名密码正确
                if user.is_active:
                    # 用户已激活
                    login(request, user)

                    # 获取登录后跳转到的地址,
                    # 默认跳转到首页
                    next_url = request.GET.get('next', reverse('goods:index'))
                    # 跳转到next_url
                    responce = redirect(to=next_url)

                    # responce = redirect(reverse('goods:index'))  # HttpResponceRedirect的子类

                    # 判断是否需要记住用户名
                    # remember = request.POST.get('remember')
                    if request.POST.get('remember') == 'on':
                        # 记住用户名
                        responce.set_cookie('username', username, max_age=7 * 24 * 3600)
                    else:
                        responce.delete_cookie('username')

                    return responce
                else:
                    # 用户未激活
                    return render(request, template_name='login.html', content_type={'errormsg': '账号未激活，请先激活您的账户'})
            else:
                # 用户名或密码错误
                return render(request, template_name='login.html', content_type={'errormsg': '用户名或密码错误'})


# /user/logout
class LogoutView(View):
    """退出登录"""

    def get(self, request):
        """退出登录"""
        # 清除用户的session信息
        logout(request)
        # 跳转到首页
        return redirect(reverse(viewname='goods:index'))


# /user
class UserInfoView(LoginRequiredMixin, View):
    """用户中心-信息页"""

    def get(self, request):
        """显示"""
        # page='user'
        # request.user.is_authenticated()
        # 除了给模板文件传递的模板变量之外，django框架会把request.user也传给模板文件
        # 如果用户未登录， user是一个AnonymousUser的一个实例，
        # 如果用户登录，则是User类的一个实例，

        # 获取用户的个人信息
        user = request.user
        address = Address.objects.get_default_address(user)

        # 获取用户的历史浏览记录
        # sr=StrictRedis(host='localhost',port=6379,db=9)
        con = get_redis_connection('default')

        # 取出用户的历史浏览记录
        history_key = 'history_{}'.format(user.id)

        # 获取用户最新浏览的五个商品id
        sku_ids = con.lrange(name=history_key, start=0, end=4)

        # 从数据库中查询用户浏览的商品具体信息
        # goods_li=GoodsSKU.objects.filter(id__in=sku_ids)

        # 遍历获取用户浏览的历史商品记录
        goods_li = list()

        for id in sku_ids:
            goods = GoodsSKU.objects.get(id=id)
            goods_li.append(goods)

        # 组织上下文
        context = {'page': 'user',
                   'address': address,
                   'goods_li': goods_li,
                   }

        return render(request,
                      template_name='user_center_info.html',
                      context=context
                      )


# /user/order
class UserOrderView(LoginRequiredMixin, View):
    """用户中心-订单页"""

    def get(self, request):
        """显示"""
        # page='order'

        # 获取用户的订单信息

        return render(request,
                      template_name='user_center_order.html',
                      context={'page': 'order'})


# /user/address
class AddressView(LoginRequiredMixin, View):
    """用户中心-订单页"""

    def get(self, request):
        """用户中心-地址页"""
        # page='address'
        user = request.user  # 获取登录用户对应的用户对象

        # 获取用户的默认收货地址
        address = Address.objects.get_default_address(user)

        '''
        try:
            address = Address.objects.get(user=user, is_default=True)  # models.Manager

        except Address.DoesNotExist:
            # 不存在默认收货地址
            address = None
            
        '''

        # 使用模板
        return render(request,
                      template_name='user_center_site.html',
                      context={'page': 'address', 'address': address})

    def post(self, request):
        """地址的添加"""
        receiver = request.POST.get('receiver')
        addr = request.POST.get('addr')
        zip_code = request.POST.get('zip_code')
        phone = request.POST.get('phone')
        # 接收数据
        if not all([receiver, addr, phone]):  # zip_code 邮政编码可以为空
            return render(request, template_name='user_center_site.html',
                          context={'errormsg': '数据不完整'})

            # 校验手机号
        if not re.match(r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$', phone):
            # if not re.match(r'^1[3|4|5|7|8][0-9]{9}$', phone):
            return render(request, template_name='user_center_site.html',
                          context={'errormsg': '手机格式不正确'})
        user = request.user  # 获取登录用户对应的用户对象

        address = Address.objects.get_default_address(user)

        '''
        try:
            address = Address.objects.get(user=user, is_default=True)

        except Address.DoesNotExist:
            # 不存在默认收货地址
            address = None

        '''

        if address:
            is_default = False
        else:
            is_default = True

        # 添加地址
        Address.objects.create(user=user,
                               addr=addr,
                               receiver=receiver,
                               zip_code=zip_code,
                               phone=phone,
                               is_default=is_default)
        # 刷新页面地址
        return redirect(reverse(viewname='user:address'))  # get请求方式

        # 如果用户用户已存在默认收货地址，添加的地址将不作为默认收货地址，否则作为默认收货地址
        # 校验数据
        # 业务处理:地址添加
        # 返回应答
