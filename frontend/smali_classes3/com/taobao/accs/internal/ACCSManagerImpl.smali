.class public Lcom/taobao/accs/internal/ACCSManagerImpl;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/taobao/accs/IACCSManager;


# instance fields
.field public a:Lcom/taobao/accs/net/b;

.field private b:I

.field private c:Z

.field private final d:Ljava/lang/String;

.field private final e:Lcom/alibaba/sdk/android/logger/ILog;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    iput-boolean v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->c:Z

    .line 58
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/taobao/accs/client/GlobalClientInfo;->a:Landroid/content/Context;

    .line 59
    new-instance v0, Lcom/taobao/accs/net/j;

    sget-object v1, Lcom/taobao/accs/client/GlobalClientInfo;->a:Landroid/content/Context;

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, p2}, Lcom/taobao/accs/net/j;-><init>(Landroid/content/Context;ILjava/lang/String;)V

    iput-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    iput-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->d:Ljava/lang/String;

    .line 62
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "ACCSMgrImpl_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    iget-object v1, v1, Lcom/taobao/accs/net/b;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 63
    invoke-static {v0}, Lcom/taobao/accs/utl/AccsLogger;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    .line 65
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v1, Lcom/taobao/accs/internal/a;

    invoke-direct {v1, p0, p2, p1}, Lcom/taobao/accs/internal/a;-><init>(Lcom/taobao/accs/internal/ACCSManagerImpl;Ljava/lang/String;Landroid/content/Context;)V

    const-wide/16 p1, 0x40

    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, p1, p2, v2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method

