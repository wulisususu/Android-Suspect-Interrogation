.class public Lcom/taobao/accs/utl/AppMonitorAdapter;
.super Ljava/lang/Object;
.source "Taobao"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 22
    new-instance v0, Lanet/channel/statist/AlarmObject;

    invoke-direct {v0}, Lanet/channel/statist/AlarmObject;-><init>()V

    .line 23
    iput-object p0, v0, Lanet/channel/statist/AlarmObject;->module:Ljava/lang/String;

    .line 24
    iput-object p1, v0, Lanet/channel/statist/AlarmObject;->modulePoint:Ljava/lang/String;

    .line 25
    iput-object p2, v0, Lanet/channel/statist/AlarmObject;->arg:Ljava/lang/String;

    .line 26
    iput-object p3, v0, Lanet/channel/statist/AlarmObject;->errorCode:Ljava/lang/String;

    .line 27
    iput-object p4, v0, Lanet/channel/statist/AlarmObject;->errorMsg:Ljava/lang/String;

    const/4 p0, 0x0

    .line 28
    iput-boolean p0, v0, Lanet/channel/statist/AlarmObject;->isSuccess:Z

    .line 29
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p0

    invoke-interface {p0, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitAlarm(Lanet/channel/statist/AlarmObject;)V

    return-void
.end method

.method public static commitAlarmSuccess(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 11
    new-instance v0, Lanet/channel/statist/AlarmObject;

    invoke-direct {v0}, Lanet/channel/statist/AlarmObject;-><init>()V

    .line 12
    iput-object p0, v0, Lanet/channel/statist/AlarmObject;->module:Ljava/lang/String;

    .line 13
    iput-object p1, v0, Lanet/channel/statist/AlarmObject;->modulePoint:Ljava/lang/String;

    .line 14
    iput-object p2, v0, Lanet/channel/statist/AlarmObject;->arg:Ljava/lang/String;

    const/4 p0, 0x1

    .line 15
    iput-boolean p0, v0, Lanet/channel/statist/AlarmObject;->isSuccess:Z

    .line 16
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p0

    invoke-interface {p0, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitAlarm(Lanet/channel/statist/AlarmObject;)V

    return-void
.end method

.method public static commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V
    .locals 1

    .line 35
    new-instance v0, Lanet/channel/statist/CountObject;

    invoke-direct {v0}, Lanet/channel/statist/CountObject;-><init>()V

    .line 36
    iput-object p0, v0, Lanet/channel/statist/CountObject;->module:Ljava/lang/String;

    .line 37
    iput-object p1, v0, Lanet/channel/statist/CountObject;->modulePoint:Ljava/lang/String;

    .line 38
    iput-object p2, v0, Lanet/channel/statist/CountObject;->arg:Ljava/lang/String;

    .line 39
    iput-wide p3, v0, Lanet/channel/statist/CountObject;->value:D

    .line 40
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p0

    invoke-interface {p0, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitCount(Lanet/channel/statist/CountObject;)V

    return-void
.end method
