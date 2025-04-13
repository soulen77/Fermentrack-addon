from .settings import *

# Enable debugging in development
DEBUG = True

# Allow access from any host
ALLOWED_HOSTS = ['*']

# Database settings can optionally be customized here
 DATABASES = {
     'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
 }

# Static files directory (optional override)
 STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

# Constance config backend if using django-constance with database
CONSTANCE_BACKEND = 'constance.backends.database.DatabaseBackend'
