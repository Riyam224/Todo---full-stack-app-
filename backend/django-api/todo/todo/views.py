from django.shortcuts import render
from rest_framework import viewsets , filters
from django_filters.rest_framework import DjangoFilterBackend
from .models import Todo
from .serializers import TodoSerializer

class TodoViewSet(viewsets.ModelViewSet):
    queryset = Todo.objects.all().order_by('-created_at')
    serializer_class = TodoSerializer

    filter_backends = [
        DjangoFilterBackend,
        filters.SearchFilter,
        filters.OrderingFilter,
    ]

    filterset_fields = ['is_done']                  # ✅ correct (matches model field)
    search_fields    = ['title', 'description']     # ✅ correct
    ordering_fields  = ['created_at', 'title']      # ✅ correct


