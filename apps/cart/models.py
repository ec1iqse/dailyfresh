from db.base_model import BaseModel
from django.db import models


# Create your models here.
class CartInfo(BaseModel):

    class Meta:
        verbose_name = '购物车商品信息'
        verbose_name_plural = verbose_name
