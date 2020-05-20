/*

@license
dhtmlxScheduler v.5.2.5 Stardard

To use dhtmlxScheduler in non-GPL projects (and get Pro version of the product), please obtain Commercial/Enterprise or Ultimate license on our site https://dhtmlx.com/docs/products/dhtmlxScheduler/#licensing or contact us at sales@dhtmlx.com

(c) XB Software Ltd.

*/
Scheduler.plugin(function (scheduler) {
    scheduler.locale = {
        date: {
            month_full: ["ינואר", "פברואר", "מרץ", "אפריל", "מאי", "יוני", "יולי", "אוגוסט", "ספטמבר", "אוקטובר", "נובמבר", "דצמבר"],
            month_short: ["ינו", "פבר", "מרץ", "אפר", "מאי", "יונ", "יול", "אוג", "ספט", "אוק", "נוב", "דצמ"],
            day_full: ["ראשון", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת"],
            day_short: ["א", "ב", "ג", "ד", "ה", "ו", "ש"]
        },
        labels: {
            dhx_cal_today_button: "היום",
            day_tab: "יום",
            week_tab: "שבוע",
            month_tab: "חודש",
            new_event: "ארוע חדש",
            icon_save: "שמור",
            icon_cancel: "בטל",
            icon_details: "פרטים",
            icon_edit: "ערוך",
            icon_delete: "מחק",
            confirm_closing: "", //Your changes will be lost, are your sure ?
            confirm_deleting: "ארוע ימחק סופית.להמשיך?",
            section_description: "תיאור",
            section_time: "תקופה",

            confirm_recurring: "האם ברצונך לשנות כל סדרת ארועים מתמשכים?",
            section_recurring: "להעתיק ארוע",
            button_recurring: "לא פעיל",
            button_recurring_open: "פעיל",
            full_day: "יום שלם",
            button_edit_series: "ערוך את הסדרה",
            button_edit_occurrence: "עריכת עותק",

            /*agenda view extension*/
            agenda_tab: "סדר יום",
            date: "תאריך",
            description: "תיאור",

            /*year view extension*/
            year_tab: "לשנה",

            /*week agenda view extension*/
            week_agenda_tab: "סדר יום",

            /*grid view extension*/
            grid_tab: "סורג",

            /* touch tooltip*/
            drag_to_create: "Drag to create",
            drag_to_move: "גרור כדי להזיז",

            /* dhtmlx message default buttons */
            message_ok: "OK",
            message_cancel: "בטל",

            /* wai aria labels for non-text controls */
            next: "הבא",
            prev: "הקודם",
            year: "שנה",
            month: "חודש",
            day: "יום",
            hour: "שעה",
            minute: "דקה"
        }
    };


});