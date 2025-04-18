import os

FERMENTRACK_BASE = os.environ.get("FERMENTRACK_DATA_PATH", "/config/fermentrack")
FERMENTRACK_DEBUG = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(FERMENTRACK_BASE, 'db.sqlite3'),
    }
}

STATIC_ROOT = os.path.join(FERMENTRACK_BASE, "static")
MEDIA_ROOT = os.path.join(FERMENTRACK_BASE, "media")
