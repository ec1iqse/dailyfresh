from django.contrib import admin
from django.core.cache import cache
from .models import GoodsType
from goods.models import IndexPromotionBanner
from goods.models import IndexGoodsBanner
from goods.models import IndexTypeGoodsBanner


class BaseModelAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        """新增或更新表中的数据时调用"""
        # print(request)
        # print(obj)
        # print(form)
        # print(change)
        # print('-------')
        super().save_model(request, obj, form, change)
        # 发出任务，让celery worker重新生成首页静态页面
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()

        # 清除首页的缓存数据
        cache.delete('index_page_data')

    def delete_model(self, request, obj):
        """删除表中的数据时调用"""
        super().delete_model(request, obj)
        # 发出任务，让celery worker重新生成首页静态页面
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()


# Register your models here.
class GoodsTypeAdmin(BaseModelAdmin):
    pass


class IndexGoodsBannerAdmin(BaseModelAdmin):
    pass


class IndexTypeGoodsBannerAdmin(BaseModelAdmin):
    pass


class IndexPromotionBannerAdmin(BaseModelAdmin):
    pass


admin.site.register(GoodsType, GoodsTypeAdmin)
admin.site.register(IndexGoodsBanner, IndexTypeGoodsBannerAdmin)
admin.site.register(IndexTypeGoodsBanner, IndexTypeGoodsBannerAdmin)
admin.site.register(IndexPromotionBanner, IndexPromotionBannerAdmin)
