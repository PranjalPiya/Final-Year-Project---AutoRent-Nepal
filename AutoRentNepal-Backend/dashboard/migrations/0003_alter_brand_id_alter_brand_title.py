# Generated by Django 4.0.2 on 2022-02-12 08:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0002_rename_selling_price_vehicle_rental_price_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='brand',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
        migrations.AlterField(
            model_name='brand',
            name='title',
            field=models.CharField(max_length=100),
        ),
    ]