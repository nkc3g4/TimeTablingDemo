"""TablingDemo URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.urls import path

from App import views

urlpatterns = [
    path('admin/', admin.site.urls),
    url('login/', views.login, name='login'),
    url('logout/', views.logout, name='logout'),
    url('index/', views.index, name='index'),
    url('schedule/', views.schedule, name='schedule'),
    url(r'^conflictzone/(?P<id>.*)/(?P<day>.*)/', views.get_conflict_zones, name='conflictzone'),
    url('submitchanges/', views.submit_changes, name='submitchanges'),
    url('deletechanges/', views.delete_changes, name='deletechanges'),
    url('approvechanges/', views.approve_changes, name='approvechanges'),
    url('preferences/', views.preferences, name='preferences'),
    url('viewchanges/', views.view_changes, name='viewchanges'),
    url('optimisation/', views.optimisation, name='optimisation'),
    url('management/', views.management, name='management'),
    url('taught/(?P<crn>.*)', views.taught_manage, name='taught'),
    url('course/(?P<code>.*)', views.course_edit, name='course'),
    url('courseedit/', views.course_edit_submit, name='courseedit'),
    url('changes/', views.changes, name='changes'),
    url(r'^$', views.index)

]
