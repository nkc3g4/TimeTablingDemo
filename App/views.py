import hashlib
from datetime import datetime, time, timedelta

from django.core.mail import send_mail
from django.http.response import JsonResponse, HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.template.defaulttags import register

from App.models import *


class Event:
    def __init__(self, module_code, module_name, start_time, finish_time, week, taught_id, room):
        self.ModuleCode = module_code
        self.ModuleName = module_name
        self.Start = start_time
        self.Finish = finish_time
        self.Week = week
        self.TaughtID = taught_id
        self.Room = room


# Used to display event change in the table.
class EventChange:
    def __init__(self, id, start_date, end_date):
        self.id = id
        self.start_date = start_date
        self.end_dat = end_date


class ConflictArea:
    def __init__(self, day, start_time, finish_time):
        self.Day = day
        self.StartTime = start_time
        self.FinishTime = finish_time


class ChangeViewer:
    def __init__(self, cid, start_time, finish_time, ori_start_time_hour, ori_start_time_minute, ori_finish_time_hour,
                 ori_finish_time_minute, ori_day, room):
        self.cid = cid
        self.start_time = start_time
        self.finish_time = finish_time

        self.ori_start_time_hour = ori_start_time_hour
        self.ori_start_time_minute = ori_start_time_minute
        self.ori_finish_time_minute = ori_finish_time_minute
        self.ori_finish_time_hour = ori_finish_time_hour
        self.ori_day = ori_day
        self.room = room


class OptimisationViewer:
    def __init__(self, module_name, enrolled, capacity, percentage, taught_id, day, start_time, finish_time, timestr):
        self.module_name = module_name
        self.enrolled = enrolled
        self.capacity = capacity
        self.percentage = percentage
        self.taught_id = taught_id
        self.day = day
        self.start_time = start_time
        self.finish_time = finish_time
        self.timestr = timestr


class CourseViewer:
    def __init__(self, module_name, module_code, semester, coordinator, enrolled, crn):
        self.module_name = module_name
        self.module_code = module_code
        self.coordinator = coordinator
        self.enrolled = enrolled
        self.semester = semester
        self.crn = crn


class TaughtViewer:
    def __init__(self, type, day, weeks, start_time, finish_time, room):
        self.type = type
        self.weeks = weeks
        self.day = day
        self.starttime = start_time
        self.finishtime = finish_time
        self.room = room


def schedule(request):
    course_list = Course.objects.filter(coordinatorid=1)
    taught_list = list()
    for course in course_list:
        current_taught_list = Taught.objects.filter(crn=course.crn)
        for c in current_taught_list:
            for w in c.weeks.split(','):
                loc = Room.objects.filter(roomid=c.roomid).first().location

                # print(loc.location)
                taught_list.append(Event(course.module_code, course.module_name,
                                         IntTimeToCo(term_dates(int(course.semester), int(w), int(c.day)), c.starttime),
                                         IntTimeToCo(term_dates(int(course.semester), int(w), int(c.day)),
                                                     c.finishtime),
                                         w, c.id, loc))

    idx = 0
    events = list()

    for e in taught_list:
        event = {
            "id": e.ModuleCode + str(e.Week).zfill(2) + str(e.TaughtID).zfill(4) + str(idx),
            "start_date": e.Start,
            "end_date": e.Finish,
            "text": e.ModuleCode + " " + e.ModuleName + "<br/>" + e.Room,
            "details": "TEst"
        }
        idx = idx + 1
        events.append(event)
    # print(events)

    return JsonResponse(events, safe=False)


