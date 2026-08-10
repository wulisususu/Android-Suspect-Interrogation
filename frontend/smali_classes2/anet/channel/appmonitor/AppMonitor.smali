.class public Lanet/channel/appmonitor/AppMonitor;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/appmonitor/AppMonitor$a;
    }
.end annotation


# static fields
.field private static volatile apmMonitor:Lanet/channel/appmonitor/IAppMonitor;

.field private static volatile appMonitor:Lanet/channel/appmonitor/IAppMonitor;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 11
    new-instance v0, Lanet/channel/appmonitor/AppMonitor$a;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lanet/channel/appmonitor/AppMonitor$a;-><init>(Lanet/channel/appmonitor/IAppMonitor;)V

    sput-object v0, Lanet/channel/appmonitor/AppMonitor;->appMonitor:Lanet/channel/appmonitor/IAppMonitor;

    sput-object v1, Lanet/channel/appmonitor/AppMonitor;->apmMonitor:Lanet/channel/appmonitor/IAppMonitor;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lanet/channel/appmonitor/IAppMonitor;
    .locals 1

    sget-object v0, Lanet/channel/appmonitor/AppMonitor;->apmMonitor:Lanet/channel/appmonitor/IAppMonitor;

    return-object v0
.end method

.method public static getInstance()Lanet/channel/appmonitor/IAppMonitor;
    .locals 1

    sget-object v0, Lanet/channel/appmonitor/AppMonitor;->appMonitor:Lanet/channel/appmonitor/IAppMonitor;

    return-object v0
.end method

.method public static setApmMonitor(Lanet/channel/appmonitor/IAppMonitor;)V
    .locals 0

    sput-object p0, Lanet/channel/appmonitor/AppMonitor;->apmMonitor:Lanet/channel/appmonitor/IAppMonitor;

    return-void
.end method

.method public static setInstance(Lanet/channel/appmonitor/IAppMonitor;)V
    .locals 1

    .line 19
    new-instance v0, Lanet/channel/appmonitor/AppMonitor$a;

    invoke-direct {v0, p0}, Lanet/channel/appmonitor/AppMonitor$a;-><init>(Lanet/channel/appmonitor/IAppMonitor;)V

    sput-object v0, Lanet/channel/appmonitor/AppMonitor;->appMonitor:Lanet/channel/appmonitor/IAppMonitor;

    return-void
.end method
