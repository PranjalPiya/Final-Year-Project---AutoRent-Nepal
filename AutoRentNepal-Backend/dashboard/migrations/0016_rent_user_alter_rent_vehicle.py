# Generated by Django 4.0.2 on 2022-03-04 05:59

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('dashboard', '0015_alter_brand_date_alter_vehicle_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='rent',
            name='user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='rent',
            name='vehicle',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='dashboard.vehicle'),
        ),
    ]