def IntTimeToCo(d, digtime):
    # d = date(2018, 1, 11)
    t = time(digtime // 100, digtime % 100)
    return datetime.combine(d, t).strftime('%Y-%m-%d %H:%M')


# Convert 4 digit time to time object
def datetime_to_digit_time(dt):
    return dt.hour * 100 + dt.minute


# Determine weather two time interval is overlapped
def is_time_overlap(start_1, end_1, start_2, end_2):
    if start_1 > start_2:
        start_1, start_2 = start_2, start_1
        end_1, end_2 = end_2, end_1
    return end_1 > start_2


# Convert the semester date to a calendar date
def term_dates(semester, week, day):
    '''2017-2018'''
    start_termdate = "2017-09-11"
    delta = timedelta(days=(week - 1) * 7 + day - 1)
    if semester == 2:
        start_termdate = "2018-01-22"
        delta = timedelta(days=(week - 20) * 7 + day - 1)
    start_termdate_object = datetime.strptime(start_termdate, "%Y-%m-%d")
    return start_termdate_object + delta


def datetime_to_week(dt):
    termdate1 = CalendarSettings.objects.filter(name='termdate1').first()
    termdate_object = datetime.strptime(termdate1, "%Y-%m-%d")
    interval = dt - termdate_object
    week = interval.days // 7 + 1
    if week > 20:
        week -= 20
    return week


# Find all the time slots that has conflict with the event
def confilct_zone(moduleCode, week, day):
    student_group = moduleCode[4]  # Students in the same group has the same lectures
    print(student_group)
    course_list = Course.objects.all()
    areas = list()
    for course in course_list:

        if course.module_code == moduleCode or course.module_code[4] != student_group:
            # ignore current module and students in the other group
            continue

        current_taught_list = Taught.objects.filter(crn=course.crn)

        for c in current_taught_list:
            # print(c.day + " " + day)
            if c.day == day:
                if week in c.weeks.split(','):
                    areas.append(ConflictArea(c.day, c.starttime, c.finishtime))
    return areas


# zones:[4*60,8*60,12*60,15*60]

def get_conflict_zones(request, *args, **kwargs):
    id = kwargs.get('id')
    day = kwargs.get('day')
    areas = confilct_zone(id[0:9], id[10:11], day)
    zones = list()
    for area in areas:
        zones.append(area.StartTime // 100 * 60)
        zones.append((area.FinishTime // 100 + 1) * 60)

    print(zones)
    return JsonResponse(zones, safe=False)


def changes(request):
    # ev = EventChange(request.POST['id'],request.POST['start_date'],request.POST['end_date'])

    ev = request.POST
    # print("changes")
    # try:
    #     if list(request.session['ev']):
    #         pass
    #  except KeyError:
    #      print("Session Not exist")
    #      request.session['ev'] = list()

    ch = Changes()
    ch.id = ev['id']
    ch.startTime = ev['start_date']
    ch.finishTime = ev['end_date']
    ch.save()
    # print(ev)
    return HttpResponse()


def submit_changes(request):
    print("SubmitChanges")
    result = True
    uid = 1
    if request.session['uid']:
        uid = request.session['uid']
    for c in Changes.objects.filter(uid__exact=uid, submitted__exact=0):
        c.submitted = 1
        c.save()

    return JsonResponse(result, safe=False)


def get_await_list():
    awaitList = Changes.objects.filter(submitted__exact=1, approved__exact=0)
    return awaitList


def get_taught(taught_id):
    return Taught.objects.filter(id__exact=int(taught_id)).first()


def new_taught(module_code):
    CRN = Course.objects.filter(module_code__exact=module_code).first().crn
    # ta=Taught()
    # ta.
    info = None
    return JsonResponse(info, safe=False)


def is_room_conflict(cur_room_id, cur_taught_day, start_time, finish_time):
    overlap = False
    for ta in Taught.objects.filter(roomid=cur_room_id, day=cur_taught_day):
        # Check Time Overlap
        if is_time_overlap(ta.starttime, ta.finishtime, start_time, finish_time):
            overlap = True
            break
    return overlap


def get_CRN(module_code):
    return Course.objects.filter(module_code__exact=module_code).first().crn


def get_room(room_id):
    return Room.objects.filter(roomid__exact=room_id).first().location


def num_to_day(num):
    days = ['', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri']
    return days[int(num)]


def view_changes(request):
    if request.method == 'POST':
        approve_changes(request.POST)
    await_list = list()
    for chg in get_await_list():
        taught_id = chg.id[12:15]
        if taught_id == 0:
            ta = Taught()
            ta.day = 1
            ta.starttime = datetime_to_digit_time(chg.startTime)
            ta.finishtime = datetime_to_digit_time(chg.finishTime)
            ta.roomid = 1
            ta.crn = get_CRN(chg.id[0:9])
            if ta.crn:
                ta.save()
                taught_id = ta.id
            else:
                continue

        cur_taught = get_taught(taught_id)
        if cur_taught is None:
            continue
        if is_room_conflict(cur_taught.roomid, cur_taught.day, datetime_to_digit_time(chg.startTime),
                            datetime_to_digit_time(chg.finishTime)):
            for room in Room.objects.all():
                if not is_room_conflict(room.roomid, cur_taught.day, datetime_to_digit_time(chg.startTime),
                                        datetime_to_digit_time(chg.finishTime)):
                    cur_taught.roomid = room.roomid
                    break
        start_time_view = num_to_day(chg.startTime.weekday()) + " " + str(chg.startTime.hour).zfill(2) + ":" + str(
            chg.startTime.minute).zfill(2)
        finish_time_view = str(chg.finishTime.hour).zfill(2) + ":" + str(
            chg.finishTime.minute).zfill(2)
        if chg.finishTime.year == 1970:
            finish_time_view = "DELETE"

        cv = ChangeViewer(chg.id, start_time_view, finish_time_view, cur_taught.starttime // 100,
                          str(cur_taught.starttime % 100).zfill(2), cur_taught.finishtime // 100,
                          str(cur_taught.finishtime % 100).zfill(2),
                          num_to_day(cur_taught.day), get_room(cur_taught.roomid))
        await_list.append(cv)

    context = {'awaitList': await_list}
    return render(request, 'main/admin.html', context)


def remove_event(taught_id, week):
    t = get_taught(taught_id)
    week_list = list(t.weeks.split(','))
    week_list.remove(str(week))
    week_str = ",".join(str(i) for i in week_list)
    t.weeks = week_str
    t.save()


def approve_changes(post):
    result = True
    reject_list = list()
    for p in post:
        # Ignore rejected changes
        if str(p).startswith('REJ'):
            reject_list.append(str(p).lstrip('REJ'))
    for chg in get_await_list():
        if chg.id in reject_list:
            continue
        taught = get_taught(chg.id[12:15])
        finish_time_new = datetime_to_digit_time(chg.finishTime)
        if finish_time_new == 0:  # DELETE
            # get week
            week = datetime_to_week(chg.startTime)
            # remove week
            remove_event(taught, week)

        taught.day = chg.startTime.weekday()
        taught.starttime = datetime_to_digit_time(chg.startTime)
        taught.finishtime = finish_time_new
        taught.save()
        print(taught.id)
        chg.approved = 1
        chg.save()
        # Send mail
        course = Course.objects.filter(crn=taught.crn).first()
        coordinator = User.objects.filter(id__exact=course.coordinatorid).first()
        email = coordinator.email
        send_notification(email)

    return JsonResponse(result, safe=False)


def OptimisationViewerSort(ov):
    return -ov.percentage


def int_to_readable_time(time):
    return str(time // 100).zfill(2) + ":" + str(
        time % 100).zfill(2)


def optimisation(request):
    # Taught Room Usage
    # Stu Number

    view_list = list()
    for t in Taught.objects.all():
        # stu number
        course = Course.objects.filter(crn=t.crn).first()

        enro = course.enrolled
        capa = Room.objects.filter(roomid__exact=t.roomid).first().capacity
        per = int(enro / capa * 100)  # Room usage percentage
        timestr = num_to_day(t.day) + " " + int_to_readable_time(t.starttime)  # Display time
        view_list.append(
            OptimisationViewer(course.module_name, enro, capa, per, t.id, t.day, t.starttime, t.finishtime, timestr))

    view_list.sort(key=OptimisationViewerSort)
    context = {'view_list': view_list}
    if request.method == 'POST':
        # do Optimization
        for t in view_list:
            if t.percentage > 80:
                room_changed = False
                # Find Empty Room
                for room in Room.objects.all():
                    if room.capacity > t.capacity:
                        if not is_room_conflict(room.roomid, t.day, t.start_time, t.finish_time):
                            # Change Room
                            cur_taught = get_taught(t.taught_id)
                            cur_taught.roomid = room.roomid
                            cur_taught.save()
                            room_changed = True
                            break
                if not room_changed:
                    # Find Taught With exactly same time slot
                    for tau in Taught.objects.all():
                        if tau.id != t.taught_id and tau.day == t.day and tau.starttime == t.start_time and tau.finishtime == t.finish_time:
                            cur_capacity = Room.objects.filter(roomid__exact=tau.roomid).first().capacity
                            cur_enrolled = Course.objects.filter(crn__exact=tau.crn).first().enrolled
                            if cur_capacity > t.capacity and cur_enrolled < t.enrolled:
                                tau1 = get_taught(tau.id)
                                tau2 = get_taught(t.taught_id)
                                tau1.roomid, tau2.roomid = tau2.roomid, tau1.roomid
                                tau1.save()
                                tau2.save()

    return render(request, 'main/optimisation.html', context)


def preferences(request):
    if request.method == 'POST':
        TimePreferences.objects.filter(uid__exact=1).delete()
        for nps in request.POST:
            if (str(nps) == "csrfmiddlewaretoken"):
                continue
            tp = TimePreferences()
            tp.uid = 1
            tp.time = int(nps)
            tp.save()

    not_preferred_list = dict()
    for tp in TimePreferences.objects.filter(uid__exact=1):
        not_preferred_list[tp.time] = 'checked="checked"'
    time_list = {9: '9 am', 10: '10 am', 11: '11 am', 12: '12 pm', 13: '1 pm', 14: '2 pm', 15: '3 pm', 16: '4 pm',
                 17: '5 pm'}
    week_list = [100, 200, 300, 400, 500]
    room_list = [i[0] for i in Room.objects.values_list('location')]
    context = {'time_list': time_list, 'value_list': not_preferred_list, 'week_list': week_list, 'room_list': room_list}
    return render(request, 'main/preferences.html', context)


@register.filter
def get_item_checkbox(dic_time, week):
    dictionary, t = dic_time
    # print(t + week)

    return dictionary.get(t + week, '')


@register.filter(name='one_more')
def one_more(_1, _2):
    return _1, _2


def management(request):
    course_list = list()
    for c in Course.objects.all():
        coordinator_name = User.objects.filter(id__exact=c.coordinatorid).first().name
        course_list.append(CourseViewer(c.module_name, c.module_code, c.semester, coordinator_name, c.enrolled, c.crn))

    context = {'course_list': course_list}
    return render(request, 'main/management.html', context)


def taught_manage(request, *args, **kwargs):
    crn = str(kwargs.get('crn'))
    module_name = Course.objects.filter(crn__exact=crn).first().module_name
    taught_list = list()
    for t in Taught.objects.filter(crn__exact=crn):
        room = Room.objects.filter(roomid__exact=t.roomid).first().location
        taught_list.append(TaughtViewer(t.type, t.day, t.weeks, t.starttime, t.finishtime, room))

    context = {'module_name': module_name, 'taught_list': taught_list}
    return render(request, 'main/taught.html', context)


def delete_changes(request):
    result = True
    body = request.POST
    print(body['id'])
    Changes.objects.filter(id__exact=body['id']).delete()

    return JsonResponse(result, safe=False)


def course_edit(request, *args, **kwargs):
    code = str(kwargs.get('code'))
    course = Course.objects.filter(module_code__exact=code).first()
    module_name = course.module_name
    semester = course.semester
    crn = course.crn
    enrolled = course.enrolled
    context = {'code': code, 'course': course, 'module_name': module_name, 'semester': semester, 'crn': crn}

    return render(request, 'main/courseedit.html', context)


#
def course_edit_submit(request):
    result = True
    if request.method == 'POST':
        if request.POST['code']:
            code = request.POST['code']
            course = Course.objects.filter(module_code__exact=code).first()
            course.enrolled = request.POST['enrolled']
            course.save()

    return HttpResponseRedirect('/management/')


def send_notification(email_addr):
    send_mail('Notification', 'Your reschedule request has been approved.', 'from@example.com',
              email_addr, fail_silently=False)


# Timetable Page
def index(request):
    context = {'awaitList': get_await_list()}
    if request.session.has_key('uid'):
        print('uid', request.session['uid'])
        return render(request, 'main/01_select.html', context)
    else:
        return HttpResponseRedirect('/login/')


# Login page
def login(request):
    status = ''
    result = True
    if request.method == 'POST':
        if request.POST['inputid']:
            uid = request.POST['inputid']
            if uid.isdigit():
                pwd = request.POST['password']
                if hashlib.md5(pwd.encode('utf-8')).hexdigest() == User.objects.filter(id__exact=uid).first().password:
                    request.session['uid'] = uid

                    return HttpResponseRedirect('/index')
        result = False
    if not result:
        status = 'ID or Password Error'
    context = {'status': status}
    return render(request, 'main/login.html', context)


def logout(request):
    request.session.clear()
    return HttpResponseRedirect('/login/')
