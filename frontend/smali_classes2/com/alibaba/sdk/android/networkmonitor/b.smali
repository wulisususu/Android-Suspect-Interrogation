.class public Lcom/alibaba/sdk/android/networkmonitor/b;
.super Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;
.source "NetworkMonitorManagerImpl.java"


# static fields
.field static a:Lcom/alibaba/sdk/android/networkmonitor/b;


# instance fields
.field private a:Landroid/content/Context;

.field private a:Lcom/alibaba/sdk/android/emas/EmasSender;

.field private a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

.field private a:Ljava/lang/Boolean;

.field private a:Ljava/lang/String;

.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/networkmonitor/utils/Logger;",
            ">;"
        }
    .end annotation
.end field

.field private final a:Ljava/util/concurrent/atomic/AtomicInteger;

.field private b:Ljava/lang/String;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/networkmonitor/utils/a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/b;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/networkmonitor/b;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;-><init>()V

    .line 9
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 12
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->b:Ljava/util/List;

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/networkmonitor/b;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    return-object p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/networkmonitor/b;)Ljava/util/List;
    .locals 0

    .line 3
    iget-object p0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->b:Ljava/util/List;

    return-object p0
.end method

.method private declared-synchronized a()V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 4
    monitor-exit p0

    return-void

    .line 8
    :cond_0
    :try_start_1
    new-instance v0, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;-><init>()V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Landroid/app/Application;

    .line 9
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->context(Landroid/app/Application;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Ljava/lang/String;

    .line 10
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->appId(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->b:Ljava/lang/String;

    .line 11
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->appKey(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->d:Ljava/lang/String;

    .line 12
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->appVersion(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->e:Ljava/lang/String;

    .line 13
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->channel(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/lang/String;

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    .line 14
    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->f:Ljava/lang/String;

    :cond_1
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->userNick(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->b:Ljava/lang/String;

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    .line 15
    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->h:Ljava/lang/String;

    :cond_2
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->host(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    const-string v1, "61004_AliHANetwork"

    .line 16
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->businessKey(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/lang/Boolean;

    if-nez v1, :cond_3

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    .line 17
    iget-boolean v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Z

    goto :goto_0

    :cond_3
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    :goto_0
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->openHttp(Z)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->c:Ljava/lang/String;

    .line 18
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->appSecret(Ljava/lang/String;)Lcom/alibaba/sdk/android/emas/EmasSender$Builder;

    move-result-object v0

    .line 19
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/EmasSender$Builder;->build()Lcom/alibaba/sdk/android/emas/EmasSender;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    .line 20
    iget v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:I

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/EmasSender;->setNoCollectionDataType(I)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x2

    .line 22
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;->set(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/networkmonitor/b;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/b;->a()V

    return-void
.end method


# virtual methods
.method public a()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Landroid/content/Context;

    return-object v0
.end method

.method public a()Lcom/alibaba/sdk/android/emas/EmasSender;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    if-eqz v0, :cond_0

    return-object v0

    .line 31
    :cond_0
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/b;->a()V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    return-object v0
.end method

.method public a()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/networkmonitor/utils/Logger;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/List;

    return-object v0
.end method

.method public a(Lcom/alibaba/sdk/android/networkmonitor/utils/a;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->b:Ljava/util/List;

    .line 25
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public a()Z
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 23
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public addLogger(Lcom/alibaba/sdk/android/networkmonitor/utils/Logger;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/List;

    if-nez v0, :cond_1

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/List;

    .line 5
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public changeHost(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/emas/EmasSender;->changeHost(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->b:Ljava/lang/String;

    :goto_0
    return-void
.end method

.method public init(Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;)V
    .locals 4

    .line 1
    iget-object v0, p1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Landroid/app/Application;

    const-string v1, "NetworkMonitorManager"

    if-eqz v0, :cond_2

    iget-object v0, p1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->b:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->d:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->g:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v2, 0x0

    const/4 v3, 0x1

    .line 6
    invoke-virtual {v0, v2, v3}, Ljava/util/concurrent/atomic/AtomicInteger;->compareAndSet(II)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 7
    iget-object v0, p1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Landroid/content/Context;

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    .line 10
    new-instance p1, Ljava/lang/Thread;

    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/b$a;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/b$a;-><init>(Lcom/alibaba/sdk/android/networkmonitor/b;)V

    invoke-direct {p1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 16
    invoke-virtual {p1}, Ljava/lang/Thread;->start()V

    .line 18
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object p1

    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/b$b;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/b$b;-><init>(Lcom/alibaba/sdk/android/networkmonitor/b;)V

    invoke-virtual {p1, v0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->addObserver(Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V

    const-string p1, "init network monitor success. version=1.6.7"

    .line 46
    invoke-static {v1, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    return-void

    :cond_2
    :goto_0
    const-string p1, "init network monitor failed. please check params."

    .line 47
    invoke-static {v1, p1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public openHttp(Z)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/emas/EmasSender;->openHttp(Z)V

    goto :goto_0

    .line 4
    :cond_0
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/lang/Boolean;

    :goto_0
    return-void
.end method

.method public removeLogger(Lcom/alibaba/sdk/android/networkmonitor/utils/Logger;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/List;

    if-nez v0, :cond_1

    return-void

    .line 5
    :cond_1
    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    return-void
.end method

.method public setNoCollectionDataType(I)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    if-nez v0, :cond_0

    return-void

    .line 5
    :cond_0
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/networkmonitor/b;->a()Lcom/alibaba/sdk/android/emas/EmasSender;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/emas/EmasSender;->setNoCollectionDataType(I)V

    return-void
.end method

.method public updateUserNick(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 2
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/emas/EmasSender;->setUserNick(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Ljava/lang/String;

    :goto_0
    return-void
.end method
