.class public Lcom/alibaba/ha/adapter/AliHaAdapter;
.super Ljava/lang/Object;
.source "AliHaAdapter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/adapter/AliHaAdapter$InstanceCreater;
    }
.end annotation


# static fields
.field public static final TAG:Ljava/lang/String; = "AliHaAdapter"

.field public static final mHAOSSBucketName:Ljava/lang/String; = "emasha-online"

.field public static final mHATLogHost:Ljava/lang/String; = "tlog-emas.aliyuncs.com"

.field public static final mUniversalHost:Ljava/lang/String; = "adash-emas.cn-hangzhou.aliyuncs.com"


# instance fields
.field public context:Landroid/content/Context;

.field public mOpenDebug:Z

.field public plugins:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/ha/adapter/Plugin;",
            ">;"
        }
    .end annotation
.end field

.field public preStarted:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->context:Landroid/content/Context;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->mOpenDebug:Z

    .line 55
    new-instance v1, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->preStarted:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 59
    invoke-virtual {p0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->openPublishEmasHa()V

    return-void
.end method

.method public synthetic constructor <init>(Lcom/alibaba/ha/adapter/AliHaAdapter$1;)V
    .locals 0

    .line 40
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/AliHaAdapter;-><init>()V

    return-void
.end method

.method private buildParam(Lcom/alibaba/ha/adapter/AliHaConfig;)Lcom/alibaba/ha/protocol/AliHaParam;
    .locals 3

    .line 250
    new-instance v0, Lcom/alibaba/ha/protocol/AliHaParam;

    invoke-direct {v0}, Lcom/alibaba/ha/protocol/AliHaParam;-><init>()V

    .line 251
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->application:Landroid/app/Application;

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    .line 252
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->context:Landroid/content/Context;

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    .line 253
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appKey:Ljava/lang/String;

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    .line 254
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appSecret:Ljava/lang/String;

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    .line 255
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->isAliyunos:Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 256
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, v0, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "@aliyunos"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    goto :goto_0

    .line 258
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, v0, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "@android"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    .line 260
    :goto_0
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appVersion:Ljava/lang/String;

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    .line 261
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->channel:Ljava/lang/String;

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    .line 262
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->userNick:Ljava/lang/String;

    iput-object v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->userNick:Ljava/lang/String;

    .line 263
    iget-boolean v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->initAsync:Z

    iput-boolean v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->initAsync:Z

    .line 264
    iget-wide v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->tlogFileMaxSize:J

    iput-wide v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->tlogFileMaxSize:J

    .line 265
    iget v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->noCollectionDataType:I

    iput v1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->noCollectionDataType:I

    .line 266
    iget-boolean p1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->enableInterceptNotMainThreadException:Z

    iput-boolean p1, v0, Lcom/alibaba/ha/protocol/AliHaParam;->enableInterceptNotMainThreadException:Z

    return-object v0
.end method

.method private changeTLogBucketName()V
    .locals 1

    const-string v0, "emasha-online"

    .line 363
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->changeBucketName(Ljava/lang/String;)V

    return-void
.end method

.method private changeTLogHost()V
    .locals 1

    const-string v0, "tlog-emas.aliyuncs.com"

    .line 359
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->changeHost(Ljava/lang/String;)V

    return-void
.end method

.method private getBizId()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 210
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->crashreporter:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "ha-crash"

    goto :goto_0

    :cond_0
    const-string v0, ""

    :goto_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 214
    sget-object v2, Lcom/alibaba/ha/adapter/Plugin;->apm:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    const-string v2, "_"

    if-eqz v1, :cond_2

    .line 215
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_1

    .line 216
    invoke-virtual {v0, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 218
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ha-apm"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_2
    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 221
    sget-object v3, Lcom/alibaba/ha/adapter/Plugin;->tlog:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 222
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_3

    .line 223
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 225
    :cond_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ha-tlog"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_4
    return-object v0
.end method

.method public static declared-synchronized getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;
    .locals 2

    const-class v0, Lcom/alibaba/ha/adapter/AliHaAdapter;

    monitor-enter v0

    .line 69
    :try_start_0
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter$InstanceCreater;->access$100()Lcom/alibaba/ha/adapter/AliHaAdapter;

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

.method private initAppStatus(Lcom/alibaba/ha/adapter/AliHaConfig;)V
    .locals 3

    .line 232
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getBizId()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    .line 234
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    const-string v2, "_aliyun_biz_id"

    .line 235
    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 236
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->getInstance()Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    move-result-object v0

    .line 237
    iget-object p1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->application:Landroid/app/Application;

    invoke-virtual {v0, p1, v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->init(Landroid/app/Application;Ljava/util/Map;)V

    .line 239
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusRegHelper;->registerAppStatusCallbacks(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;)V

    :cond_0
    return-void
.end method

.method private isLegal(Lcom/alibaba/ha/adapter/AliHaConfig;)Ljava/lang/Boolean;
    .locals 4

    const/4 v0, 0x0

    .line 278
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    const-string v1, "AliHaAdapter"

    if-nez p1, :cond_0

    const-string p1, "config is null "

    .line 277
    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0

    .line 281
    :cond_0
    iget-object v2, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->application:Landroid/app/Application;

    if-nez v2, :cond_1

    const-string p1, "application is null "

    .line 282
    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0

    .line 285
    :cond_1
    iget-object v2, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->context:Landroid/content/Context;

    if-nez v2, :cond_2

    const-string p1, "context is null "

    .line 286
    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0

    .line 289
    :cond_2
    iget-object v2, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appKey:Ljava/lang/String;

    if-eqz v2, :cond_5

    iget-object v2, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appSecret:Ljava/lang/String;

    if-eqz v2, :cond_5

    iget-object v2, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appVersion:Ljava/lang/String;

    if-nez v2, :cond_3

    goto :goto_0

    :cond_3
    iget-object v2, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 295
    sget-object v3, Lcom/alibaba/ha/adapter/Plugin;->tlog:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v2, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    iget-object v2, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->rsaPublicKey:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string p1, "rsaPublicKey is empty "

    .line 296
    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0

    .line 301
    :cond_4
    iget-object p1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->context:Landroid/content/Context;

    iput-object p1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->context:Landroid/content/Context;

    const/4 p1, 0x1

    .line 303
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1

    .line 290
    :cond_5
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "config is unlegal, ha plugin start failure  appKey is "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appKey:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " appVersion is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appVersion:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " appSecret is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object p1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->appSecret:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0
.end method


# virtual methods
.method public addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 400
    invoke-static {p1, p2}, Lcom/alibaba/ha/adapter/service/crash/CrashService;->addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V

    .line 401
    invoke-static {p1, p2}, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public addPlugin(Lcom/alibaba/ha/adapter/Plugin;)V
    .locals 2

    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 76
    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 77
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "plugin add to list success, plugin name is "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "AliHaAdapter"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 78
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 80
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->crashreporter:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0, p1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 81
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->olympic:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 82
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->olympic:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 85
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->watch:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 86
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->watch:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 90
    :cond_1
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->apm:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0, p1}, Ljava/lang/Enum;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 92
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->networkmonitor:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {p1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 93
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->networkmonitor:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    return-void
.end method

.method public changeAppSecretKey(Ljava/lang/String;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 395
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v0

    iput-object p1, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->appSecret:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public changeHost(Ljava/lang/String;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 352
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/crash/CrashService;->changeHost(Ljava/lang/String;)V

    .line 353
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/tbrest/SendService;->changeHost(Ljava/lang/String;)V

    .line 354
    invoke-static {p1}, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->changeHost(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public isOpenDebug()Z
    .locals 1

    iget-boolean v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->mOpenDebug:Z

    return v0
.end method

.method public openDebug(Ljava/lang/Boolean;)V
    .locals 1

    .line 311
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->OpenDebug(Ljava/lang/Boolean;)V

    .line 312
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/apm/APMService;->openDebug(Ljava/lang/Boolean;)V

    .line 313
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-static {v0}, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->openDebug(Z)V

    .line 314
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    iput-boolean p1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->mOpenDebug:Z

    return-void
.end method

.method public openHttp(Ljava/lang/Boolean;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 372
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v0

    iput-object p1, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->openHttp:Ljava/lang/Boolean;

    .line 373
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-static {v0}, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->openHttp(Z)V

    .line 374
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->openHttp(Z)V

    :cond_0
    return-void
.end method

.method public openPublishEmasHa()V
    .locals 1

    const-string v0, "adash-emas.cn-hangzhou.aliyuncs.com"

    .line 383
    invoke-virtual {p0, v0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->changeHost(Ljava/lang/String;)V

    .line 384
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->changeTLogHost()V

    .line 385
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/AliHaAdapter;->changeTLogBucketName()V

    return-void
.end method

.method public preStart(Landroid/app/Application;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->preStarted:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 114
    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 115
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusRegHelper;->registeActivityLifecycleCallbacks(Landroid/app/Application;)V

    .line 117
    new-instance v0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;

    invoke-direct {v0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;-><init>()V

    invoke-virtual {p1, v0}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    :cond_0
    return-void
.end method

.method public removePlugin(Lcom/alibaba/ha/adapter/Plugin;)V
    .locals 2

    if-eqz p1, :cond_0

    .line 104
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "plugin remove from list success, plugin name is "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "AliHaAdapter"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 105
    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public reportCrashError(Ljava/lang/Throwable;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->context:Landroid/content/Context;

    .line 414
    invoke-static {v0, p1}, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->sendCrashError(Landroid/content/Context;Ljava/lang/Throwable;)V

    return-void
.end method

.method public reportCustomError(Ljava/lang/Throwable;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->context:Landroid/content/Context;

    .line 410
    invoke-static {v0, p1}, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->sendBizError(Landroid/content/Context;Ljava/lang/Throwable;)V

    return-void
.end method

.method public setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V
    .locals 0

    .line 405
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/crash/CrashService;->setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V

    .line 406
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V

    return-void
.end method

.method public start(Lcom/alibaba/ha/adapter/AliHaConfig;)Ljava/lang/Boolean;
    .locals 11

    const-string v0, "AliHaAdapter"

    const-string v1, "init send service success, appId is "

    .line 127
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/AliHaAdapter;->isLegal(Lcom/alibaba/ha/adapter/AliHaConfig;)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    const/4 v3, 0x0

    .line 128
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    if-nez v2, :cond_0

    return-object v3

    .line 131
    :cond_0
    iget-object v2, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->application:Landroid/app/Application;

    invoke-virtual {p0, v2}, Lcom/alibaba/ha/adapter/AliHaAdapter;->preStart(Landroid/app/Application;)V

    .line 133
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/AliHaAdapter;->buildParam(Lcom/alibaba/ha/adapter/AliHaConfig;)Lcom/alibaba/ha/protocol/AliHaParam;

    move-result-object v2

    :try_start_0
    iget-object v4, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 136
    sget-object v5, Lcom/alibaba/ha/adapter/Plugin;->crashreporter:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v4, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 137
    new-instance v1, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;

    invoke-direct {v1}, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;-><init>()V

    .line 138
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v4

    invoke-virtual {v4, v2, v1}, Lcom/alibaba/ha/core/AliHaCore;->startWithPlugin(Lcom/alibaba/ha/protocol/AliHaParam;Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    goto :goto_0

    .line 140
    :cond_1
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v4

    iget-object v5, v2, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    iget-object v6, v2, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    iget-object v7, v2, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    iget-object v8, v2, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    iget-object v9, v2, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    iget-object v10, v2, Lcom/alibaba/ha/protocol/AliHaParam;->userNick:Ljava/lang/String;

    invoke-virtual/range {v4 .. v10}, Lcom/alibaba/sdk/android/tbrest/SendService;->init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 142
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v4

    iget-object v5, v2, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    iput-object v5, v4, Lcom/alibaba/sdk/android/tbrest/SendService;->appSecret:Ljava/lang/String;

    .line 144
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, v2, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " appKey is "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, v2, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " appVersion is "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, v2, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " channel is "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, v2, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " userNick is "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, v2, Lcom/alibaba/ha/protocol/AliHaParam;->userNick:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 149
    :goto_0
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget v4, v2, Lcom/alibaba/ha/protocol/AliHaParam;->noCollectionDataType:I

    invoke-virtual {v1, v4}, Lcom/alibaba/sdk/android/tbrest/SendService;->setNoCollectionDataType(I)V

    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 152
    sget-object v4, Lcom/alibaba/ha/adapter/Plugin;->ut:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 153
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->ut:Lcom/alibaba/ha/adapter/Plugin;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory;->createPlugin(Lcom/alibaba/ha/adapter/Plugin;)Lcom/alibaba/ha/protocol/AliHaPlugin;

    move-result-object v1

    .line 154
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/alibaba/ha/core/AliHaCore;->registPlugin(Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    :cond_2
    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 157
    sget-object v4, Lcom/alibaba/ha/adapter/Plugin;->tlog:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 158
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->tlog:Lcom/alibaba/ha/adapter/Plugin;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory;->createPlugin(Lcom/alibaba/ha/adapter/Plugin;)Lcom/alibaba/ha/protocol/AliHaPlugin;

    move-result-object v1

    .line 159
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/alibaba/ha/core/AliHaCore;->registPlugin(Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    .line 160
    iget-object v1, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->rsaPublicKey:Ljava/lang/String;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->changeRasPublishKey(Ljava/lang/String;)V

    :cond_3
    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 163
    sget-object v4, Lcom/alibaba/ha/adapter/Plugin;->watch:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 164
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->watch:Lcom/alibaba/ha/adapter/Plugin;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory;->createPlugin(Lcom/alibaba/ha/adapter/Plugin;)Lcom/alibaba/ha/protocol/AliHaPlugin;

    move-result-object v1

    .line 165
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/alibaba/ha/core/AliHaCore;->registPlugin(Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    :cond_4
    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 168
    sget-object v4, Lcom/alibaba/ha/adapter/Plugin;->apm:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 169
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->apm:Lcom/alibaba/ha/adapter/Plugin;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory;->createPlugin(Lcom/alibaba/ha/adapter/Plugin;)Lcom/alibaba/ha/protocol/AliHaPlugin;

    move-result-object v1

    .line 170
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/alibaba/ha/core/AliHaCore;->registPlugin(Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    :cond_5
    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 173
    sget-object v4, Lcom/alibaba/ha/adapter/Plugin;->networkmonitor:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 174
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->networkmonitor:Lcom/alibaba/ha/adapter/Plugin;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory;->createPlugin(Lcom/alibaba/ha/adapter/Plugin;)Lcom/alibaba/ha/protocol/AliHaPlugin;

    move-result-object v1

    .line 175
    instance-of v4, v1, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;

    if-eqz v4, :cond_6

    .line 176
    move-object v4, v1

    check-cast v4, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;

    iget-object v5, p1, Lcom/alibaba/ha/adapter/AliHaConfig;->rsaPublicKey:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;->setRsaPublishKey(Ljava/lang/String;)V

    .line 178
    :cond_6
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/alibaba/ha/core/AliHaCore;->registPlugin(Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    :cond_7
    iget-object v1, p0, Lcom/alibaba/ha/adapter/AliHaAdapter;->plugins:Ljava/util/List;

    .line 181
    sget-object v4, Lcom/alibaba/ha/adapter/Plugin;->olympic:Lcom/alibaba/ha/adapter/Plugin;

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 182
    sget-object v1, Lcom/alibaba/ha/adapter/Plugin;->olympic:Lcom/alibaba/ha/adapter/Plugin;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory;->createPlugin(Lcom/alibaba/ha/adapter/Plugin;)Lcom/alibaba/ha/protocol/AliHaPlugin;

    move-result-object v1

    .line 183
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v4

    invoke-virtual {v4, v1}, Lcom/alibaba/ha/core/AliHaCore;->registPlugin(Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    .line 187
    :cond_8
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore;->getInstance()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v1

    invoke-virtual {v1, v2}, Lcom/alibaba/ha/core/AliHaCore;->start(Lcom/alibaba/ha/protocol/AliHaParam;)V

    .line 191
    iget-object v1, v2, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    new-instance v2, Lcom/alibaba/ha/adapter/service/activity/AdapterActivityLifeCycle;

    invoke-direct {v2}, Lcom/alibaba/ha/adapter/service/activity/AdapterActivityLifeCycle;-><init>()V

    invoke-virtual {v1, v2}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    .line 198
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/AliHaAdapter;->initAppStatus(Lcom/alibaba/ha/adapter/AliHaConfig;)V

    const/4 p1, 0x1

    .line 200
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    const-string v1, "start plugin error "

    .line 202
    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-object v3
.end method

.method public updateChannel(Ljava/lang/String;)V
    .locals 0

    .line 343
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/crash/CrashService;->updateChannel(Ljava/lang/String;)V

    return-void
.end method

.method public updateUserNick(Ljava/lang/String;)V
    .locals 0

    .line 333
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/crash/CrashService;->updateUserNick(Ljava/lang/String;)V

    .line 334
    invoke-static {p1}, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->updateUserNick(Ljava/lang/String;)V

    .line 335
    invoke-static {p1}, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$Service;->updateUserNick(Ljava/lang/String;)V

    return-void
.end method

.method public updateVersion(Ljava/lang/String;)V
    .locals 0

    .line 325
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/crash/CrashService;->updateApppVersion(Ljava/lang/String;)V

    return-void
.end method
