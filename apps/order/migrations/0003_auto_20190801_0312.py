# Generated by Django 2.2.2 on 2019-07-31 19:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('order', '0002_auto_20190526_0131'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ordergoods',
            name='comment',
            field=models.CharField(default='', max_length=256, verbose_name='评论'),
        ),
    ]