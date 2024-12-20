# Generated by Django 5.1.3 on 2024-11-07 15:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('library', '0006_alter_book_pub_date_alter_lending_lending_date_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='book',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to='books'),
        ),
        migrations.AlterField(
            model_name='book',
            name='pub_date',
            field=models.DateField(blank=True, null=True, verbose_name='date published'),
        ),
    ]
