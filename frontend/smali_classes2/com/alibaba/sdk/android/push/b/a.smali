.class public Lcom/alibaba/sdk/android/push/b/a;
.super Ljava/lang/Object;


# static fields
.field private static final a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

.field private static b:Landroid/content/Context;

.field private static c:Lcom/alibaba/sdk/android/push/b/a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "MPS:KeepLiveManager"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/b/a;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const/4 v0, 0x0

    sput-object v0, Lcom/alibaba/sdk/android/push/b/a;->b:Landroid/content/Context;

    sput-object v0, Lcom/alibaba/sdk/android/push/b/a;->c:Lcom/alibaba/sdk/android/push/b/a;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()Lcom/alibaba/sdk/android/push/b/a;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/b/a;->c:Lcom/alibaba/sdk/android/push/b/a;

    if-nez v0, :cond_0

    new-instance v0, Lcom/alibaba/sdk/android/push/b/a;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/b/a;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/push/b/a;->c:Lcom/alibaba/sdk/android/push/b/a;

    :cond_0
    sget-object v0, Lcom/alibaba/sdk/android/push/b/a;->c:Lcom/alibaba/sdk/android/push/b/a;

    return-object v0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 0

    sput-object p0, Lcom/alibaba/sdk/android/push/b/a;->b:Landroid/content/Context;

    sget-object p0, Lcom/alibaba/sdk/android/push/b/a;->c:Lcom/alibaba/sdk/android/push/b/a;

    if-nez p0, :cond_0

    invoke-static {}, Lcom/alibaba/sdk/android/push/b/a;->a()Lcom/alibaba/sdk/android/push/b/a;

    move-result-object p0

    sput-object p0, Lcom/alibaba/sdk/android/push/b/a;->c:Lcom/alibaba/sdk/android/push/b/a;

    :cond_0
    return-void
.end method


# virtual methods
.method public b()V
    .locals 7

    sget-object v0, Lcom/alibaba/sdk/android/push/b/a;->b:Landroid/content/Context;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/alibaba/sdk/android/push/b/a;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "Check KeepChannelService"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    :try_start_0
    sget-object v0, Lcom/alibaba/sdk/android/push/b/a;->b:Landroid/content/Context;

    const-string v1, "jobscheduler"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/job/JobScheduler;

    invoke-virtual {v0}, Landroid/app/job/JobScheduler;->getAllPendingJobs()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/job/JobInfo;

    invoke-virtual {v2}, Landroid/app/job/JobInfo;->getId()I

    move-result v3

    const v4, 0xdbe6b

    if-ne v3, v4, :cond_0

    invoke-virtual {v2}, Landroid/app/job/JobInfo;->getService()Landroid/content/ComponentName;

    move-result-object v3

    new-instance v4, Landroid/content/ComponentName;

    sget-object v5, Lcom/alibaba/sdk/android/push/b/a;->b:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const-class v6, Lcom/alibaba/sdk/android/push/channel/KeepChannelService;

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v3, v4}, Landroid/content/ComponentName;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    sget-object v1, Lcom/alibaba/sdk/android/push/b/a;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v3, "cancel Keep Channel Service"

    invoke-virtual {v1, v3}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    invoke-virtual {v2}, Landroid/app/job/JobInfo;->getId()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/job/JobScheduler;->cancel(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    sget-object v1, Lcom/alibaba/sdk/android/push/b/a;->a:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v2, "start KeepChannelService failed."

    invoke-virtual {v1, v2, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_1
    :goto_0
    return-void
.end method
