.class public Lcom/alibaba/sdk/android/push/noonesdk/PushServiceFactory;
.super Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getCloudPushService()Lcom/alibaba/sdk/android/push/CloudPushService;
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/a/b;->a()Lcom/alibaba/sdk/android/push/a/b;

    move-result-object v0

    return-object v0
.end method

.method public static getPushControlService()Lcom/alibaba/sdk/android/push/PushControlService;
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/a/e;->a()Lcom/alibaba/sdk/android/push/a/e;

    move-result-object v0

    return-object v0
.end method

.method public static init(Landroid/content/Context;)V
    .locals 2

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    instance-of v0, p0, Landroid/app/Application;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Landroid/app/Application;

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Landroid/app/Application;)V

    :cond_0
    invoke-static {p0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Landroid/content/Context;)V

    invoke-static {}, Lcom/alibaba/sdk/android/push/a/b;->a()Lcom/alibaba/sdk/android/push/a/b;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/push/a/b;->a(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-static {p0, v1}, Lcom/taobao/accs/ACCSClient;->enableChannelProcess(Landroid/content/Context;Z)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/push/a/b;->setPushIntentService(Ljava/lang/Class;)V

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/a;->a()Lcom/alibaba/sdk/android/push/e/a;

    move-result-object p0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/e/a;->b()V

    return-void
.end method

.method public static init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    instance-of v0, p0, Landroid/app/Application;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Landroid/app/Application;

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Landroid/app/Application;)V

    :cond_0
    invoke-static {p0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Landroid/content/Context;)V

    invoke-static {}, Lcom/alibaba/sdk/android/push/a/b;->a()Lcom/alibaba/sdk/android/push/a/b;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/push/a/b;->a(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/push/a/b;->setAppkey(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lcom/alibaba/sdk/android/push/a/b;->setAppSecret(Ljava/lang/String;)V

    const/4 p0, 0x0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/push/a/b;->setPushIntentService(Ljava/lang/Class;)V

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/a;->a()Lcom/alibaba/sdk/android/push/e/a;

    move-result-object p0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/e/a;->b()V

    return-void
.end method

.method public static init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-static {p0, p3}, Lcom/taobao/accs/ACCSClient;->enableChannelProcess(Landroid/content/Context;Z)V

    invoke-static {p0, p1, p2}, Lcom/alibaba/sdk/android/push/noonesdk/PushServiceFactory;->init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static init(Landroid/content/Context;Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    invoke-static {p0, p1}, Lcom/taobao/accs/ACCSClient;->enableChannelProcess(Landroid/content/Context;Z)V

    invoke-static {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushServiceFactory;->init(Landroid/content/Context;)V

    return-void
.end method

.method public static init(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;)V
    .locals 4

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Landroid/app/Application;)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Landroid/content/Context;)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->isDisableForegroundCheck()Z

    move-result v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Z)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getPushHost()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->a(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getAccsAppConnectHost()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->b(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getAccsSilentConnectHost()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/a/b;->c(Ljava/lang/String;)V

    invoke-static {}, Lcom/alibaba/sdk/android/push/a/b;->a()Lcom/alibaba/sdk/android/push/a/b;

    move-result-object v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getApplication()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/a/b;->a(Landroid/content/Context;)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/a/b;->setPushIntentService(Ljava/lang/Class;)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getAppKey()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getAppKey()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/a/b;->setAppkey(Ljava/lang/String;)V

    :cond_0
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getAppSecret()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getAppSecret()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/a/b;->setAppSecret(Ljava/lang/String;)V

    :cond_1
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getLargeIconDownloadListener()Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getLargeIconDownloadListener()Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/a/b;->setLargeIconDownloadListener(Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;)V

    :cond_2
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->isDisableChannelProcess()Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/taobao/accs/ACCSClient;->enableChannelProcess(Landroid/content/Context;Z)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->isDisableChannelProcessHeartbeat()Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/taobao/accs/ACCSClient;->enableChannelProcessHeartbeat(Landroid/content/Context;Z)V

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/a;->a()Lcom/alibaba/sdk/android/push/e/a;

    move-result-object v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->isLoopStartChannel()Z

    move-result v1

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->getLoopInterval()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lcom/alibaba/sdk/android/push/e/a;->a(ZJ)V

    return-void
.end method
