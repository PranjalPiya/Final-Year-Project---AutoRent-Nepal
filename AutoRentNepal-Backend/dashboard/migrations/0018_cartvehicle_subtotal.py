# Generated by Django 4.0.2 on 2022-03-07 11:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0017_cartvehicle'),
    ]

    operations = [
        migrations.AddField(
            model_name='cartvehicle',
            name='subtotal',
            field=models.PositiveIntegerField(default=0),
        ),
    ]
