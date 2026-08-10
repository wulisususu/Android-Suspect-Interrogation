.class public Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method public static synthetic $r8$lambda$VCq2FN9ow-h8L_8PZ3VNteSsl08(Lcom/aliyun/emas/apm/events/Event;)V
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;->a(Lcom/aliyun/emas/apm/events/Event;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Lcom/aliyun/emas/apm/ApmOptions;)Lcom/alibaba/ha/adapter/AliHaConfig;
    .locals 3

    .line 15
    new-instance v0, Lcom/alibaba/ha/adapter/AliHaConfig;

    invoke-direct {v0}, Lcom/alibaba/ha/adapter/AliHaConfig;-><init>()V

    .line 16
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getAppKey()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->appKey:Ljava/lang/String;

    .line 17
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getAppSecret()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->appSecret:Ljava/lang/String;

    .line 18
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getAppRsaSecret()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->rsaPublicKey:Ljava/lang/String;

    .line 19
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->application:Landroid/app/Application;

    .line 20
    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->context:Landroid/content/Context;

    .line 21
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->isAliyunos:Ljava/lang/Boolean;

    .line 22
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getChannel()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->channel:Ljava/lang/String;

    .line 23
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getUserNick()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->userNick:Ljava/lang/String;

    .line 24
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object v1

    invoke-static {v1}, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->appVersion:Ljava/lang/String;

    .line 25
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getNoCollectionDataType()I

    move-result v1

    iput v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->noCollectionDataType:I

    .line 26
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getProductOptions()Ljava/util/List;

    move-result-object p0

    const-wide/16 v1, 0x14

    .line 27
    iput-wide v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->tlogFileMaxSize:J

    .line 28
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/ApmProductOptions;

    .line 29
    instance-of v2, v1, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;

    if-eqz v2, :cond_0

    .line 30
    check-cast v1, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;->getRemoteLogFileMaxSize()I

    move-result v1

    int-to-long v1, v1

    iput-wide v1, v0, Lcom/alibaba/ha/adapter/AliHaConfig;->tlogFileMaxSize:J

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method static a(Lcom/aliyun/emas/apm/ApmContext;ZZLcom/aliyun/emas/apm/events/Subscriber;)Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;
    .locals 2

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v0

    invoke-static {v0}, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;->a(Lcom/aliyun/emas/apm/ApmOptions;)Lcom/alibaba/ha/adapter/AliHaConfig;

    move-result-object v0

    if-eqz p1, :cond_0

    .line 3
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p1

    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->tlog:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {p1, v1}, Lcom/alibaba/ha/adapter/AliHaAdapter;->addPlugin(Lcom/alibaba/ha/adapter/Plugin;)V

    :cond_0
    if-eqz p2, :cond_1

    .line 6
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p1

    sget-object p2, Lcom/alibaba/ha/adapter/Plugin;->apm:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {p1, p2}, Lcom/alibaba/ha/adapter/AliHaAdapter;->addPlugin(Lcom/alibaba/ha/adapter/Plugin;)V

    .line 8
    :cond_1
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p1

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->isOpenDebug()Z

    move-result p0

    invoke-static {p0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->openDebug(Ljava/lang/Boolean;)V

    .line 9
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object p0

    invoke-virtual {p0, v0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->start(Lcom/alibaba/ha/adapter/AliHaConfig;)Ljava/lang/Boolean;

    .line 11
    new-instance p0, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog$$ExternalSyntheticLambda0;

    invoke-direct {p0}, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog$$ExternalSyntheticLambda0;-><init>()V

    const-class p1, Lcom/aliyun/emas/apm/user/UserNick;

    invoke-interface {p3, p1, p0}, Lcom/aliyun/emas/apm/events/Subscriber;->subscribe(Ljava/lang/Class;Lcom/aliyun/emas/apm/events/EventHandler;)V

    .line 13
    new-instance p0, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;

    invoke-direct {p0}, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;-><init>()V

    return-object p0
.end method

.method private static a(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    const-string v0, "0.0"

    .line 31
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 32
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    const/4 v2, 0x0

    .line 34
    :try_start_0
    invoke-virtual {p0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p0

    .line 35
    iget-object p0, p0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p0, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, p0

    :catch_0
    :goto_0
    return-object v0
.end method

.method private static synthetic a(Lcom/aliyun/emas/apm/events/Event;)V
    .locals 1

    .line 14
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object v0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/events/Event;->getPayload()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/aliyun/emas/apm/user/UserNick;

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/user/UserNick;->getUserNick()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->updateUserNick(Ljava/lang/String;)V

    return-void
.end method
