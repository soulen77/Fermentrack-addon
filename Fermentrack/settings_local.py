import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FERMENTRACK_BASE = "/data/fermentrack"

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(FERMENTRACK_BASE, 'db.sqlite3'),
    }
}

STATIC_ROOT = os.path.join(FERMENTRACK_BASE, 'static')
MEDIA_ROOT = os.path.join(FERMENTRACK_BASE, 'media')

DEBUG = False
ALLOWED_HOSTS = ['*']
