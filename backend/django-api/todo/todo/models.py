from django.db import models
from django.utils.translation import gettext_lazy as _

# Create your models here.
class Todo(models.Model):
    

    # TODO: Define fields here
    title = models.CharField(_("title"), max_length=50)
    description = models.TextField(_("description" ))
    is_done = models.BooleanField(_("is_done"),)
    created_at  = models.DateTimeField(_("created_at"), auto_now=False, auto_now_add=False)
    class Meta:

        verbose_name = 'Todo'
        verbose_name_plural = 'Todos'

    def __str__(self):
        return self.title
     
