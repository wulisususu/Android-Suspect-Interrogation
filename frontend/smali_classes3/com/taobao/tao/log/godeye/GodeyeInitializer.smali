.class public Lcom/taobao/tao/log/godeye/GodeyeInitializer;
.super Ljava/lang/Object;
.source "GodeyeInitializer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/godeye/GodeyeInitializer$a;
    }
.end annotation


# instance fields
.field public config:Lcom/taobao/tao/log/godeye/GodeyeConfig;

.field enabling:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->config:Lcom/taobao/tao/log/godeye/GodeyeConfig;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/godeye/GodeyeInitializer$1;)V
    .locals 0

    .line 21
    invoke-direct {p0}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/taobao/tao/log/godeye/GodeyeInitializer;
    .locals 2

    const-class v0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    monitor-enter v0

    .line 42
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/godeye/GodeyeInitializer$a;->a()Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public handleRemoteCommand(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)Z
    .locals 1

    .line 86
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->handleRemoteCommand(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)Z

    move-result p1

    return p1
.end method

.method public init(Landroid/app/Application;Lcom/taobao/tao/log/godeye/GodeyeConfig;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 51
    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    if-nez p2, :cond_0

    .line 55
    new-instance p2, Lcom/taobao/tao/log/godeye/GodeyeConfig;

    invoke-direct {p2}, Lcom/taobao/tao/log/godeye/GodeyeConfig;-><init>()V

    :cond_0
    iput-object p2, p0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->config:Lcom/taobao/tao/log/godeye/GodeyeConfig;

    .line 59
    iget-object p2, p2, Lcom/taobao/tao/log/godeye/GodeyeConfig;->appVersion:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->config:Lcom/taobao/tao/log/godeye/GodeyeConfig;

    .line 60
    iget-object v0, v0, Lcom/taobao/tao/log/godeye/GodeyeConfig;->packageTag:Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->config:Lcom/taobao/tao/log/godeye/GodeyeConfig;

    .line 61
    iget-object v1, v1, Lcom/taobao/tao/log/godeye/GodeyeConfig;->appId:Ljava/lang/String;

    .line 64
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v2

    iget-object v3, p0, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->config:Lcom/taobao/tao/log/godeye/GodeyeConfig;

    iget-object v3, v3, Lcom/taobao/tao/log/godeye/GodeyeConfig;->utdid:Ljava/lang/String;

    iput-object v3, v2, Lcom/taobao/tao/log/godeye/core/control/Godeye;->utdid:Ljava/lang/String;

    .line 65
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v2

    invoke-virtual {v2, p1, v1, p2}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->initialize(Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;)V

    .line 66
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->setBuildId(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public onAccurateBootFinished(Ljava/util/HashMap;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 105
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeJointPointCenter()Lcom/taobao/tao/log/godeye/core/control/a;

    move-result-object p1

    const-string v0, "event.launchFinished"

    invoke-virtual {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/lang/String;)V

    return-void
.end method

.method public registGodEyeAppListener(Lcom/taobao/tao/log/godeye/core/GodEyeAppListener;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 96
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    iput-object p1, v0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->godEyeAppListener:Lcom/taobao/tao/log/godeye/core/GodEyeAppListener;

    :cond_0
    return-void
.end method

.method public registGodEyeReponse(Ljava/lang/String;Lcom/taobao/tao/log/godeye/core/GodEyeReponse;)V
    .locals 1

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    .line 76
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    iget-object v0, v0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->godEyeReponses:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-void
.end method
