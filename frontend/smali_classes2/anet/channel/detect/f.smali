.class Lanet/channel/detect/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/util/AppLifecycle$AppLifecycleListener;


# instance fields
.field final synthetic a:Lanet/channel/detect/d;


# direct methods
.method constructor <init>(Lanet/channel/detect/d;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/f;->a:Lanet/channel/detect/d;

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public background()V
    .locals 4

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "anet.HorseRaceDetector"

    const-string v2, "background"

    const/4 v3, 0x0

    .line 113
    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 114
    invoke-static {}, Lanet/channel/AwcnConfig;->isHorseRaceEnable()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 117
    :cond_0
    new-instance v0, Lanet/channel/detect/g;

    invoke-direct {v0, p0}, Lanet/channel/detect/g;-><init>(Lanet/channel/detect/f;)V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitHRTask(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method public forground()V
    .locals 0

    return-void
.end method
