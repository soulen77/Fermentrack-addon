import os

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv('DJANGO_SECRET_KEY', 'supersecret')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = ['*']

# Base directory for persistence
FERMENTRACK_DATA_PATH = os.getenv('FERMENTRACK_DATA_PATH', '/data')

# Database location (SQLite for simplicity)
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(FERMENTRACK_DATA_PATH, 'db.sqlite3'),
    }
}

# Static and media file locations
STATIC_ROOT = os.path.join(FERMENTRACK_DATA_PATH, 'static')
MEDIA_ROOT = os.path.join(FERMENTRACK_DATA_PATH, 'media')

# Celery settings (adjust as needed or keep as defaults)
BROKER_URL = 'redis://localhost:6379/0'
CELERY_RESULT_BACKEND = 'redis://localhost:6379/0'

# Constance (django-constance) settings
CONSTANCE_BACKEND = 'constance.backends.database.DatabaseBackend'

# Optional: Use for debugging/logging purposes
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
        },
    },
    'root': {
        'handlers': ['console'],
        'level': 'INFO',
    },
}
