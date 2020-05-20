# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Course(models.Model):
    crn = models.AutoField(db_column='CRN', primary_key=True)  # Field name made lowercase.
    offering = models.CharField(db_column='Offering', max_length=45, blank=True,
                                null=True)  # Field name made lowercase.
    semester = models.CharField(db_column='Semester', max_length=45, blank=True,
                                null=True)  # Field name made lowercase.
    module_name = models.CharField(db_column='Module Name', max_length=45, blank=True,
                                   null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    module_code = models.CharField(db_column='Module Code', max_length=45, blank=True,
                                   null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    coordinatorid = models.IntegerField(db_column='CoordinatorID', blank=True, null=True)  # Field name made lowercase.
    enrolled = models.IntegerField(db_column='Enrolled', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'course'


class Room(models.Model):
    roomid = models.AutoField(db_column='RoomID', primary_key=True)  # Field name made lowercase.
    location = models.CharField(db_column='Location', max_length=45, blank=True,
                                null=True)  # Field name made lowercase.
    capacity = models.IntegerField(db_column='Capacity', blank=True, null=False)  # Field name made lowercase.
    projector = models.IntegerField(db_column='Projector', blank=True, null=False)  # Field name made lowercase.
    whiteboard = models.IntegerField(db_column='WhiteBoard', blank=True, null=False)  # Field name made lowercase.
    powersockets = models.IntegerField(db_column='PowerSockets', blank=True, null=False)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'room'


class Taught(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    type = models.CharField(db_column='Type', max_length=45, blank=True, null=True)  # Field name made lowercase.
    day = models.CharField(db_column='Day', max_length=45, blank=True, null=True)  # Field name made lowercase.
    weeks = models.CharField(db_column='Weeks', max_length=45, blank=True, null=True)  # Field name made lowercase.
    starttime = models.IntegerField(db_column='StartTime', blank=True, null=True)  # Field name made lowercase.
    finishtime = models.IntegerField(db_column='FinishTime', blank=True, null=True)  # Field name made lowercase.
    roomid = models.CharField(db_column='RoomID', max_length=45, blank=True, null=True)  # Field name made lowercase.
    crn = models.CharField(db_column='CRN', max_length=45, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'taught'


class User(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=45, blank=True, null=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=45, blank=True, null=True)  # Field name made lowercase.
    type = models.IntegerField(db_column='Type', blank=True, null=True)  # Field name made lowercase.
    password = models.CharField(db_column='Password', max_length=90, blank=True,
                                null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'user'


class Changes(models.Model):
    id = models.CharField(db_column='ID', max_length=45, primary_key=True)  # Field name made lowercase.
    startTime = models.DateTimeField(db_column='StartTime')
    finishTime = models.DateTimeField(db_column='FinishTime')
    uid = models.IntegerField(db_column='uid', default=1)
    submitted = models.IntegerField(db_column='submitted', default=0)
    approved = models.IntegerField(db_column='approved', default=0)

    class Meta:
        managed = False
        db_table = 'changes'


class TimePreferences(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    uid = models.IntegerField(db_column='uid', default=1)
    time = models.IntegerField(db_column='Time', default=1)

    class Meta:
        managed = False
        db_table = 'time_preferences'


class RoomPreferences(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    uid = models.IntegerField(db_column='uid', default=1)
    type = models.IntegerField(db_column='type', default=1)
    room = models.IntegerField(db_column='room', default=1)

    class Meta:
        managed = False
        db_table = 'room_preferences'


class CalendarSettings(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='name', max_length=45, blank=True, null=False)
    value = models.CharField(db_column='value', max_length=90, blank=True, null=True)
