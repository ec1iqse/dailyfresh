from django.shortcuts import render
from django.views.generic import View
from django.http import JsonResponse
from goods.models import GoodsSKU
from django_redis import get_redis_connection
from utils.mixin import LoginRequiredMixin


# Create your views here.


# /cart/add
class CartAddView(View):
    """购物车记录添加"""

    # 添加到购物车：
    # 1:请求方式：采用ajax post
    # 如果涉及到数据的修改（新增、更新、修改），采用post
    # 如果只涉及到数据的获取，采用get
    # 2:传递参数：商品ID(sku_id)数量(count)
    # ajax发起的请求都在后台，在浏览器上看不到效果
    def post(self, request):
        """购物车记录的添加"""
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})

        # 接收数据
        sku_id = request.POST.get('sku_id')
        count = request.POST.get('count')
        # 数据校验
        if not all([sku_id, count]):
            return JsonResponse({'res': 1, 'errmsg': '数据不完整'})
        # 校验添加的商品数量
        try:
            count = int(count)
        except Exception as e:
            return JsonResponse({'res': 2, 'errmsg': '商品数目出错'})

        # 校验商品是否存在
        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except GoodsSKU.DoesNotExist:
            # 商品不存在
            return JsonResponse({'res': 3, 'errmsg': '商品不存在'})

        # 业务处理：添加购物车记录
        # 先尝试获取sku_id的值:hget cart_key 属性
        conn = get_redis_connection('default')
        cart_key = 'cart_{}'.format(user.id)
        cart_count = conn.hget(cart_key, sku_id)  # 如果sku_id在hash中不存在，hget返回的是None
        if cart_count:
            # 累加购物车中商品的数目
            count += int(cart_count)

        # 校验商品中的库存
        if count > sku.stock:
            return JsonResponse({'res': 4, 'errmsg': '商品库存不足'})

        # 设置hash中sku_id对应的值
        conn.hset(cart_key, sku_id, count)  # 如果存在，就增加.如果不存在，就添加

        # 计算用户购物车中商品的条目数
        total_count = conn.hlen(cart_key)
        # 返回应答
        return JsonResponse({'res': 5, 'total_count': total_count, 'message': '添加成功'})


# /cart/
class CartInfoView(LoginRequiredMixin, View):
    """购物车页面显示"""

    def get(self, request):
        """显示"""
        # 获取登录的用户
        user = request.user

        # 获取用户购物车中商品的信息
        conn = get_redis_connection('default')
        cart_key = 'cart_{}'.format(user.id)

        # 获取{'商品ID':商品数目}
        cart_dict = conn.hgetall(cart_key)

        skus = list()

        # 保存用户购物车中商品的总数目和总价格
        total_count = 0
        total_price = 0

        for sku_id, count in cart_dict.items():  # items() 函数以列表返回可遍历的(键, 值) 元组数组。

            # 根据商品的ID获取商品的信息
            sku = GoodsSKU.objects.get(id=sku_id)

            # 计算商品的小计
            amount = sku.price * int(count)  # 数量遍历出来的是字符串，需要转换成int形式

            # 动态给sku对象增加属性amount,保存商品的小计
            sku.amount = amount

            # 动态给sku对象增加属性count,保存购物车中对应商品的数量
            sku.count = int(count)

            # 添加
            skus.append(sku)

            # 累加计算商品的总数目和总价格
            total_count += int(count)
            total_price += amount

        # 遍历获取商品的信息
        # 组织上下文
        context = {
            'total_count': total_count,
            'total_price': total_price,
            'skus': skus,
        }
        # 使用模板
        return render(request, template_name='cart.html', context=context)


# 更新购物车记录
# 采用ajax POST请求
# 前端需要传递的参数包括商品id(sku_id)，更新的商品数量(count)
#/cart/update
class CartUpdateView(View):
    """购物车记录更新"""

    def post(self, request):
        """购物车记录更新"""
        # 接受数据
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})
        # 接收数据
        sku_id = request.POST.get('sku_id')
        count = request.POST.get('count')
        # 数据校验
        if not all([sku_id, count]):
            return JsonResponse({'res': 1, 'errmsg': '数据不完整'})
        # 校验添加的商品数量
        try:
            count = int(count)
        except Exception as e:
            return JsonResponse({'res': 2, 'errmsg': '商品数目出错'})

        # 校验商品是否存在
        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except GoodsSKU.DoesNotExist:
            # 商品不存在
            return JsonResponse({'res': 3, 'errmsg': '商品不存在'})

        # 业务处理：更新购物车记录
        conn = get_redis_connection('default')
        cart_key = 'cart_{}'.format(user.id)

        # 校验商品的库存
        if count > sku.stock:
            return JsonResponse({'res': 4, 'errmsg': '商品库存不足'})

        # 更新
        conn.hset(cart_key, sku_id, count)

        # 返回应答
        return JsonResponse({'res': 5, 'message': '更新成功'})
