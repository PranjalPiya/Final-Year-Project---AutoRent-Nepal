# Generated by Django 4.0.2 on 2022-04-13 17:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0028_rent_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='rent',
            name='document_upload',
            field=models.ImageField(blank=True, upload_to='documents/'),
        ),
    ]