.method private a(Landroid/content/Context;I)Landroid/content/Intent;
    .locals 3

    .line 565
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "com.taobao.accs.intent.action.COMMAND"

    .line 566
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 567
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/taobao/accs/utl/AdapterUtilityImpl;->channelService:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "packageName"

    .line 568
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "command"

    .line 569
    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 570
    iget-object p1, p1, Lcom/taobao/accs/net/b;->b:Ljava/lang/String;

    const-string p2, "appKey"

    invoke-virtual {v0, p2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "configTag"

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->d:Ljava/lang/String;

    .line 571
    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    return-object v0
.end method

.method private a(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 596
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.taobao.accs.intent.action.RECEIVE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 597
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "command"

    .line 598
    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "serviceId"

    .line 599
    invoke-virtual {v0, v1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p3, "dataId"

    .line 600
    invoke-virtual {v0, p3, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 601
    iget-object p3, p3, Lcom/taobao/accs/net/b;->b:Ljava/lang/String;

    const-string p4, "appKey"

    invoke-virtual {v0, p4, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p3, "configTag"

    iget-object p4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->d:Ljava/lang/String;

    .line 602
    invoke-virtual {v0, p3, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/4 p3, 0x2

    if-ne p2, p3, :cond_0

    .line 603
    sget-object p2, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_0

    :cond_0
    sget-object p2, Lcom/taobao/accs/AccsErrorCode;->APP_NOT_BIND:Lcom/alibaba/sdk/android/error/ErrorCode;

    :goto_0
    const-string p3, "errorObj"

    invoke-virtual {v0, p3, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 606
    invoke-static {p1, v0}, Lcom/taobao/accs/data/g;->a(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method private a(Landroid/content/Context;Lcom/taobao/accs/data/Message;IZ)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 176
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->a()V

    if-nez p2, :cond_0

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p4, "message is null"

    .line 178
    invoke-interface {p2, p4}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    .line 180
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    .line 179
    invoke-static {p1, p3}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 181
    sget-object p3, Lcom/taobao/accs/AccsErrorCode;->PARAMETER_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p2, p1, p3}, Lcom/taobao/accs/net/b;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    goto/16 :goto_1

    :cond_0
    const/4 p1, 0x1

    if-eq p3, p1, :cond_2

    const/4 p4, 0x2

    if-eq p3, p4, :cond_1

    goto :goto_0

    :cond_1
    iget-object p4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 202
    invoke-virtual {p4}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object p4

    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->f()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p4, v0}, Lcom/taobao/accs/client/c;->e(Ljava/lang/String;)Z

    move-result p4

    if-eqz p4, :cond_5

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "unbind app, already unbind"

    .line 203
    invoke-interface {p1, p3}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 204
    sget-object p3, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1, p2, p3}, Lcom/taobao/accs/net/b;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    goto :goto_1

    .line 186
    :cond_2
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->f()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 187
    invoke-virtual {v1}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/taobao/accs/client/c;->d(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    if-nez p4, :cond_3

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p4, "bind app from cache"

    .line 188
    invoke-interface {p3, p4}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    .line 189
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object p3

    iget-object p4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->d:Ljava/lang/String;

    const-string v0, "bfc"

    .line 190
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    .line 189
    invoke-virtual {p3, p4, v0, p1}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 191
    sget-object p3, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1, p2, p3}, Lcom/taobao/accs/net/b;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 193
    invoke-virtual {v1}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/taobao/accs/client/c;->f(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    if-nez p4, :cond_4

    goto :goto_1

    :cond_4
    iget-object p4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 198
    invoke-virtual {p4}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object p4

    invoke-virtual {p4, v0}, Lcom/taobao/accs/client/c;->c(Ljava/lang/String;)V

    :cond_5
    :goto_0
    iget-object p4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "command"

    .line 210
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    const-string v1, "sendControlMessage"

    filled-new-array {v1, v0, p3}, [Ljava/lang/Object;

    move-result-object p3

    invoke-interface {p4, p3}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 211
    invoke-virtual {p3, p2, p1}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    :goto_1
    return-void
.end method

.method private a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    const/4 v0, 0x1

    .line 132
    invoke-direct {p0, p1, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;I)Landroid/content/Intent;

    move-result-object v1

    .line 135
    :try_start_0
    invoke-static {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object v2

    invoke-virtual {v2}, Lcom/taobao/accs/client/GlobalClientInfo;->getPackageInfo()Landroid/content/pm/PackageInfo;

    move-result-object v2

    iget-object v2, v2, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    .line 136
    invoke-static {p1}, Lcom/taobao/accs/utl/UtilityImpl;->c(Landroid/content/Context;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "EMAS_ACCS_SDK"

    .line 137
    invoke-static {v3, p1}, Lcom/taobao/accs/utl/UtilityImpl;->utdidChanged(Ljava/lang/String;Landroid/content/Context;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    move v3, v0

    :goto_1
    if-eqz v3, :cond_2

    iget-object v4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v5, "force bindApp"

    .line 139
    invoke-interface {v4, v5}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    const-string v4, "fouce_bind"

    .line 140
    invoke-virtual {v1, v4, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    :cond_2
    const-string v4, "appKey"

    .line 142
    invoke-virtual {v1, v4, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p2, "ttid"

    .line 143
    invoke-virtual {v1, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p2, "appVersion"

    .line 144
    invoke-virtual {v1, p2, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p2, "app_sercet"

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 145
    iget-object p3, p3, Lcom/taobao/accs/net/b;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p3}, Lcom/taobao/accs/AccsClientConfig;->getAppSecret()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v1, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 146
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_5

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 147
    invoke-static {p2, p1, v1}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Landroid/content/Context;Landroid/content/Intent;)Lcom/taobao/accs/data/Message;

    move-result-object p2

    .line 149
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p3

    if-eqz p3, :cond_4

    .line 150
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p3

    iget-object v1, p2, Lcom/taobao/accs/data/Message;->q:Ljava/lang/String;

    invoke-virtual {p3, v1}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setDataId(Ljava/lang/String;)V

    .line 151
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p3

    invoke-virtual {p3, v0}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setMsgType(I)V

    .line 153
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p3

    iget-object v1, p2, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    if-eqz v1, :cond_3

    iget-object v1, p2, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    .line 154
    invoke-virtual {v1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    :cond_3
    const-string v1, ""

    .line 153
    :goto_2
    invoke-virtual {p3, v1}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setHost(Ljava/lang/String;)V

    .line 156
    :cond_4
    invoke-direct {p0, p1, p2, v0, v3}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Lcom/taobao/accs/data/Message;IZ)V

    goto :goto_3

    :cond_5
    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "bindApp only allow in target process"

    .line 158
    invoke-interface {p2, p3}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    :goto_3
    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 160
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcom/taobao/accs/net/b;->b(Landroid/content/Context;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_4

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "bindApp exception"

    .line 162
    invoke-interface {p2, p3, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_4
    return-void
.end method

.method static synthetic a(Lcom/taobao/accs/internal/ACCSManagerImpl;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 46
    invoke-direct {p0, p1, p2, p3}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private a(Landroid/content/Context;)Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    if-eqz v0, :cond_1

    .line 560
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v0

    .line 561
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    .line 560
    invoke-virtual {v0, p1}, Lcom/taobao/accs/client/c;->d(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    :goto_1
    return p1
.end method

.method static synthetic a(Lcom/taobao/accs/internal/ACCSManagerImpl;)Z
    .locals 0

    .line 46
    iget-boolean p0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->c:Z

    return p0
.end method


# virtual methods
.method public bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 6

    const-string v3, "accs"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p3

    move-object v5, p4

    .line 95
    invoke-virtual/range {v0 .. v5}, Lcom/taobao/accs/internal/ACCSManagerImpl;->bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void
.end method

.method public bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 3

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 p3, 0x1

    iput-boolean p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->c:Z

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "bindApp"

    const-string v2, "appKey"

    .line 106
    filled-new-array {v1, v2, p2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d([Ljava/lang/Object;)V

    .line 107
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p3}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object p3

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 109
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->k()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    iget-object v0, v0, Lcom/taobao/accs/net/b;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getAppSecret()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "isSecurityOff and null secret"

    .line 110
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 111
    sget-object p2, Lcom/taobao/accs/AccsErrorCode;->APPSECRET_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1, p3, p2}, Lcom/taobao/accs/net/b;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    return-void

    .line 114
    :cond_1
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "appKey is null"

    .line 115
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 116
    sget-object p2, Lcom/taobao/accs/AccsErrorCode;->APPKEY_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1, p3, p2}, Lcom/taobao/accs/net/b;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    return-void

    :cond_2
    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 119
    iput-object p4, p3, Lcom/taobao/accs/net/b;->a:Ljava/lang/String;

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 120
    iput-object p2, p3, Lcom/taobao/accs/net/b;->b:Ljava/lang/String;

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 121
    iget-object p3, p3, Lcom/taobao/accs/net/b;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p3}, Lcom/taobao/accs/AccsClientConfig;->getAppSecret()Ljava/lang/String;

    invoke-static {p1, p2}, Lcom/taobao/accs/utl/UtilityImpl;->e(Landroid/content/Context;Ljava/lang/String;)V

    if-eqz p5, :cond_3

    .line 125
    invoke-static {}, Lcom/taobao/accs/client/a;->a()Lcom/taobao/accs/client/a;

    move-result-object p3

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->d:Ljava/lang/String;

    .line 126
    invoke-static {p5}, Lcom/taobao/accs/utl/c;->a(Lcom/taobao/accs/IAppReceiver;)Lcom/taobao/accs/IAppReceiver;

    move-result-object p5

    .line 125
    invoke-virtual {p3, v0, p5}, Lcom/taobao/accs/client/a;->a(Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    .line 128
    :cond_3
    invoke-direct {p0, p1, p2, p4}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public bindService(Landroid/content/Context;Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "bindService"

    const-string v2, "serviceId"

    .line 306
    filled-new-array {v1, v2, p2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 307
    invoke-direct {p0, p1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x5

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 308
    invoke-direct {p0, p1, v1, p2, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V

    return-void

    .line 311
    :cond_0
    invoke-direct {p0, p1, v1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;I)Landroid/content/Intent;

    move-result-object v0

    iget-object v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 312
    invoke-virtual {v3}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v3

    .line 313
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "appKey null"

    .line 314
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_1
    const-string v4, "appKey"

    .line 317
    invoke-virtual {v0, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 318
    invoke-virtual {v0, v2, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 320
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_4

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 321
    invoke-static {p2, v0}, Lcom/taobao/accs/data/Message;->b(Lcom/taobao/accs/net/b;Landroid/content/Intent;)Lcom/taobao/accs/data/Message;

    move-result-object p2

    .line 322
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 323
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    iget-object v2, p2, Lcom/taobao/accs/data/Message;->q:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setDataId(Ljava/lang/String;)V

    .line 324
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    const/4 v2, 0x3

    invoke-virtual {v0, v2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setMsgType(I)V

    .line 326
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    iget-object v2, p2, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    if-eqz v2, :cond_2

    iget-object v2, p2, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    .line 327
    invoke-virtual {v2}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_2
    const-string v2, ""

    .line 326
    :goto_0
    invoke-virtual {v0, v2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setHost(Ljava/lang/String;)V

    :cond_3
    const/4 v0, 0x0

    .line 329
    invoke-direct {p0, p1, p2, v1, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Lcom/taobao/accs/data/Message;IZ)V

    goto :goto_1

    :cond_4
    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "bindService not target process, ignored"

    .line 331
    invoke-interface {p2, v0}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    :goto_1
    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 333
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcom/taobao/accs/net/b;->b(Landroid/content/Context;)V

    return-void
.end method

.method public bindUser(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 233
    invoke-virtual {p0, p1, p2, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->bindUser(Landroid/content/Context;Ljava/lang/String;Z)V

    return-void
.end method

.method public bindUser(Landroid/content/Context;Ljava/lang/String;Z)V
    .locals 8

    const-string v0, "bindUser"

    :try_start_0
    iget-object v1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    const-string v3, "userId"

    const/4 v4, 0x1

    aput-object v3, v2, v4

    const/4 v3, 0x2

    aput-object p2, v2, v3

    const-string v5, "force"

    const/4 v6, 0x3

    aput-object v5, v2, v6

    .line 240
    invoke-static {p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    const/4 v7, 0x4

    aput-object v5, v2, v7

    invoke-interface {v1, v2}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 241
    invoke-direct {p0, p1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 p2, 0x0

    .line 242
    invoke-direct {p0, p1, v6, p2, p2}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V

    return-void

    .line 245
    :cond_0
    invoke-direct {p0, p1, v6}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;I)Landroid/content/Intent;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 246
    invoke-virtual {v2}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v2

    .line 247
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "appkey null"

    .line 248
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    .line 252
    :cond_1
    invoke-static {p1}, Lcom/taobao/accs/utl/UtilityImpl;->c(Landroid/content/Context;)Z

    move-result v5

    if-nez v5, :cond_2

    if-eqz p3, :cond_3

    :cond_2
    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v5, "force bind user"

    .line 253
    invoke-interface {p3, v5}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    const-string p3, "fouce_bind"

    .line 255
    invoke-virtual {v1, p3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    move p3, v4

    :cond_3
    const-string v4, "appKey"

    .line 257
    invoke-virtual {v1, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "userInfo"

    .line 258
    invoke-virtual {v1, v2, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 260
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_6

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 261
    invoke-static {p2, v1}, Lcom/taobao/accs/data/Message;->d(Lcom/taobao/accs/net/b;Landroid/content/Intent;)Lcom/taobao/accs/data/Message;

    move-result-object p2

    .line 263
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 264
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v1

    iget-object v2, p2, Lcom/taobao/accs/data/Message;->q:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setDataId(Ljava/lang/String;)V

    .line 265
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v1

    invoke-virtual {v1, v3}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setMsgType(I)V

    .line 267
    invoke-virtual {p2}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v1

    iget-object v2, p2, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    if-eqz v2, :cond_4

    iget-object v2, p2, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    .line 268
    invoke-virtual {v2}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_4
    const-string v2, ""

    .line 267
    :goto_0
    invoke-virtual {v1, v2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setHost(Ljava/lang/String;)V

    .line 270
    :cond_5
    invoke-direct {p0, p1, p2, v6, p3}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Lcom/taobao/accs/data/Message;IZ)V

    goto :goto_1

    :cond_6
    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "bindUser not target process, ignored"

    .line 272
    invoke-interface {p2, p3}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    :goto_1
    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 274
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcom/taobao/accs/net/b;->b(Landroid/content/Context;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    .line 276
    invoke-interface {p2, v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_2
    return-void
.end method

.method public cancel(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 0

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 659
    invoke-virtual {p1, p2}, Lcom/taobao/accs/net/b;->a(Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public cleanLocalBindInfo()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 771
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/client/c;->a()V

    return-void
.end method

.method public clearLoginInfo(Landroid/content/Context;)V
    .locals 0

    .line 654
    invoke-static {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->clearLoginInfoImpl()V

    return-void
.end method

.method public disconnect()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 786
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->n()V

    return-void
.end method

.method public forceDisableService(Landroid/content/Context;)V
    .locals 0

    return-void
.end method

.method public forceEnableService(Landroid/content/Context;)V
    .locals 0

    return-void
.end method

.method public forceReConnectChannel()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 691
    iget-object v0, v0, Lcom/taobao/accs/net/b;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/SessionCenter;->forceRecreateAccsSession()V

    .line 692
    invoke-virtual {p0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->getChannelState()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getChannelState()Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    const/4 v1, 0x0

    .line 670
    invoke-virtual {v0, v1}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 671
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    const/4 v2, 0x0

    .line 672
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 673
    iget-object v2, v2, Lcom/taobao/accs/net/b;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v2}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object v2

    const-wide/32 v3, 0xea60

    .line 674
    invoke-virtual {v2, v0, v3, v4}, Lanet/channel/SessionCenter;->getThrowsException(Ljava/lang/String;J)Lanet/channel/Session;

    move-result-object v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    .line 677
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v2, "getChannelState"

    .line 679
    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    return-object v1
.end method

.method public getLastConnectErrorCode()I
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 781
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->m()I

    move-result v0

    return v0
.end method

.method public getUserUnit()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public isChannelError(I)Z
    .locals 0

    .line 714
    invoke-static {p1}, Lcom/taobao/accs/AccsErrorCode;->isChannelError(I)Z

    move-result p1

    return p1
.end method

.method public isConnected()Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 776
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->l()Z

    move-result v0

    return v0
.end method

.method public isNetworkReachable(Landroid/content/Context;)Z
    .locals 0

    .line 556
    invoke-static {p1}, Lcom/taobao/accs/utl/UtilityImpl;->g(Landroid/content/Context;)Z

    move-result p1

    return p1
.end method

.method public reconnect()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 791
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->o()V

    return-void
.end method

.method public registerDataListener(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/base/AccsAbstractDataListener;)V
    .locals 0

    .line 743
    invoke-static {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object p1

    invoke-virtual {p1, p2, p3}, Lcom/taobao/accs/client/GlobalClientInfo;->registerListener(Ljava/lang/String;Lcom/taobao/accs/base/AccsAbstractDataListener;)V

    return-void
.end method

.method public registerService(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 726
    invoke-static {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object p1

    invoke-virtual {p1, p2, p3}, Lcom/taobao/accs/client/GlobalClientInfo;->registerService(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public reset()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 797
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->p()V

    const/4 v0, 0x0

    .line 800
    :try_start_0
    sget-object v1, Lcom/taobao/accs/client/GlobalClientInfo;->a:Landroid/content/Context;

    const-string v2, "EMAS_ACCS_SDK"

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 802
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 803
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    .line 804
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 806
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 808
    :goto_0
    invoke-static {}, Lcom/taobao/accs/client/a;->a()Lcom/taobao/accs/client/a;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/taobao/accs/client/a;->b(Ljava/lang/String;)V

    iput-boolean v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->c:Z

    return-void
.end method

.method public sendBusinessAck(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/util/Map;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "S",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 756
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->a()V

    iget-object v1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    const/4 v5, 0x1

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v6, p4

    move-object v7, p5

    move-object v8, p6

    .line 757
    invoke-static/range {v1 .. v8}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZSLjava/lang/String;Ljava/util/Map;)Lcom/taobao/accs/data/Message;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    const/4 p3, 0x1

    .line 759
    invoke-virtual {p2, p1, p3}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    return-void
.end method

.method public sendData(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;
    .locals 6

    .line 381
    :try_start_0
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "sendData not in target process"

    .line 382
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-object v1

    :cond_0
    if-nez p2, :cond_1

    const-string p1, "accs"

    const-string v0, "send_fail"

    const-string v2, ""

    const-string v3, "1"

    const-string v4, "data null"

    .line 386
    invoke-static {p1, v0, v2, v3, v4}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "sendData dataInfo null"

    .line 388
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-object v1

    .line 391
    :cond_1
    iget-object v0, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v2, 0x1

    if-eqz v0, :cond_2

    const-class v0, Lcom/taobao/accs/internal/ACCSManagerImpl;

    .line 392
    monitor-enter v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    .line 394
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    .line 395
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1

    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 398
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v0

    .line 399
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string p1, "accs"

    const-string v0, "send_fail"

    .line 400
    iget-object v3, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->serviceId:Ljava/lang/String;

    const-string v4, "1"

    const-string v5, "data appkey null"

    invoke-static {p1, v0, v3, v4, v5}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    const-string v3, "sendData appkey null"

    const/4 v4, 0x0

    aput-object v3, v0, v4

    const-string v3, "dataId"

    aput-object v3, v0, v2

    .line 403
    iget-object v2, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    const/4 v3, 0x2

    aput-object v2, v0, v3

    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    return-object v1

    :cond_3
    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 406
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->a()V

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 407
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, p1, v1, p2}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/ACCSManager$AccsRequest;)Lcom/taobao/accs/data/Message;

    move-result-object p1

    .line 409
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 410
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onSend()V

    :cond_4
    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 412
    invoke-virtual {v0, p1, v2}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p1

    const-string v0, "accs"

    const-string v1, "send_fail"

    .line 414
    iget-object v2, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->serviceId:Ljava/lang/String;

    const-string v3, "1"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "data "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 416
    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 414
    invoke-static {v0, v1, v2, v3, v4}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "sendData"

    const-string v2, "dataId"

    .line 417
    iget-object v3, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    filled-new-array {v1, v2, v3, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    .line 419
    :goto_1
    iget-object p1, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    return-object p1
.end method

.method public sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;)Ljava/lang/String;
    .locals 7

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    .line 363
    invoke-virtual/range {v0 .. v6}, Lcom/taobao/accs/internal/ACCSManagerImpl;->sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    const/4 v7, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    .line 369
    invoke-virtual/range {v0 .. v7}, Lcom/taobao/accs/internal/ACCSManagerImpl;->sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;
    .locals 9

    .line 374
    new-instance v8, Lcom/taobao/accs/ACCSManager$AccsRequest;

    const/4 v7, 0x0

    move-object v0, v8

    move-object v1, p2

    move-object v2, p3

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    move-object/from16 v6, p7

    invoke-direct/range {v0 .. v7}, Lcom/taobao/accs/ACCSManager$AccsRequest;-><init>(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;Ljava/lang/String;)V

    move-object v0, p0

    move-object v1, p1

    .line 376
    invoke-virtual {p0, p1, v8}, Lcom/taobao/accs/internal/ACCSManagerImpl;->sendData(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public sendPushResponse(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)Ljava/lang/String;
    .locals 10

    const/4 v0, 0x4

    const/4 v1, 0x5

    const/4 v2, 0x3

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-eqz p1, :cond_4

    if-nez p2, :cond_0

    goto/16 :goto_1

    :cond_0
    :try_start_0
    const-string v7, "accs"

    const-string v8, "send_fail"

    const-string v9, "push response total"

    .line 512
    invoke-static {v7, v8, v9}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmSuccess(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v7, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 515
    invoke-virtual {v7}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v7

    .line 516
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_1

    const-string p1, "accs"

    const-string p3, "send_fail"

    .line 517
    iget-object v0, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->serviceId:Ljava/lang/String;

    const-string v1, "1"

    const-string v7, "sendPushResponse appkey null"

    invoke-static {p1, p3, v0, v1, v7}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    new-array p3, v2, [Ljava/lang/Object;

    const-string v0, "sendPushResponse appkey null"

    aput-object v0, p3, v4

    const-string v0, "dataid"

    aput-object v0, p3, v6

    .line 520
    iget-object v0, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    aput-object v0, p3, v3

    invoke-interface {p1, p3}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    return-object v5

    .line 523
    :cond_1
    iget-object v7, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_2

    const-class v7, Lcom/taobao/accs/internal/ACCSManagerImpl;

    .line 524
    monitor-enter v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget v8, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    .line 526
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    iget v9, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    iput-object v8, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    .line 527
    monitor-exit v7

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1

    :cond_2
    :goto_0
    if-nez p3, :cond_3

    .line 530
    new-instance p3, Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;

    invoke-direct {p3}, Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;-><init>()V

    .line 532
    :cond_3
    iput-object v5, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->host:Ljava/net/URL;

    .line 534
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v7

    iput-object v7, p3, Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;->fromPackage:Ljava/lang/String;

    iget-object v7, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 v8, 0x7

    new-array v8, v8, [Ljava/lang/Object;

    const-string v9, "sendPushResponse"

    aput-object v9, v8, v4

    const-string v4, "host"

    aput-object v4, v8, v6

    .line 536
    iget-object v4, p3, Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;->fromHost:Ljava/lang/String;

    aput-object v4, v8, v3

    const-string v3, "pkg"

    aput-object v3, v8, v2

    iget-object v2, p3, Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;->fromPackage:Ljava/lang/String;

    aput-object v2, v8, v0

    const-string v0, "dataId"

    aput-object v0, v8, v1

    iget-object v0, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    const/4 v1, 0x6

    aput-object v0, v8, v1

    invoke-interface {v7, v8}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 539
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    iget-object p3, p3, Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;->fromPackage:Ljava/lang/String;

    invoke-virtual {v0, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_5

    .line 540
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result p3

    if-eqz p3, :cond_5

    .line 541
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p0, p1, p2, p3, v6}, Lcom/taobao/accs/internal/ACCSManagerImpl;->sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;Ljava/lang/String;Z)Ljava/lang/String;

    goto :goto_2

    :cond_4
    :goto_1
    iget-object v7, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    new-array v1, v1, [Ljava/lang/Object;

    const-string v8, "sendPushResponse input null"

    aput-object v8, v1, v4

    aput-object p1, v1, v6

    aput-object p2, v1, v3

    const-string p1, "extraInfo"

    aput-object p1, v1, v2

    aput-object p3, v1, v0

    .line 507
    invoke-interface {v7, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    const-string p1, "accs"

    const-string p3, "send_fail"

    const-string v0, ""

    const-string v1, "1"

    const-string v2, "sendPushResponse null"

    .line 508
    invoke-static {p1, p3, v0, v1, v2}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    return-object v5

    :catchall_1
    move-exception p1

    const-string p3, "accs"

    const-string v0, "send_fail"

    .line 546
    iget-object v1, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->serviceId:Ljava/lang/String;

    const-string v2, "1"

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "push response "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 548
    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 546
    invoke-static {p3, v0, v1, v2, v3}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "sendPushResponse"

    const-string v1, "dataId"

    .line 549
    iget-object p2, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    filled-new-array {v0, v1, p2, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-interface {p3, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    :cond_5
    :goto_2
    return-object v5
.end method

.method public sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 486
    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;Ljava/lang/String;Z)Ljava/lang/String;
    .locals 9

    const/4 v0, 0x0

    if-nez p2, :cond_0

    :try_start_0
    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "sendRequest request null"

    .line 440
    invoke-interface {p1, p3}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const-string p1, "accs"

    const-string p3, "send_fail"

    const-string p4, "1"

    const-string v1, "request null"

    .line 441
    invoke-static {p1, p3, v0, p4, v1}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0

    .line 445
    :cond_0
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "sendRequest not in target process"

    .line 446
    invoke-interface {p1, p3}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-object v0

    .line 450
    :cond_1
    iget-object v1, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_2

    const-class v1, Lcom/taobao/accs/internal/ACCSManagerImpl;

    .line 451
    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    .line 453
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->b:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    .line 454
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1

    :cond_2
    :goto_0
    iget-object v1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 457
    invoke-virtual {v1}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v1

    .line 458
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    const-string p1, "accs"

    const-string p3, "send_fail"

    .line 459
    iget-object p4, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->serviceId:Ljava/lang/String;

    const-string v1, "1"

    const-string v3, "request appkey null"

    invoke-static {p1, p3, p4, v1, v3}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 p3, 0x3

    new-array p3, p3, [Ljava/lang/Object;

    const-string p4, "sendRequest appkey null"

    const/4 v1, 0x0

    aput-object p4, p3, v1

    const-string p4, "dataId"

    aput-object p4, p3, v2

    .line 462
    iget-object p4, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    const/4 v1, 0x2

    aput-object p4, p3, v1

    invoke-interface {p1, p3}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    return-object v0

    :cond_3
    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 465
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->a()V

    if-nez p3, :cond_4

    .line 466
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p3

    :cond_4
    move-object v5, p3

    iget-object v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    const-string v6, "2|"

    move-object v4, p1

    move-object v7, p2

    move v8, p4

    .line 467
    invoke-static/range {v3 .. v8}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/ACCSManager$AccsRequest;Z)Lcom/taobao/accs/data/Message;

    move-result-object p1

    .line 469
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p3

    if-eqz p3, :cond_5

    .line 470
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p3

    invoke-virtual {p3}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onSend()V

    :cond_5
    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 472
    invoke-virtual {p3, p1, v2}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p1

    if-eqz p2, :cond_6

    const-string p3, "accs"

    const-string p4, "send_fail"

    .line 475
    iget-object v0, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->serviceId:Ljava/lang/String;

    const-string v1, "1"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "request "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 477
    invoke-virtual {p1}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 475
    invoke-static {p3, p4, v0, v1, v2}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p4, "sendRequest"

    const-string v0, "dataId"

    .line 478
    iget-object v1, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    filled-new-array {p4, v0, v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-interface {p3, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    .line 481
    :cond_6
    :goto_1
    iget-object p1, p2, Lcom/taobao/accs/ACCSManager$AccsRequest;->dataId:Ljava/lang/String;

    return-object p1
.end method

.method public sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    const/4 v7, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    .line 425
    invoke-virtual/range {v0 .. v7}, Lcom/taobao/accs/internal/ACCSManagerImpl;->sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;
    .locals 9

    .line 431
    new-instance v8, Lcom/taobao/accs/ACCSManager$AccsRequest;

    const/4 v7, 0x0

    move-object v0, v8

    move-object v1, p2

    move-object v2, p3

    move-object v3, p4

    move-object v4, p5

    move-object v5, p6

    move-object/from16 v6, p7

    invoke-direct/range {v0 .. v7}, Lcom/taobao/accs/ACCSManager$AccsRequest;-><init>(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;Ljava/lang/String;)V

    move-object v0, p0

    move-object v1, p1

    .line 433
    invoke-virtual {p0, p1, v8}, Lcom/taobao/accs/internal/ACCSManagerImpl;->sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public setLoginInfo(Landroid/content/Context;Lcom/taobao/accs/ILoginInfo;)V
    .locals 1

    .line 649
    invoke-static {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    iget-object v0, v0, Lcom/taobao/accs/net/b;->m:Ljava/lang/String;

    invoke-virtual {p1, v0, p2}, Lcom/taobao/accs/client/GlobalClientInfo;->setLoginInfoImpl(Ljava/lang/String;Lcom/taobao/accs/ILoginInfo;)V

    return-void
.end method

.method public setMode(Landroid/content/Context;I)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 592
    invoke-static {p1, p2}, Lcom/taobao/accs/ACCSClient;->setEnvironment(Landroid/content/Context;I)V

    return-void
.end method

.method public setProxy(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 2

    const-string v0, "EMAS_ACCS_SDK"

    const/4 v1, 0x0

    .line 611
    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    .line 612
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "proxy_host"

    .line 613
    invoke-interface {p1, v0, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    :cond_0
    const-string p2, "proxy_port"

    .line 615
    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 616
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 6

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p3

    move-object v5, p4

    .line 622
    invoke-virtual/range {v0 .. v5}, Lcom/taobao/accs/internal/ACCSManagerImpl;->startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void
.end method

.method public startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 1

    if-eqz p5, :cond_0

    .line 629
    invoke-static {}, Lcom/taobao/accs/client/a;->a()Lcom/taobao/accs/client/a;

    move-result-object p3

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->d:Ljava/lang/String;

    .line 630
    invoke-static {p5}, Lcom/taobao/accs/utl/c;->a(Lcom/taobao/accs/IAppReceiver;)Lcom/taobao/accs/IAppReceiver;

    move-result-object p5

    .line 629
    invoke-virtual {p3, v0, p5}, Lcom/taobao/accs/client/a;->a(Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    .line 632
    :cond_0
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result p3

    if-nez p3, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "inapp only init in target process!"

    .line 633
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p5, "startInAppConnection"

    .line 636
    filled-new-array {p5, p2}, [Ljava/lang/Object;

    move-result-object p5

    invoke-interface {p3, p5}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 637
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p3

    if-eqz p3, :cond_2

    return-void

    :cond_2
    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 639
    invoke-virtual {p3}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3, p2}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result p3

    if-nez p3, :cond_3

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 640
    iput-object p4, p3, Lcom/taobao/accs/net/b;->a:Ljava/lang/String;

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 641
    iput-object p2, p3, Lcom/taobao/accs/net/b;->b:Ljava/lang/String;

    iget-object p3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 642
    iget-object p3, p3, Lcom/taobao/accs/net/b;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p3}, Lcom/taobao/accs/AccsClientConfig;->getAppSecret()Ljava/lang/String;

    invoke-static {p1, p2}, Lcom/taobao/accs/utl/UtilityImpl;->e(Landroid/content/Context;Ljava/lang/String;)V

    :cond_3
    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 645
    invoke-virtual {p1}, Lcom/taobao/accs/net/b;->a()V

    return-void
.end method

.method public unRegisterDataListener(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    .line 751
    invoke-static {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/taobao/accs/client/GlobalClientInfo;->unregisterListener(Ljava/lang/String;)V

    return-void
.end method

.method public unRegisterService(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    .line 731
    invoke-static {p1}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/taobao/accs/client/GlobalClientInfo;->unRegisterService(Ljava/lang/String;)V

    return-void
.end method

.method public unbindApp(Landroid/content/Context;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "unbindApp"

    .line 218
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->c:Z

    .line 220
    invoke-direct {p0, p1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;)Z

    move-result v1

    const/4 v2, 0x2

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    .line 221
    invoke-direct {p0, p1, v2, v0, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V

    return-void

    .line 224
    :cond_0
    invoke-direct {p0, p1, v2}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;I)Landroid/content/Intent;

    move-result-object v1

    .line 225
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 226
    invoke-static {v3, v1}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Landroid/content/Intent;)Lcom/taobao/accs/data/Message;

    move-result-object v1

    .line 227
    invoke-direct {p0, p1, v1, v2, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Lcom/taobao/accs/data/Message;IZ)V

    :cond_1
    return-void
.end method

.method public unbindService(Landroid/content/Context;Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "unbindService"

    const-string v2, "serviceId"

    .line 339
    filled-new-array {v1, v2, p2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 340
    invoke-direct {p0, p1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x6

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 341
    invoke-direct {p0, p1, v1, p2, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V

    return-void

    .line 344
    :cond_0
    invoke-direct {p0, p1, v1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;I)Landroid/content/Intent;

    move-result-object v0

    iget-object v3, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 345
    invoke-virtual {v3}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v3

    .line 346
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "appKey null"

    .line 347
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_1
    const-string v4, "appKey"

    .line 350
    invoke-virtual {v0, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 351
    invoke-virtual {v0, v2, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 353
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 354
    invoke-static {p2, v0}, Lcom/taobao/accs/data/Message;->c(Lcom/taobao/accs/net/b;Landroid/content/Intent;)Lcom/taobao/accs/data/Message;

    move-result-object p2

    const/4 v0, 0x0

    .line 355
    invoke-direct {p0, p1, p2, v1, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Lcom/taobao/accs/data/Message;IZ)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "unbindService not target process, ignored"

    .line 357
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public unbindUser(Landroid/content/Context;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "unBindUse"

    .line 283
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    .line 284
    invoke-direct {p0, p1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x4

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 285
    invoke-direct {p0, p1, v1, v0, v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;ILjava/lang/String;Ljava/lang/String;)V

    return-void

    .line 288
    :cond_0
    invoke-direct {p0, p1, v1}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;I)Landroid/content/Intent;

    move-result-object v0

    iget-object v2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 289
    invoke-virtual {v2}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v2

    .line 290
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "appKey null"

    .line 291
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_1
    const-string v3, "appKey"

    .line 294
    invoke-virtual {v0, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 296
    invoke-static {p1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 297
    invoke-static {v2, v0}, Lcom/taobao/accs/data/Message;->e(Lcom/taobao/accs/net/b;Landroid/content/Intent;)Lcom/taobao/accs/data/Message;

    move-result-object v0

    const/4 v2, 0x0

    .line 298
    invoke-direct {p0, p1, v0, v1, v2}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Landroid/content/Context;Lcom/taobao/accs/data/Message;IZ)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->e:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "unBindUser not target process, ignored"

    .line 300
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public updateConfig(Lcom/taobao/accs/AccsClientConfig;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    .line 764
    instance-of v1, v0, Lcom/taobao/accs/net/j;

    if-eqz v1, :cond_0

    .line 765
    check-cast v0, Lcom/taobao/accs/net/j;

    invoke-virtual {v0, p1}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/AccsClientConfig;)V

    :cond_0
    return-void
.end method
