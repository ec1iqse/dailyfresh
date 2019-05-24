from django.shortcuts import render


# Create your views here.

# /user/register
def register(request):
    """显示注册页面"""
    return render(request, template_name='register.html')


def register_handle(request):
    """进行注册处理"""
    # 接受数据
    username = request.POST.get('user_name')
    password = request.POST.get('pwd')
    email = request.POST.get('email')
    # 进行数据校验
    if not all([username, password, email]):
        # 数据不完整
        return render(request, template_name='register.html', context={'errormsg': '数据不完整'})
    # 进行业务处理:进行用户注册
    # 返回应答
    pass
