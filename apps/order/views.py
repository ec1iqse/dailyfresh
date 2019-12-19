from django.shortcuts import render
from django.views.generic import View
from django.shortcuts import render
from django.shortcuts import redirect
from django.urls import reverse
from goods.models import GoodsSKU
from user.models import Address
from django_redis import get_redis_connection
from utils.mixin import LoginRequiredMixin
from django.http import JsonResponse
from .models import OrderInfo
from .models import OrderGoods
from datetime import datetime
from django.db import transaction
import time


# Create your views here.
# order/place

class OrderPlaceView(LoginRequiredMixin, View):
    """提交订单页面显示"""

    def post(self, request):
        """提交订单页面显示"""
        # 获取登录的用户
        user = request.user

        # 获取参数sku_ids
        sku_ids = request.POST.getlist('sku_ids')  # [1,26]
        # 校验参数
        if not sku_ids:
            # 跳转到购物车页面
            return redirect(to=reverse('cart:show'))

        conn = get_redis_connection('default')
        skus = list()

        # 保存商品的总件数和总价格
        total_count = 0
        total_price = 0

        # 遍历sku_ids 获取用户要购买的商品的信息
        for sku_id in sku_ids:
            # 根据商品的id获取商品的信息
            sku = GoodsSKU.objects.get(id=sku_id)

            cart_key = 'cart_{}'.format(user.id)

            # 获取用户所要购买的商品的数量

            count = conn.hget(cart_key, sku_id)

            # 计算商品的小计
            amount = sku.price * int(count)

            # 动态给sku增加属性 count 保存购买商品的数量 sku.count=count
            sku.count = count

            # 动态给sku增加属性 amount 保存购买商品的总价格 sku.count=count
            sku.amount = amount

            # 追加
            skus.append(sku)

            # 累加计算商品的总件数和总价格
            total_count += int(count)
            total_price += amount

        # 运费：实际开发的时候，属于一个子系统
        transit_price = 10  # 写死的邮费

        # 实付款
        total_pay = total_price + transit_price

        # 获取用户的收件地址
        addrs = Address.objects.filter(user=user)

        # 组织上下文
        sku_ids = ','.join(sku_ids)  # 以逗号分隔，[1,25]=>1,25
        context = {
            'skus': skus,
            'total_count': total_count,
            'total_price': total_price,
            'transit_price': transit_price,
            'total_pay': total_pay,
            'addrs': addrs,
            'sku_ids': sku_ids,

        }
        # 使用模板
        return render(request, 'place_order.html', context=context)


# 前端传递的参数：地址id(addr_id),支付方式( pay_method ),用户要购买的商品的ID字符串(sku_ids)

class OrderCommitView(View):
    """订单创建"""

    def post(self, request):
        """订单创建"""
        # 判断用户是否登录
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({
                'res': 0,
                'err_msg': '用户未登录',
            })

        # 接收参数

        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_method')
        sku_ids = request.POST.get('sku_ids')

        # 参数校验
        if not all([addr_id, pay_method, sku_ids]):
            return JsonResponse({
                'res': 1,
                'err_msg': '参数不完整',
            })

        # 校验付款方式
        # 校验支付方式
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            return JsonResponse({
                'res': 2,
                'err_msg': '非法的支付方式',
            })

        # 校验地址
        try:
            addr = Address.objects.get(id=addr_id)
        except Address.DoesNotExist:
            # 地址不存在
            return JsonResponse({
                'res': 3,
                'err_msg': '地址非法',
            })

        # todo:创建订单的核心业务
        # 组织参数
        # 订单id:年月日时分秒+用户ID
        order_id = datetime.now().strftime('%Y%m%d%H%M%S') + str(user.id)

        # 运费
        transit_price = 10

        # 总数目和总金额

        total_count = 0
        total_price = 0

        #

        # todo:向df_order_info表中添加一条记录
        order = OrderInfo.objects.create(order_id=order_id,
                                         user=user,
                                         addr=addr,
                                         pay_method=pay_method,
                                         total_count=total_count,
                                         total_price=total_price,
                                         transit_price=transit_price, )

        # todo：用户订单有几个商品，需要向df_order_goods表中加入几条记录
        sku_ids = sku_ids.split(',')
        conn = get_redis_connection('default')
        cart_key = 'cart_{}'.format(user.id)
        for sku_id in sku_ids:
            # 获取商品的信息
            try:
                # todo： 上锁 有问题???
                # select * from df_goods_sku where id=sku_id for update
                with transaction.atomic():  # 加锁
                    sku = GoodsSKU.objects.select_for_update().get(id=sku_id)  # 上锁 悲观锁
            except Exception as ex:
                print(ex)
                return JsonResponse({
                    'res': 4,
                    'err_msg': '商品不存在',
                })

            print('{}{}'.format(user.id, sku.stock))
            time.sleep(10)

            # 从redis中获取用户所需要购买的商品的数量
            count = conn.hget(cart_key, sku_id)

            # 向df_order_goods表中添加一条记录
            OrderGoods.objects.create(order=order,
                                      sku=sku,
                                      count=count,
                                      price=sku.price)

            # todo:更新商品的库存和销量
            sku.stock -= int(count)
            sku.sales += int(count)
            sku.save()

            # todo:累加计算订单商品的总数量和总价格
            amount = sku.price * int(count)
            total_count += int(count)
            total_price += amount

        # todo:更新订单信息表中的商品总数量和总价格
        order.total_count = total_count
        order.total_price = total_price
        order.save()

        # todo:清除用户购物车中对应的记录[1,3]
        conn.hdel(cart_key, *sku_ids)  # 列表拆包

        # 返回应答
        return JsonResponse({
            'res': 5,
            'message': '创建成功',
        }
        )
