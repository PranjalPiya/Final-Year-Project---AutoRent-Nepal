# Generated by Django 4.0.2 on 2022-03-07 10:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0016_rent_user_alter_rent_vehicle'),
    ]

    operations = [
        migrations.CreateModel(
            name='CartVehicle',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('price', models.PositiveIntegerField()),
                ('quntity', models.PositiveIntegerField()),
                ('cart', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='dashboard.addtocart')),
                ('vehicle', models.ManyToManyField(to='dashboard.Vehicle')),
            ],
        ),
    ]
