# Generated by Django 4.0.2 on 2022-04-13 13:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0025_rent'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='rent',
            name='document_upload',
        ),
    ]